import 'package:flutter/material.dart';

import '../../core/strings/app_strings.dart';
import '../../core/theme/pulse_colors.dart';
import '../../core/widgets/pulse_components.dart';
import '../auth/login_screen.dart';
import '../auth/register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 48,
                height: 4,
                decoration: BoxDecoration(
                  color: PulseColors.coral.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 32),
              Text('Pulse', style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: 10),
              Text(
                AppStrings.welcomeTagline,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).textTheme.labelMedium?.color,
                    ),
              ),
              const Spacer(),
              PulseButton(
                label: 'Get started',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const LoginScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const RegisterScreen(),
                    ),
                  );
                },
                child: const Text('Create account'),
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}
