import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pulse_colors.dart';

abstract final class PulseTheme {
  static ThemeData light() => _build(Brightness.light);

  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isLight = brightness == Brightness.light;
    final background =
        isLight ? PulseColors.lightBackground : PulseColors.darkBackground;
    final surface = isLight ? PulseColors.lightSurface : PulseColors.darkSurface;
    final textPrimary =
        isLight ? PulseColors.lightTextPrimary : PulseColors.darkTextPrimary;
    final textMuted =
        isLight ? PulseColors.lightTextMuted : PulseColors.darkTextMuted;
    final separator =
        isLight ? PulseColors.lightSeparator : PulseColors.darkSeparator;

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: PulseColors.coral,
      onPrimary: Colors.white,
      secondary: PulseColors.coralSoft,
      onSecondary: textPrimary,
      surface: surface,
      onSurface: textPrimary,
      error: PulseColors.coral,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      dividerColor: separator,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: background,
        foregroundColor: textPrimary,
        systemOverlayStyle: isLight
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 17,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.4,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        height: 60,
        backgroundColor: surface.withValues(alpha: isLight ? 0.94 : 0.98),
        indicatorColor: PulseColors.coral.withValues(alpha: 0.14),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStyle(
            fontSize: 10,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            color: selected ? PulseColors.coral : textMuted,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? PulseColors.coral : textMuted,
            size: 22,
          );
        }),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: separator.withValues(alpha: 0.35)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: PulseColors.coral,
          foregroundColor: Colors.white,
          minimumSize: const Size(0, 50),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.3,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isLight
            ? const Color(0xFFE5E5EA)
            : PulseColors.darkSurfaceElevated,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(color: textMuted, fontSize: 17),
      ),
      textTheme: TextTheme(
        displayMedium: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.8,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.6,
          color: textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.4,
          color: textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.3,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 17,
          height: 1.35,
          letterSpacing: -0.2,
          color: textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
          height: 1.35,
          letterSpacing: -0.1,
          color: textPrimary,
        ),
        labelMedium: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: textMuted,
        ),
      ),
    );
  }
}
