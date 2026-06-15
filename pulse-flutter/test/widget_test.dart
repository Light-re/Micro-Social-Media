import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/strings/app_strings.dart';
import 'package:pulse/core/theme/pulse_colors.dart';
import 'package:pulse/core/theme/pulse_theme.dart';
import 'package:pulse/core/di/app_scope.dart';
import 'package:pulse/features/auth/login_screen.dart';
import 'package:pulse/features/auth/register_screen.dart';
import 'package:pulse/features/feed/compose_screen.dart';
import 'package:pulse/features/home/home_shell.dart';
import 'package:pulse/features/home/welcome_screen.dart';
import 'package:pulse/main.dart';

import 'support/test_dependencies.dart';

void main() {
  PulseApp buildApp() {
    return PulseApp(
      dependencies: buildTestDependencies((_) async => jsonResponse('{}')),
    );
  }

  testWidgets('shows Pulse welcome screen', (tester) async {
    await tester.pumpWidget(buildApp());

    expect(find.text('Pulse'), findsOneWidget);
    expect(find.text(AppStrings.welcomeTagline), findsOneWidget);
    expect(find.text('Get started'), findsOneWidget);
    expect(find.byType(WelcomeScreen), findsOneWidget);
  });

  testWidgets('welcome routes to login', (tester) async {
    await tester.pumpWidget(buildApp());

    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('Welcome back'), findsOneWidget);
  });

  testWidgets('welcome routes to register', (tester) async {
    await tester.pumpWidget(buildApp());

    await tester.tap(find.text('Create account'));
    await tester.pumpAndSettle();

    expect(find.byType(RegisterScreen), findsOneWidget);
    expect(find.text('Join Pulse'), findsOneWidget);
  });

  testWidgets('home shell opens compose from tab bar', (tester) async {
    final deps = buildTestDependencies((request) async {
      if (request.url.path == '/api/posts/feed') {
        return jsonResponse('{"posts":[]}');
      }
      return jsonResponse('{}');
    });

    await tester.pumpWidget(
      AppScope(
        dependencies: deps,
        child: MaterialApp(theme: PulseTheme.light(), home: const HomeShell()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Pulse'), findsOneWidget);

    await tester.tap(find.text('Post'));
    await tester.pumpAndSettle();

    expect(find.byType(ComposeScreen), findsOneWidget);
    expect(find.text('New post'), findsOneWidget);
  });

  test('AppStrings expose Pulse copy', () {
    expect(AppStrings.appName, 'Pulse');
    expect(AppStrings.welcomeTagline, 'Social, simplified.');
  });

  test('PulseColors use muted coral accent', () {
    expect(PulseColors.coral, const Color(0xFFE07373));
    expect(PulseColors.lightBackground, const Color(0xFFF2F2F7));
    expect(PulseColors.darkBackground, const Color(0xFF000000));
  });
}
