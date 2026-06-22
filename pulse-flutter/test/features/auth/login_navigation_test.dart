import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/di/app_scope.dart';
import 'package:pulse/core/theme/pulse_theme.dart';
import 'package:pulse/features/auth/login_screen.dart';
import 'package:pulse/features/auth/register_screen.dart';

import '../../support/test_dependencies.dart';

void main() {
  testWidgets('login screen opens register screen', (tester) async {
    final deps = buildTestDependencies((_) async => jsonResponse('{}'));

    await tester.pumpWidget(
      AppScope(
        dependencies: deps,
        child: MaterialApp(
          theme: PulseTheme.light(),
          home: LoginScreen(authService: deps.authService),
        ),
      ),
    );

    await tester.tap(find.text('Create account'));
    await tester.pumpAndSettle();

    expect(find.byType(RegisterScreen), findsOneWidget);
  });
}
