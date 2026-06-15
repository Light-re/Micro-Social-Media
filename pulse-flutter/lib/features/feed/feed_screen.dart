import 'package:flutter/material.dart';

import '../../core/theme/pulse_colors.dart';
import '../../core/widgets/pulse_components.dart';

class FeedPost {
  const FeedPost({
    required this.username,
    required this.displayName,
    required this.timestamp,
    required this.text,
    required this.likeCount,
  });

  final String username;
  final String displayName;
  final String timestamp;
  final String text;
  final int likeCount;
}

const _posts = [
  FeedPost(
    username: 'mira',
    displayName: 'Mira',
    timestamp: '2h ago',
    text:
        'The room went quiet and somehow that felt like everyone replying at once.',
    likeCount: 12,
  ),
  FeedPost(
    username: 'noah',
    displayName: 'Noah',
    timestamp: '18m ago',
    text:
        'Caught the tram home with rain on the glass. Small city, loud chest.',
    likeCount: 8,
  ),
  FeedPost(
    username: 'sana',
    displayName: 'Sana',
    timestamp: 'Just now',
    text: 'Send me the songs that make the evening less rectangular.',
    likeCount: 21,
  ),
];

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pulse'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: PulseColors.coral.withValues(alpha: 0.35),
          ),
        ),
      ),
      body: RefreshIndicator(
        color: PulseColors.coral,
        onRefresh: () async {
          await Future<void>.delayed(const Duration(milliseconds: 600));
        },
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          itemCount: _posts.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final post = _posts[index];
            return PulsePostCard(
              username: post.username,
              displayName: post.displayName,
              timestamp: post.timestamp,
              text: post.text,
              likeCount: post.likeCount,
            );
          },
        ),
      ),
    );
  }
}
