class PostResponse {
  const PostResponse({
    required this.id,
    required this.authorId,
    required this.authorUsername,
    required this.content,
    required this.createdAt,
    required this.likeCount,
    required this.commentCount,
  });

  final String id;
  final String authorId;
  final String authorUsername;
  final String content;
  final DateTime createdAt;
  final int likeCount;
  final int commentCount;

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      authorUsername: json['authorUsername'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      likeCount: json['likeCount'] as int,
      commentCount: json['commentCount'] as int,
    );
  }
}
