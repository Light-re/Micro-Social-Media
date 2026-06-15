import 'package:flutter/material.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/utils/relative_time.dart';
import '../../../core/widgets/pulse_components.dart';
import '../../comment/comments_screen.dart';
import '../../like/like_service.dart';
import '../data/post_response.dart';

/// Smart widget that renders a single post and wires like/comment/delete
/// behaviour through services (US-17/18/19/20/23/24/25/30).
class PostTile extends StatefulWidget {
  const PostTile({
    super.key,
    required this.post,
    required this.likeService,
    required this.currentUserId,
    required this.onDeleteRequested,
  });

  final PostResponse post;
  final LikeService likeService;
  final String? currentUserId;
  final Future<void> Function(PostResponse post) onDeleteRequested;

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  late PostResponse _post = widget.post;
  bool _likeInFlight = false;

  bool get _isOwnPost => widget.currentUserId == _post.authorId;

  @override
  Widget build(BuildContext context) {
    return PulsePostCard(
      username: _post.authorUsername,
      displayName: _post.authorUsername,
      timestamp: formatRelativeTime(_post.createdAt),
      text: _post.content,
      likeCount: _post.likeCount,
      commentCount: _post.commentCount,
      likedByMe: _post.likedByMe,
      isLikeInFlight: _likeInFlight,
      canDelete: _isOwnPost,
      onLikeTap: _toggleLike,
      onCommentTap: _openComments,
      onDeleteTap: _isOwnPost ? () => widget.onDeleteRequested(_post) : null,
    );
  }

  Future<void> _toggleLike() async {
    setState(() => _likeInFlight = true);
    try {
      final updated = await widget.likeService.toggle(_post);
      if (mounted) {
        setState(() => _post = updated);
      }
    } on ApiException catch (error) {
      _showError(error.message);
    } finally {
      if (mounted) {
        setState(() => _likeInFlight = false);
      }
    }
  }

  Future<void> _openComments() async {
    final newCount = await Navigator.of(context).push<int>(
      MaterialPageRoute<int>(
        builder: (_) => CommentsScreen(
          postId: _post.id,
          initialCommentCount: _post.commentCount,
        ),
      ),
    );
    if (newCount != null && mounted) {
      setState(() => _post = _post.copyWith(commentCount: newCount));
    }
  }

  void _showError(String message) {
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
