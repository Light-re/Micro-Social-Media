import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pulse/core/database/app_database.dart';
import 'package:pulse/core/network/api_client.dart';
import 'package:pulse/core/network/api_exception.dart';
import 'package:pulse/features/auth/auth_service.dart';
import 'package:pulse/features/auth/data/auth_repository.dart';
import 'package:pulse/features/auth/data/session_repository.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

AuthService buildService(
  MockClientHandler handler,
  SessionRepository sessionRepository,
) {
  final apiClient = ApiClient(
    httpClient: MockClient(handler),
    baseUrl: 'http://test.local',
    tokenProvider: () async => null,
  );
  return AuthService(
    authRepository: AuthRepository(apiClient),
    sessionRepository: sessionRepository,
  );
}

void main() {
  setUpAll(sqfliteFfiInit);

  late AppDatabase database;
  late SessionRepository sessionRepository;

  setUp(() async {
    database = AppDatabase(databaseFactory: databaseFactoryFfi);
    sessionRepository = SessionRepository(database);
    await sessionRepository.clearSession();
  });

  tearDown(() async => database.close());

  test('login persists the returned session', () async {
    const responseBody = '{"token":"jwt","userId":"user-1",'
        '"email":"dev@pulse.test","username":"devuser"}';
    final service = buildService(
      (_) async => http.Response(responseBody, 200),
      sessionRepository,
    );

    final result = await service.login('dev@pulse.test', 'secret123');

    expect(result.userId, 'user-1');
    expect(await service.currentUserId(), 'user-1');
  });

  test('login surfaces ApiException and stores nothing on failure', () async {
    final service = buildService(
      (_) async => http.Response('{"message":"Bad credentials"}', 401),
      sessionRepository,
    );

    await expectLater(
      service.login('dev@pulse.test', 'wrong'),
      throwsA(isA<ApiException>()),
    );
    expect(await service.currentUserId(), isNull);
  });
}
