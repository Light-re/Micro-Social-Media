import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/theme/pulse_theme.dart';
import 'package:pulse/features/auth/auth_service.dart';
import 'package:pulse/features/auth/data/auth_api_repository.dart';
import 'package:pulse/features/auth/data/auth_response.dart';
import 'package:pulse/features/auth/data/session_repository.dart';
import 'package:pulse/features/auth/register_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:pulse/core/database/app_database.dart';
import 'package:pulse/core/network/api_client.dart';

class _FakeAuthApiRepository extends AuthApiRepository {
  _FakeAuthApiRepository() : super(ApiClient(baseUrl: 'http://test'));

  @override
  Future<AuthResponse> register({
    required String email,
    required String username,
    required String password,
  }) async {
    return AuthResponse(
      token: 'jwt-token',
      userId: 'user-1',
      email: 'dev@pulse.test',
      username: username,
    );
  }
}

void main() {
  setUpAll(() {
    sqfliteFfiInit();
  });

  testWidgets('register shows validation message for short password', (tester) async {
    final appDatabase = AppDatabase(databaseFactory: databaseFactoryFfi);
    final authService = AuthService(
      _FakeAuthApiRepository(),
      SessionRepository(appDatabase),
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: PulseTheme.light(),
        home: RegisterScreen(authService: authService),
      ),
    );

    await tester.enterText(find.byType(TextFormField).at(0), 'dev@pulse.test');
    await tester.enterText(find.byType(TextFormField).at(1), 'devuser');
    await tester.enterText(find.byType(TextFormField).at(2), 'short');
    await tester.tap(find.widgetWithText(FilledButton, 'Create account'));
    await tester.pumpAndSettle();

    expect(find.text('Password must be at least 8 characters'), findsOneWidget);

    await appDatabase.close();
  });
}
