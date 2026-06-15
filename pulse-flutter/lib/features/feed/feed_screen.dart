import 'package:flutter/material.dart';

import '../../core/theme/pulse_colors.dart';
import '../../core/widgets/pulse_components.dart';
import '../../core/widgets/pulse_painters.dart';
import '../profile/profile_screen.dart';
import 'transmit_screen.dart';

class PulseSignal {
  const PulseSignal({
    required this.username,
    required this.timestamp,
    required this.text,
    required this.resonance,
  });

  final String username;
  final String timestamp;
  final String text;
  final int resonance;
}

const _signals = [
  PulseSignal(
    username: 'mira',
    timestamp: '072 BPM',
    text:
        'the room went quiet and somehow that felt like everyone replying at once.',
    resonance: 12,
  ),
  PulseSignal(
    username: 'noah',
    timestamp: '018 MIN',
    text:
        'caught the tram home with rain on the glass. small city, loud chest.',
    resonance: 8,
  ),
  PulseSignal(
    username: 'sana',
    timestamp: 'NOW',
    text: 'send me the songs that make the evening less rectangular.',
    resonance: 21,
  ),
];

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Text(
                          'Pulse',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const Spacer(),
                        Text(
                          'LIVE / 060',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList.separated(
                  itemCount: _signals.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final signal = _signals[index];
                    return SignalPostBlock(
                      username: signal.username,
                      timestamp: signal.timestamp,
                      text: signal.text,
                      resonance: signal.resonance,
                      seed: index,
                      onAuthorTap: () => _openProfile(context),
                    );
                  },
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 128),
                  sliver: SliverToBoxAdapter(
                    child: _StoryboardStrip(
                      onOpenProfile: () => _openProfile(context),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 24,
              child: Center(
                child: PulseOrbFab(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => const TransmitScreen(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openProfile(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => const ProfileScreen(),
      ),
    );
  }
}

class _StoryboardStrip extends StatelessWidget {
  const _StoryboardStrip({required this.onOpenProfile});

  final VoidCallback onOpenProfile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('motion studies', style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              StoryboardPanel(
                label: 'ripple like',
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    for (final size in [18.0, 34.0, 50.0])
                      Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: PulseColors.coral.withValues(alpha: 0.55),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const StoryboardPanel(
                label: 'refresh beat',
                child: CustomPaint(
                  size: Size(74, 40),
                  painter: EkgPainter(),
                ),
              ),
              const SizedBox(width: 10),
              StoryboardPanel(
                label: 'fab breath',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (final size in [18.0, 24.0, 30.0])
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Container(
                          width: size,
                          height: size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: PulseColors.coral.withValues(alpha: 0.75),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              StoryboardPanel(
                label: 'profile',
                child: TextButton(
                  onPressed: onOpenProfile,
                  child: const Text('@mira'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
