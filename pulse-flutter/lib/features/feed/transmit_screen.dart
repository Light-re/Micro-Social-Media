import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/pulse_colors.dart';
import '../../core/widgets/pulse_components.dart';
import '../../core/widgets/pulse_painters.dart';

class TransmitScreen extends StatefulWidget {
  const TransmitScreen({super.key});

  @override
  State<TransmitScreen> createState() => _TransmitScreenState();
}

class _TransmitScreenState extends State<TransmitScreen> {
  String _draft = '';

  @override
  Widget build(BuildContext context) {
    final intensity = math.max(0.4, math.min(1.6, _draft.length / 64));

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Transmit',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('close'),
                  ),
                ],
              ),
              const SizedBox(height: 34),
              Expanded(
                child: TextField(
                  maxLines: null,
                  expands: true,
                  onChanged: (value) => setState(() => _draft = value),
                  cursorColor: PulseColors.coral,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 32,
                      ),
                  decoration: InputDecoration(
                    hintText: 'What changed in the room?',
                    hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: PulseColors.textMuted,
                          fontSize: 32,
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ),
              ),
              SizedBox(
                height: 104,
                width: double.infinity,
                child: CustomPaint(
                  painter: WaveformPainter(
                    color: PulseColors.coral,
                    opacity: 0.72,
                    seed: _draft.length,
                    intensity: intensity,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              PulseButton(
                label: 'Transmit',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
