import 'package:flutter/material.dart';

import 'core/strings/app_strings.dart';
import 'core/theme/pulse_theme.dart';
import 'features/home/welcome_screen.dart';

void main() {
  runApp(const PulseApp());
}

class PulseApp extends StatelessWidget {
  const PulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: PulseTheme.light(),
      darkTheme: PulseTheme.dark(),
      themeMode: ThemeMode.system,
      home: const WelcomeScreen(),
    );
  }
}
