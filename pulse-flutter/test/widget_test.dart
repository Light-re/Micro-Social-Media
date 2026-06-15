import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/config/api_config.dart';
import 'package:pulse/core/strings/app_strings.dart';
import 'package:pulse/core/theme/pulse_colors.dart';
import 'package:pulse/features/home/welcome_screen.dart';
import 'package:pulse/main.dart';

void main() {
  testWidgets('shows migrated welcome message and backend url', (tester) async {
    await tester.pumpWidget(const PulseApp());

    expect(find.text(AppStrings.welcomeMessage), findsOneWidget);
    expect(find.text(ApiConfig.emulatorBaseUrl), findsOneWidget);
    expect(find.byType(WelcomeScreen), findsOneWidget);
  });

  test('AppStrings match legacy pulse-android strings.xml', () {
    expect(AppStrings.appName, 'Pulse');
    expect(AppStrings.welcomeMessage, 'Pulse — Sprint 0 skeleton');
  });

  test('PulseColors match legacy pulse-android colors.xml', () {
    expect(PulseColors.purple500, const Color(0xFF6200EE));
    expect(PulseColors.white, const Color(0xFFFFFFFF));
  });
}
