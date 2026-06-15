import 'package:flutter_test/flutter_test.dart';

import 'package:pulse/features/feed/data/feed_response.dart';
import 'package:pulse/features/feed/data/post_response.dart';

void main() {
  test('PostResponse parses backend JSON', () {
    final post = PostResponse.fromJson({
      'id': 'post-1',
      'authorId': 'user-1',
      'authorUsername': 'devuser',
      'content': 'Hello',
      'createdAt': '2026-06-15T10:00:00.000Z',
      'likeCount': 2,
      'commentCount': 1,
    });

    expect(post.id, 'post-1');
    expect(post.authorUsername, 'devuser');
    expect(post.likeCount, 2);
  });

  test('FeedResponse parses sorted post list', () {
    final feed = FeedResponse.fromJson({
      'posts': [
        {
          'id': 'post-2',
          'authorId': 'user-1',
          'authorUsername': 'devuser',
          'content': 'new',
          'createdAt': '2026-06-15T12:00:00.000Z',
          'likeCount': 0,
          'commentCount': 0,
        },
      ],
    });

    expect(feed.posts, hasLength(1));
    expect(feed.posts.first.id, 'post-2');
  });
}
