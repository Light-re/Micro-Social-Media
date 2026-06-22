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

const _demoPosts = [
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
  const FeedScreen({
    super.key,
    this.posts = const [],
  });

  final List<FeedPost> posts;

  @override
  Widget build(BuildContext context) {
    final effectivePosts = posts.isEmpty ? _demoPosts : posts;

    return Scaffold(
      backgroundColor: PulseColors.lightBackground,
      appBar: AppBar(
        title: const Text(AppStrings.feedTitle),
        backgroundColor: PulseColors.lightBackground,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: effectivePosts.length,
        itemBuilder: (context, index) {
          final post = effectivePosts[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Name + timestamp
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      post.displayName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      post.timestamp,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Post text
                Text(
                  post.text,
                  style: const TextStyle(fontSize: 15),
                ),

                const SizedBox(height: 12),

                // Like row
                Row(
                  children: [
                    const Icon(Icons.favorite_border, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      '${post.likeCount}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
