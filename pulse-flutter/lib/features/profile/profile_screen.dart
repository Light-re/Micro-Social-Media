import 'package:flutter/material.dart';

import '../../core/theme/pulse_colors.dart';
import '../../core/widgets/pulse_components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Row(
            children: [
              const PulseAvatar(username: 'mira', radius: 36),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mira',
                        style: Theme.of(context).textTheme.headlineMedium),
                    Text('@mira',
                        style: Theme.of(context).textTheme.labelMedium),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Collecting small weather from familiar people.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          const Row(
            children: [
              _StatChip(label: 'Posts', value: '24'),
              SizedBox(width: 12),
              _StatChip(label: 'Likes', value: '186'),
            ],
          ),
          const SizedBox(height: 28),
          Text('Recent posts',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          const PulsePostCard(
            username: 'mira',
            displayName: 'Mira',
            timestamp: '2h ago',
            text:
                'The room went quiet and somehow that felt like everyone replying at once.',
            likeCount: 12,
          ),
          const SizedBox(height: 12),
          const PulsePostCard(
            username: 'mira',
            displayName: 'Mira',
            timestamp: 'Yesterday',
            text: 'Kept one lamp on until the apartment remembered me.',
            likeCount: 19,
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: PulseColors.coral.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: Theme.of(context).textTheme.titleMedium),
          Text(label, style: Theme.of(context).textTheme.labelMedium),
        ],
      ),
    );
  }
}
