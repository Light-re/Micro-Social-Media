import '../feed/data/post_response.dart';
import 'data/like_repository.dart';

/// Business logic for toggling likes on a post.
class LikeService {
  LikeService(this._likeRepository);

  final LikeRepository _likeRepository;

  /// Toggles the like state and returns the server-reconciled post.
  Future<PostResponse> toggle(PostResponse post) {
    return post.likedByMe
        ? _likeRepository.unlike(post.id)
        : _likeRepository.like(post.id);
  }
}
