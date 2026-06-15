import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/config/api_config.dart';
import 'package:pulse/core/strings/app_strings.dart';
import 'package:pulse/core/theme/pulse_colors.dart';
import 'package:pulse/features/feed/feed_screen.dart';
import 'package:pulse/features/home/welcome_screen.dart';
import 'package:pulse/main.dart';

void main() {
  testWidgets('shows migrated welcome message and backend url', (tester) async {
    await tester.pumpWidget(const PulseApp());

    expect(find.text(AppStrings.welcomeMessage), findsOneWidget);
    expect(find.text(ApiConfig.emulatorBaseUrl), findsOneWidget);
    expect(find.byType(WelcomeScreen), findsOneWidget);
  });

  testWidgets('shows empty feed message when no posts exist', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: FeedScreen()));

    expect(find.text(AppStrings.feedTitle), findsOneWidget);
    expect(find.text(AppStrings.feedEmptyMessage), findsOneWidget);
    expect(find.text(AppStrings.feedEmptySubtext), findsOneWidget);
    expect(find.byIcon(Icons.rss_feed), findsOneWidget);
  });

  test('AppStrings match legacy pulse-android strings.xml', () {
    expect(AppStrings.appName, 'Pulse');
    expect(AppStrings.welcomeMessage, 'Pulse — Sprint 0 skeleton');
    expect(AppStrings.feedTitle, 'Feed');
    expect(AppStrings.feedEmptyMessage, 'Der Feed ist leer.');
    expect(AppStrings.feedEmptySubtext, 'Sobald neue Beiträge verfügbar sind, erscheinen sie hier.');
  });

  test('PulseColors match legacy pulse-android colors.xml', () {
    expect(PulseColors.purple500, const Color(0xFF6200EE));
    expect(PulseColors.white, const Color(0xFFFFFFFF));
  });
}
