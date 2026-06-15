import 'package:flutter/material.dart';

import '../theme/pulse_colors.dart';

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
    final button = FilledButton(onPressed: onPressed, child: Text(label));
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
        TextField(
          obscureText: obscureText,
          maxLines: maxLines,
          onChanged: onChanged,
          cursorColor: PulseColors.coral,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: const InputDecoration(),
        ),
      ],
    );
  }
}

class PulseAvatar extends StatelessWidget {
  const PulseAvatar({super.key, required this.username, this.radius = 22});

  final String username;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final initial = username.isNotEmpty ? username[0].toUpperCase() : '?';
    return CircleAvatar(
      radius: radius,
      backgroundColor: PulseColors.coral.withValues(alpha: 0.18),
      foregroundColor: PulseColors.coral,
      child: Text(
        initial,
        style: TextStyle(
          fontSize: radius * 0.78,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class PulsePostCard extends StatelessWidget {
  const PulsePostCard({
    super.key,
    required this.username,
    required this.displayName,
    required this.timestamp,
    required this.text,
    required this.likeCount,
    this.onAuthorTap,
    this.onLikeTap,
  });

  final String username;
  final String displayName;
  final String timestamp;
  final String text;
  final int likeCount;
  final VoidCallback? onAuthorTap;
  final VoidCallback? onLikeTap;

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).textTheme.labelMedium;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                PulseAvatar(username: username),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: onAuthorTap,
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(displayName,
                            style: Theme.of(context).textTheme.titleMedium),
                        Text('@$username · $timestamp', style: muted),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(text, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 14),
            InkWell(
              onTap: onLikeTap,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.favorite_border_rounded,
                      size: 20,
                      color: PulseColors.coral.withValues(alpha: 0.9),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      likeCount == 1 ? '1 like' : '$likeCount likes',
                      style: muted,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
