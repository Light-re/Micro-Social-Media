import 'package:flutter/material.dart';

import 'pulse_colors.dart';

/// Theme migrated from legacy `pulse-android` Material 3 day/night theme.
abstract final class PulseTheme {
  static ThemeData dark() {
    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: PulseColors.coral,
        secondary: PulseColors.amber,
        tertiary: PulseColors.cyan,
        surface: PulseColors.surface,
        onSurface: PulseColors.textPrimary,
        error: PulseColors.coral,
      ),
      scaffoldBackgroundColor: PulseColors.background,
      useMaterial3: true,
      fontFamily: 'InstrumentSerif',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Syne',
          fontSize: 58,
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
          color: PulseColors.textPrimary,
        ),
        headlineLarge: TextStyle(
          fontFamily: 'Syne',
          fontSize: 34,
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
          color: PulseColors.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Syne',
          fontSize: 26,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
          color: PulseColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'InstrumentSerif',
          fontSize: 26,
          height: 1.16,
          letterSpacing: 0,
          color: PulseColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'InstrumentSerif',
          fontSize: 20,
          height: 1.25,
          letterSpacing: 0,
          color: PulseColors.textPrimary,
        ),
        labelLarge: TextStyle(
          fontFamily: 'JetBrainsMono',
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          color: PulseColors.textPrimary,
        ),
        labelMedium: TextStyle(
          fontFamily: 'JetBrainsMono',
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
          color: PulseColors.textMuted,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        isDense: true,
      ),
    );
  }
}
