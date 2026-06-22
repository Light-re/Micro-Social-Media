import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/features/feed/data/post_response.dart';

void main() {
  const baseJson = {
    'id': 'post-1',
    'authorId': 'user-1',
    'authorUsername': 'devuser',
    'content': 'Hello',
    'createdAt': '2026-06-15T10:00:00.000Z',
    'likeCount': 3,
    'commentCount': 2,
    'likedByMe': true,
  };

  test('parses likedByMe from backend JSON', () {
    final post = PostResponse.fromJson(Map<String, dynamic>.from(baseJson));

    expect(post.likedByMe, isTrue);
    expect(post.likeCount, 3);
    expect(post.commentCount, 2);
  });

  test('defaults likedByMe to false when field is absent', () {
    final json = Map<String, dynamic>.from(baseJson)..remove('likedByMe');

    final post = PostResponse.fromJson(json);

    expect(post.likedByMe, isFalse);
  });

  test('copyWith updates like state without mutating identity fields', () {
    final post = PostResponse.fromJson(Map<String, dynamic>.from(baseJson));

    final updated = post.copyWith(likeCount: 4, likedByMe: false);

    expect(updated.id, post.id);
    expect(updated.likeCount, 4);
    expect(updated.likedByMe, isFalse);
  });

  test('round-trips through toJson', () {
    final post = PostResponse.fromJson(Map<String, dynamic>.from(baseJson));

    final restored = PostResponse.fromJson(post.toJson());

    expect(restored.id, post.id);
    expect(restored.likedByMe, post.likedByMe);
  });
}
