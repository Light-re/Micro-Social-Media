import 'package:flutter/material.dart';

import '../../core/theme/pulse_colors.dart';
import '../../core/widgets/pulse_components.dart';
import '../../core/widgets/pulse_painters.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Profile',
                      style: Theme.of(context).textTheme.labelMedium),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('close'),
                  ),
                ],
              ),
              const SizedBox(height: 26),
              Text(
                '@mira',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 64,
                      color: PulseColors.coral,
                    ),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 22),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: PulseColors.borderWarm),
                    bottom: BorderSide(color: PulseColors.borderWarm),
                  ),
                ),
                child: Text(
                  '"collecting small weather from familiar people."',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 34,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),
              const SizedBox(height: 34),
              Text('rhythm strip',
                  style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 16),
              const SizedBox(
                height: 164,
                child: RhythmBars(
                  values: [0.24, 0.62, 0.38, 0.9, 0.52, 0.77, 0.31, 0.68],
                ),
              ),
              const SizedBox(height: 34),
              const SignalPostBlock(
                username: 'mira',
                timestamp: '072 BPM',
                text:
                    'the room went quiet and somehow that felt like everyone replying at once.',
                resonance: 12,
                seed: 2,
              ),
              const SizedBox(height: 14),
              const SignalPostBlock(
                username: 'mira',
                timestamp: 'YDAY',
                text: 'kept one lamp on until the apartment remembered me.',
                resonance: 19,
                seed: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
