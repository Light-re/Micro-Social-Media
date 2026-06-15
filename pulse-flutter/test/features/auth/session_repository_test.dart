import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:pulse/core/database/app_database.dart';
import 'package:pulse/features/auth/data/session_record.dart';
import 'package:pulse/features/auth/data/session_repository.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
  });

  group('SessionRepository', () {
    late AppDatabase appDatabase;
    late SessionRepository repository;

    setUp(() async {
      appDatabase = AppDatabase(databaseFactory: databaseFactoryFfi);
      repository = SessionRepository(appDatabase);
    });

    tearDown(() async {
      await appDatabase.close();
    });

    test('returns null when no session is stored', () async {
      expect(await repository.getSession(), isNull);
    });

    test('saves and reads session data', () async {
      final session = SessionRecord(
        userId: 'user-1',
        email: 'dev@pulse.test',
        username: 'devuser',
        token: 'jwt-token',
        savedAt: DateTime.utc(2026, 6, 15, 10),
      );

      await repository.saveSession(session);
      final loaded = await repository.getSession();

      expect(loaded, isNotNull);
      expect(loaded!.userId, session.userId);
      expect(loaded.email, session.email);
      expect(loaded.username, session.username);
      expect(loaded.token, session.token);
    });

    test('clears stored session', () async {
      await repository.saveSession(
        SessionRecord(
          userId: 'user-1',
          email: 'dev@pulse.test',
          username: 'devuser',
          token: 'jwt-token',
          savedAt: DateTime.utc(2026, 6, 15, 10),
        ),
      );

      await repository.clearSession();

      expect(await repository.getSession(), isNull);
    });
  });
}
