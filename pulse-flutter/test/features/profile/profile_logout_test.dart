import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/di/app_scope.dart';
import 'package:pulse/core/theme/pulse_theme.dart';
import 'package:pulse/features/auth/data/session_record.dart';
import 'package:pulse/features/auth/login_screen.dart';
import 'package:pulse/features/profile/profile_screen.dart';

import '../../support/test_dependencies.dart';

void main() {
  testWidgets('logout clears session and opens login', (tester) async {
    final session = SessionRecord(
      userId: 'user-1',
      email: 'dev@pulse.test',
      username: 'devuser',
      token: 'jwt-token',
      savedAt: DateTime.utc(2026, 6, 15, 10),
    );

    final deps = buildTestDependencies(
      (request) async {
        if (request.url.path == '/api/users/me') {
          return jsonResponse(
            '{"id":"user-1","email":"dev@pulse.test","username":"devuser","bio":"Hello"}',
          );
        }
        return jsonResponse('{}');
      },
      session: session,
    );

    await tester.pumpWidget(
      AppScope(
        dependencies: deps,
        child: MaterialApp(
          theme: PulseTheme.light(),
          home: ProfileScreen(
            authService: deps.authService,
            userService: deps.userService,
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('devuser'), findsOneWidget);

    await tester.tap(find.byTooltip('Log out'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(await deps.authService.currentSession(), isNull);
  });
}
