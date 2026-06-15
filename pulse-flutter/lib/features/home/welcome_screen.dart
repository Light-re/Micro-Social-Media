import 'package:flutter/material.dart';

import '../../core/strings/app_strings.dart';
import '../../core/theme/pulse_colors.dart';
import '../../core/widgets/pulse_components.dart';
import '../../core/widgets/pulse_painters.dart';
import '../auth/login_screen.dart';

/// Splash/welcome screen for the Pulse prototype.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              const SizedBox(
                height: 112,
                width: double.infinity,
                child: CustomPaint(painter: EkgPainter()),
              ),
              const SizedBox(height: 48),
              Text(
                'PULSE',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: PulseColors.textPrimary,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                AppStrings.welcomeTagline,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: PulseColors.textMuted,
                      fontStyle: FontStyle.italic,
                    ),
              ),
              const Spacer(),
              PulseButton(
                label: 'Enter the pulse',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const LoginScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
