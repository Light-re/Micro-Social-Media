import '../../../core/network/api_client.dart';
import '../../feed/data/post_response.dart';

/// Persistence-only access to the like/unlike endpoints.
class LikeRepository {
  LikeRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<PostResponse> like(String postId) async {
    final data = await _apiClient.post('/api/posts/$postId/like');
    return PostResponse.fromJson(data as Map<String, dynamic>);
  }

  Future<PostResponse> unlike(String postId) async {
    final data = await _apiClient.delete('/api/posts/$postId/like');
    return PostResponse.fromJson(data as Map<String, dynamic>);
  }
}
