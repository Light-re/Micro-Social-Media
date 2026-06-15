import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/pulse_colors.dart';

class WaveformPainter extends CustomPainter {
  const WaveformPainter({
    this.color = PulseColors.coral,
    this.opacity = 0.22,
    this.seed = 0,
    this.intensity = 1,
  });

  final Color color;
  final double opacity;
  final int seed;
  final double intensity;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: opacity)
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final path = Path();
    final center = size.height / 2;
    final step = size.width / 18;

    path.moveTo(0, center);
    for (var i = 0; i <= 18; i++) {
      final x = i * step;
      final phase = (i + seed) * 0.78;
      final pulse = math.sin(phase) * 14 * intensity;
      final spike = i % 6 == 3 ? -22 * intensity : 0;
      final y = center + pulse + spike;
      path.lineTo(x, y.clamp(6, size.height - 6).toDouble());
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant WaveformPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.opacity != opacity ||
        oldDelegate.seed != seed ||
        oldDelegate.intensity != intensity;
  }
}

class EkgPainter extends CustomPainter {
  const EkgPainter({this.progress = 1});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [PulseColors.amber, PulseColors.coral, PulseColors.cyan],
      ).createShader(Offset.zero & size)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final center = size.height / 2;
    final points = <Offset>[
      Offset(0, center),
      Offset(size.width * .14, center),
      Offset(size.width * .19, center - 9),
      Offset(size.width * .23, center + 8),
      Offset(size.width * .29, center),
      Offset(size.width * .39, center),
      Offset(size.width * .44, center - 34),
      Offset(size.width * .49, center + 28),
      Offset(size.width * .55, center),
      Offset(size.width * .67, center),
      Offset(size.width * .73, center - 13),
      Offset(size.width * .8, center + 6),
      Offset(size.width, center),
    ];

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (final point in points.skip(1)) {
      path.lineTo(point.dx, point.dy);
    }

    final metric = path.computeMetrics().first;
    final visiblePath = metric.extractPath(
      0,
      metric.length * progress.clamp(0, 1),
    );
    canvas.drawPath(visiblePath, paint);
  }

  @override
  bool shouldRepaint(covariant EkgPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class WaveSpikeGlyph extends StatelessWidget {
  const WaveSpikeGlyph({
    super.key,
    this.size = 18,
    this.color = PulseColors.coral,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(
        painter: WaveformPainter(color: color, opacity: 1, intensity: 0.44),
      ),
    );
  }
}

class RhythmBars extends StatelessWidget {
  const RhythmBars({super.key, required this.values});

  final List<double> values;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var i = 0; i < values.length; i++) ...[
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 240),
              height: 28 + values[i] * 108,
              decoration: BoxDecoration(
                color: i.isEven ? PulseColors.coral : PulseColors.amber,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          if (i != values.length - 1) const SizedBox(width: 5),
        ],
      ],
    );
  }
}
