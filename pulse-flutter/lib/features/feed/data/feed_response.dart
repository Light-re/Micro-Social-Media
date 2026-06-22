import 'post_response.dart';

class FeedResponse {
  const FeedResponse({required this.posts});

  final List<PostResponse> posts;

  factory FeedResponse.fromJson(Map<String, dynamic> json) {
    final postsJson = json['posts'] as List<dynamic>? ?? const [];
    return FeedResponse(
      posts: postsJson
          .map((item) => PostResponse.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
