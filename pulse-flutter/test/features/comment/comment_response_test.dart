import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/features/comment/models/comment_response.dart';

void main() {
  test('parses backend comment JSON', () {
    final comment = CommentResponse.fromJson({
      'id': 'comment-1',
      'postId': 'post-1',
      'authorId': 'user-1',
      'authorUsername': 'devuser',
      'content': 'Nice post',
      'createdAt': '2026-06-15T10:00:00.000Z',
    });

    expect(comment.id, 'comment-1');
    expect(comment.postId, 'post-1');
    expect(comment.authorUsername, 'devuser');
    expect(comment.content, 'Nice post');
  });

  test('round-trips through toJson', () {
    final comment = CommentResponse.fromJson({
      'id': 'comment-1',
      'postId': 'post-1',
      'authorId': 'user-1',
      'authorUsername': 'devuser',
      'content': 'Nice post',
      'createdAt': '2026-06-15T10:00:00.000Z',
    });

    final restored = CommentResponse.fromJson(comment.toJson());

    expect(restored.id, comment.id);
    expect(restored.content, comment.content);
  });
}
