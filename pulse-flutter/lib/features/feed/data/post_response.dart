/// Immutable post returned by the backend feed and post endpoints.
class PostResponse {
  const PostResponse({
    required this.id,
    required this.authorId,
    required this.authorUsername,
    required this.content,
    required this.createdAt,
    required this.likeCount,
    required this.commentCount,
    this.likedByMe = false,
  });

  final String id;
  final String authorId;
  final String authorUsername;
  final String content;
  final DateTime createdAt;
  final int likeCount;
  final int commentCount;
  final bool likedByMe;

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      authorUsername: json['authorUsername'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      likeCount: (json['likeCount'] as num).toInt(),
      commentCount: (json['commentCount'] as num).toInt(),
      likedByMe: json['likedByMe'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'authorId': authorId,
      'authorUsername': authorUsername,
      'content': content,
      'createdAt': createdAt.toUtc().toIso8601String(),
      'likeCount': likeCount,
      'commentCount': commentCount,
      'likedByMe': likedByMe,
    };
  }

  PostResponse copyWith({
    int? likeCount,
    int? commentCount,
    bool? likedByMe,
  }) {
    return PostResponse(
      id: id,
      authorId: authorId,
      authorUsername: authorUsername,
      content: content,
      createdAt: createdAt,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      likedByMe: likedByMe ?? this.likedByMe,
    );
  }
}
