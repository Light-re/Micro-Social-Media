/// Immutable comment returned by the post comments endpoints.
class CommentResponse {
  const CommentResponse({
    required this.id,
    required this.postId,
    required this.authorId,
    required this.authorUsername,
    required this.content,
    required this.createdAt,
  });

  final String id;
  final String postId;
  final String authorId;
  final String authorUsername;
  final String content;
  final DateTime createdAt;

  factory CommentResponse.fromJson(Map<String, dynamic> json) {
    return CommentResponse(
      id: json['id'] as String,
      postId: json['postId'] as String,
      authorId: json['authorId'] as String,
      authorUsername: json['authorUsername'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postId': postId,
      'authorId': authorId,
      'authorUsername': authorUsername,
      'content': content,
      'createdAt': createdAt.toUtc().toIso8601String(),
    };
  }
}
