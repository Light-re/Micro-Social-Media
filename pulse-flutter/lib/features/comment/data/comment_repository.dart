import '../../../core/network/api_client.dart';
import '../models/comment_response.dart';

/// Persistence-only access to the post comments endpoints.
class CommentRepository {
  CommentRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<List<CommentResponse>> fetchComments(String postId) async {
    final data = await _apiClient.get('/api/posts/$postId/comments');
    return (data as List<dynamic>)
        .map((item) => CommentResponse.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<CommentResponse> createComment(String postId, String content) async {
    final data = await _apiClient.post(
      '/api/posts/$postId/comments',
      body: {'content': content},
    );
    return CommentResponse.fromJson(data as Map<String, dynamic>);
  }
}
