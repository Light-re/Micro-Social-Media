import 'package:flutter/material.dart';

import '../theme/pulse_colors.dart';
import 'pulse_painters.dart';

class PulseButton extends StatelessWidget {
  const PulseButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.expand = true,
  });

  final String label;
  final VoidCallback onPressed;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final button = FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: PulseColors.coral,
        foregroundColor: PulseColors.textPrimary,
        minimumSize: const Size(0, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        textStyle: const TextStyle(
          fontFamily: 'JetBrainsMono',
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
        ),
      ),
      child: Text(label),
    );

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}

class PulseTextField extends StatelessWidget {
  const PulseTextField({
    super.key,
    required this.label,
    this.obscureText = false,
    this.maxLines = 1,
    this.onChanged,
  });

  final String label;
  final bool obscureText;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 8),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: PulseColors.borderWarm),
            borderRadius: BorderRadius.circular(8),
            color: PulseColors.surface,
          ),
          child: TextField(
            obscureText: obscureText,
            maxLines: maxLines,
            onChanged: onChanged,
            cursorColor: PulseColors.coral,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ),
      ],
    );
  }
}

class PulseOrbFab extends StatefulWidget {
  const PulseOrbFab({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<PulseOrbFab> createState() => _PulseOrbFabState();
}

class _PulseOrbFabState extends State<PulseOrbFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _scale = Tween<double>(begin: 0.94, end: 1.06).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: PulseColors.coral,
            boxShadow: [
              BoxShadow(
                color: PulseColors.coral.withValues(alpha: 0.42),
                blurRadius: 28,
                spreadRadius: 4,
              ),
            ],
          ),
          child: const Center(
            child: WaveSpikeGlyph(size: 34, color: PulseColors.textPrimary),
          ),
        ),
      ),
    );
  }
}

class SignalPostBlock extends StatelessWidget {
  const SignalPostBlock({
    super.key,
    required this.username,
    required this.timestamp,
    required this.text,
    required this.resonance,
    this.onAuthorTap,
    this.seed = 0,
  });

  final String username;
  final String timestamp;
  final String text;
  final int resonance;
  final VoidCallback? onAuthorTap;
  final int seed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: BoxDecoration(
        color: PulseColors.surface,
        border: Border(
          top:
              BorderSide(color: PulseColors.borderWarm.withValues(alpha: 0.75)),
          bottom: BorderSide(
            color: PulseColors.borderWarm.withValues(alpha: 0.75),
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: WaveformPainter(
                  color: PulseColors.amber,
                  opacity: 0.08,
                  seed: seed,
                  intensity: 1.2,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: onAuthorTap,
                child: Text(
                  '@$username  $timestamp',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: PulseColors.cyan,
                      ),
                ),
              ),
              const SizedBox(height: 18),
              Text(text, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 18),
              Row(
                children: [
                  const WaveSpikeGlyph(size: 18),
                  const SizedBox(width: 7),
                  Text(
                    '$resonance',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: PulseColors.textPrimary,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StoryboardPanel extends StatelessWidget {
  const StoryboardPanel({
    super.key,
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 104,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: PulseColors.surface,
        border: Border.all(color: PulseColors.borderWarm),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 52, child: Center(child: child)),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}
