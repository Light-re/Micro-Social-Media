import 'package:flutter/material.dart';

import '../../core/theme/pulse_colors.dart';
import '../../core/widgets/pulse_components.dart';
import '../../core/widgets/pulse_painters.dart';
import '../feed/feed_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 72,
                width: 180,
                child: CustomPaint(painter: EkgPainter(progress: 0.82)),
              ),
              const SizedBox(height: 48),
              Text('Signal in',
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 8),
              Text(
                'A quiet room for the people you actually feel.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: PulseColors.textMuted,
                      fontStyle: FontStyle.italic,
                    ),
              ),
              const SizedBox(height: 40),
              const PulseTextField(label: 'EMAIL'),
              const SizedBox(height: 20),
              const PulseTextField(label: 'PASSWORD', obscureText: true),
              const SizedBox(height: 32),
              PulseButton(
                label: 'Enter',
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (_) => const FeedScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              Text(
                'NO BROADCASTS. JUST SIGNALS.',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
