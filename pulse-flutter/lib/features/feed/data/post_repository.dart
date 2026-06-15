import '../../../core/network/api_client.dart';
import 'feed_response.dart';
import 'post_response.dart';

/// Persistence-only access to the backend post and feed endpoints.
class PostRepository {
  PostRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<List<PostResponse>> fetchFeed() async {
    final data = await _apiClient.get('/api/posts/feed');
    return FeedResponse.fromJson(data as Map<String, dynamic>).posts;
  }

  Future<PostResponse> createPost(String content) async {
    final data = await _apiClient.post('/api/posts', body: {'content': content});
    return PostResponse.fromJson(data as Map<String, dynamic>);
  }

  Future<void> deletePost(String postId) async {
    await _apiClient.delete('/api/posts/$postId');
  }
}
