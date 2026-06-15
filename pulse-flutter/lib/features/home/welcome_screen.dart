import 'package:flutter/material.dart';

import '../../core/config/api_config.dart';
import '../../core/strings/app_strings.dart';

/// Welcome screen migrated from legacy `MainActivity` + `activity_main.xml`.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final headlineStyle = Theme.of(context).textTheme.headlineSmall;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.welcomeMessage,
                style: headlineStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                ApiConfig.emulatorBaseUrl,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
