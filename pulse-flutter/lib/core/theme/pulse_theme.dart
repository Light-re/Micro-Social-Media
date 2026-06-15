import 'package:flutter/material.dart';

import 'pulse_colors.dart';

/// Theme migrated from legacy `pulse-android` Material 3 day/night theme.
abstract final class PulseTheme {
  static ThemeData light() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: PulseColors.purple500,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: PulseColors.white,
      useMaterial3: true,
    );
  }
}
