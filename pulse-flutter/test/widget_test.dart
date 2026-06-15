import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/strings/app_strings.dart';
import 'package:pulse/core/theme/pulse_colors.dart';
import 'package:pulse/core/theme/pulse_theme.dart';
import 'package:pulse/core/widgets/pulse_components.dart';
import 'package:pulse/features/auth/login_screen.dart';
import 'package:pulse/features/feed/feed_screen.dart';
import 'package:pulse/features/feed/transmit_screen.dart';
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

  testWidgets('welcome routes to login', (tester) async {
    await tester.pumpWidget(const PulseApp());

    await tester.tap(find.text('Enter the pulse'));
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('Signal in'), findsOneWidget);
  });

  testWidgets('feed routes to transmit and profile screens', (tester) async {
    await tester.pumpWidget(
      MaterialApp(theme: PulseTheme.dark(), home: const FeedScreen()),
    );

    expect(find.byType(FeedScreen), findsOneWidget);
    expect(find.text('Pulse'), findsOneWidget);
    expect(find.textContaining('room went quiet'), findsOneWidget);

    await tester.tapAt(tester.getCenter(find.byType(PulseOrbFab)));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(TransmitScreen), findsOneWidget);
    expect(find.text('Transmit'), findsWidgets);

    await tester.tap(find.text('close'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.text('@mira  072 BPM').first);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(ProfileScreen), findsOneWidget);
    expect(find.text('rhythm strip'), findsOneWidget);
  });

  test('AppStrings expose Pulse prototype copy', () {
    expect(AppStrings.appName, 'Pulse');
    expect(AppStrings.welcomeTagline, 'Feel the room.');
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
