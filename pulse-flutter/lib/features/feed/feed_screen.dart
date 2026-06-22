import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/strings/app_strings.dart';
import '../../core/theme/pulse_colors.dart';
import '../auth/auth_service.dart';
import '../like/like_service.dart';
import 'data/post_response.dart';
import 'feed_service.dart';
import 'live_feed_service.dart';
import 'widgets/post_tile.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({
    super.key,
    this.posts = const [],
  });

  final List<FeedPost> posts;

  @override
  State<FeedScreen> createState() => FeedScreenState();
}

class FeedScreenState extends State<FeedScreen> {
  late FeedService _feedService;
  late LikeService _likeService;
  late AuthService _authService;
  late LiveFeedService _liveFeedService;
  StreamSubscription<PostResponse>? _liveSubscription;
  bool _liveWired = false;

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
    _liveFeedService = deps.liveFeedService;
    _wireLiveFeed();
  }

  @override
  void initState() {
    super.initState();
    _displayPosts = widget.posts.isEmpty ? _demoPosts : widget.posts;
  }

  /// Subscribes to the realtime live feed once (US live feed). New posts from
  /// other users are prepended without a manual reload; if the socket is down
  /// the REST pull-to-refresh remains the fallback.
  void _wireLiveFeed() {
    if (_liveWired) return;
    _liveWired = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _liveFeedService.connect();
      _liveSubscription = _liveFeedService.posts.listen(_onLivePost);
    });
  }

  void _onLivePost(PostResponse post) {
    if (!mounted) return;
    setState(() => _posts = LiveFeedService.merge(_posts, post));
  }

  @override
  void dispose() {
    _liveSubscription?.cancel();
    super.dispose();
  }

  /// Reloads the feed (US-29 loading, US-14/15 rendering, error retry).
  Future<void> reload() async {
    setState(() {
      _displayPosts = widget.posts.isEmpty ? _demoPosts : widget.posts;
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
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _error = 'Could not load feed.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PulseColors.lightBackground,
      appBar: AppBar(
        title: const Text(AppStrings.feedTitle),
        backgroundColor: PulseColors.lightBackground,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: _displayPosts.length,
        itemBuilder: (context, index) {
          final post = _displayPosts[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Name + timestamp
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      post.displayName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      post.timestamp,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Post text
                Text(
                  post.text,
                  style: const TextStyle(fontSize: 15),
                ),

                const SizedBox(height: 12),

                // Like row
                Row(
                  children: [
                    const Icon(Icons.favorite_border, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      '${post.likeCount}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
