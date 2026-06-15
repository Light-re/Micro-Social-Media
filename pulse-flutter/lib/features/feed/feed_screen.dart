import 'package:flutter/material.dart';

import '../../core/di/app_scope.dart';
import '../../core/network/api_exception.dart';
import '../../core/theme/pulse_colors.dart';
import '../auth/auth_service.dart';
import '../like/like_service.dart';
import 'data/post_response.dart';
import 'feed_service.dart';
import 'widgets/post_tile.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => FeedScreenState();
}

class FeedScreenState extends State<FeedScreen> {
  late FeedService _feedService;
  late LikeService _likeService;
  late AuthService _authService;

  bool _isLoading = true;
  String? _error;
  List<PostResponse> _posts = const [];
  String? _currentUserId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final deps = AppScope.of(context);
    _feedService = deps.feedService;
    _likeService = deps.likeService;
    _authService = deps.authService;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => reload());
  }

  /// Reloads the feed (US-29 loading, US-14/15 rendering, error retry).
  Future<void> reload() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final userId = await _authService.currentUserId();
      final posts = await _feedService.loadFeed();
      if (!mounted) return;
      setState(() {
        _currentUserId = userId;
        _posts = posts;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pulse'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: PulseColors.coral.withValues(alpha: 0.35),
          ),
        ),
      ),
      body: RefreshIndicator(
        color: PulseColors.coral,
        onRefresh: reload,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return _ErrorState(message: _error!, onRetry: reload);
    }
    if (_posts.isEmpty) {
      return const _NeutralState();
    }
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      itemCount: _posts.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final post = _posts[index];
        return PostTile(
          key: ValueKey(post.id),
          post: post,
          likeService: _likeService,
          currentUserId: _currentUserId,
          onDeleteRequested: _confirmAndDelete,
        );
      },
    );
  }

  Future<void> _confirmAndDelete(PostResponse post) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete post?'),
        content: const Text('This permanently removes your post.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await _deletePost(post);
  }

  Future<void> _deletePost(PostResponse post) async {
    try {
      await _feedService.deletePost(post.id);
      await reload();
    } on ApiException catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message)));
    }
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        const SizedBox(height: 120),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                Text(message, textAlign: TextAlign.center),
                const SizedBox(height: 16),
                FilledButton(onPressed: onRetry, child: const Text('Retry')),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _NeutralState extends StatelessWidget {
  const _NeutralState();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        const SizedBox(height: 140),
        Center(
          child: Text(
            'Nothing here yet.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
