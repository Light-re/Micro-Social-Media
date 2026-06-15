import 'package:flutter/material.dart';

import '../../core/strings/app_strings.dart';
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
  const FeedScreen({super.key, this.posts = const []});

  final List<String> posts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.feedTitle)),
      body: posts.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.rss_feed,
                      size: 64,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      AppStrings.feedEmptyMessage,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      AppStrings.feedEmptySubtext,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: posts.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final post = posts[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      post,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                );
              },
            ),
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
