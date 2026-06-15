import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/strings/app_strings.dart';
import 'package:pulse/core/theme/pulse_colors.dart';
import 'package:pulse/features/feed/feed_screen.dart';
import 'package:pulse/features/home/welcome_screen.dart';
import 'package:pulse/features/profile/profile_screen.dart';
import 'package:pulse/main.dart';

void main() {
  testWidgets('shows Pulse welcome screen', (tester) async {
    await tester.pumpWidget(const PulseApp());

    expect(find.text('PULSE'), findsOneWidget);
    expect(find.text(AppStrings.welcomeTagline), findsOneWidget);
    expect(find.text('Enter the pulse'), findsOneWidget);
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

  test('PulseColors match dark prototype palette', () {
    expect(PulseColors.background, const Color(0xFF0C0A0D));
    expect(PulseColors.surface, const Color(0xFF161318));
    expect(PulseColors.coral, const Color(0xFFFF3D5A));
    expect(PulseColors.amber, const Color(0xFFF4A261));
    expect(PulseColors.cyan, const Color(0xFF4CC9F0));
    expect(PulseColors.textPrimary, const Color(0xFFF5F0EB));
    expect(PulseColors.textMuted, const Color(0xFF8A7F85));
  });
}
