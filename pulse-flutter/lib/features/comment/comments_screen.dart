import 'package:flutter/material.dart';

import '../../core/di/app_scope.dart';
import '../../core/network/api_exception.dart';
import '../../core/theme/pulse_colors.dart';
import '../../core/utils/relative_time.dart';
import '../../core/widgets/pulse_components.dart';
import 'comment_service.dart';
import 'models/comment_response.dart';

/// Lists comments for a post (US-22) and lets the user add one (US-21).
/// Pops with the latest comment count so the feed can update US-23.
class CommentsScreen extends StatefulWidget {
  const CommentsScreen({
    super.key,
    required this.postId,
    required this.initialCommentCount,
  });

  final String postId;
  final int initialCommentCount;

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _controller = TextEditingController();
  late CommentService _commentService;

  bool _isLoading = true;
  bool _isSending = false;
  String? _error;
  List<CommentResponse> _comments = const [];
  late int _count = widget.initialCommentCount;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _commentService = AppScope.of(context).commentService;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _canSend => !_isSending && _controller.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        Navigator.of(context).pop(_count);
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Comments')),
        body: Column(
          children: [
            Expanded(child: _buildList()),
            _buildComposer(),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return _ErrorState(message: _error!, onRetry: _load);
    }
    if (_comments.isEmpty) {
      return Center(
        child: Text(
          'No comments yet.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      itemCount: _comments.length,
      separatorBuilder: (_, __) => const Divider(height: 24),
      itemBuilder: (context, index) => _CommentTile(comment: _comments[index]),
    );
  }

  Widget _buildComposer() {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                enabled: !_isSending,
                minLines: 1,
                maxLines: 4,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(hintText: 'Add a comment'),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              tooltip: 'Send comment',
              onPressed: _canSend ? _send : null,
              icon: _isSending
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send_rounded),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final comments = await _commentService.loadComments(widget.postId);
      if (!mounted) return;
      setState(() {
        _comments = comments;
        _count = comments.length;
        _isLoading = false;
      });
    } on ApiException catch (error) {
      if (!mounted) return;
      setState(() {
        _error = error.message;
        _isLoading = false;
      });
    }
  }

  Future<void> _send() async {
    setState(() => _isSending = true);
    try {
      final created =
          await _commentService.addComment(widget.postId, _controller.text);
      if (!mounted) return;
      setState(() {
        _comments = [..._comments, created];
        _count = _comments.length;
        _isSending = false;
        _controller.clear();
      });
    } on ApiException catch (error) {
      if (!mounted) return;
      setState(() => _isSending = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message)));
    }
  }
}

class _CommentTile extends StatelessWidget {
  const _CommentTile({required this.comment});

  final CommentResponse comment;

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).textTheme.labelMedium;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PulseAvatar(username: comment.authorUsername, radius: 18),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '@${comment.authorUsername} · ${formatRelativeTime(comment.createdAt)}',
                style: muted,
              ),
              const SizedBox(height: 4),
              Text(comment.content,
                  style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ],
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              style: FilledButton.styleFrom(
                backgroundColor: PulseColors.coral,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
