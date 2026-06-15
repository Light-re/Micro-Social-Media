import 'package:flutter/material.dart';

import 'core/di/app_dependencies.dart';
import 'core/di/app_scope.dart';
import 'core/strings/app_strings.dart';
import 'core/theme/pulse_theme.dart';
import 'features/home/welcome_screen.dart';

void main() {
  runApp(PulseApp(dependencies: AppDependencies.create()));
}

class PulseApp extends StatelessWidget {
  const PulseApp({super.key, required this.dependencies});

  final AppDependencies dependencies;

  @override
  Widget build(BuildContext context) {
    return AppScope(
      dependencies: dependencies,
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: PulseTheme.light(),
        darkTheme: PulseTheme.dark(),
        themeMode: ThemeMode.system,
        home: const WelcomeScreen(),
      ),
    );
  }
}
