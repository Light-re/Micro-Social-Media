import 'data/comment_repository.dart';
import 'models/comment_response.dart';

/// Business logic for reading and adding comments, newest-last for reading.
class CommentService {
  CommentService(this._commentRepository);

  final CommentRepository _commentRepository;

  Future<List<CommentResponse>> loadComments(String postId) {
    return _commentRepository.fetchComments(postId);
  }

  Future<CommentResponse> addComment(String postId, String content) {
    return _commentRepository.createComment(postId, content.trim());
  }
}
