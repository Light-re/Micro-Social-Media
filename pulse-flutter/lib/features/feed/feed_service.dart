import 'data/post_repository.dart';
import 'data/post_response.dart';

/// Business logic for loading and mutating the feed.
class FeedService {
  FeedService(this._postRepository);

  final PostRepository _postRepository;

  /// Loads the feed, defensively sorted newest-first (US-15).
  Future<List<PostResponse>> loadFeed() async {
    return _sortedNewestFirst(await _postRepository.fetchFeed());
  }

  /// Loads the signed-in user's own posts, newest-first (US-09).
  Future<List<PostResponse>> loadMyPosts() async {
    return _sortedNewestFirst(await _postRepository.fetchMyPosts());
  }

  List<PostResponse> _sortedNewestFirst(List<PostResponse> posts) {
    return [...posts]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<PostResponse> createPost(String content) {
    return _postRepository.createPost(content.trim());
  }

  Future<void> deletePost(String postId) {
    return _postRepository.deletePost(postId);
  }
}
