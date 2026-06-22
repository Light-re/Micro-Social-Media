import 'package:flutter/material.dart';

import '../../core/di/app_scope.dart';
import '../../core/network/api_exception.dart';
import '../../core/widgets/pulse_components.dart';
import '../auth/auth_service.dart';
import '../auth/login_screen.dart';
import '../feed/data/post_response.dart';
import '../feed/feed_service.dart';
import '../feed/widgets/post_tile.dart';
import '../like/like_service.dart';
import '../user/data/user_api_repository.dart';
import '../user/data/user_profile.dart';
import '../user/user_service.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    this.userService,
    this.authService,
    this.feedService,
    this.likeService,
  });

  final UserService? userService;
  final AuthService? authService;
  final FeedService? feedService;
  final LikeService? likeService;

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  late final UserService _userService;
  late final AuthService _authService;
  late final FeedService _feedService;
  late final LikeService _likeService;
  bool _servicesResolved = false;
  UserProfile? _profile;
  List<PostResponse> _posts = const [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_servicesResolved) {
      return;
    }
    _servicesResolved = true;
    final scope = AppScope.of(context);
    _userService = widget.userService ?? scope.userService;
    _authService = widget.authService ?? scope.authService;
    _feedService = widget.feedService ?? scope.feedService;
    _likeService = widget.likeService ?? scope.likeService;
    reload();
  }

  /// Loads the profile and the user's own posts (US-08, US-09).
  Future<void> reload() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final profile = await _userService.loadProfile();
      final posts = await _feedService.loadMyPosts();
      if (!mounted) return;
      setState(() {
        _profile = profile;
        _posts = posts;
        _isLoading = false;
      });
    } on StateError {
      _setError('Sign in to view your profile.');
    } on UserApiException catch (error) {
      _setError(error.message);
    } on ApiException catch (error) {
      _setError(error.message);
    } catch (_) {
      _setError('Could not load profile.');
    }
  }

  void _setError(String message) {
    if (!mounted) return;
    setState(() {
      _errorMessage = message;
      _isLoading = false;
    });
  }

  Future<void> _openEditProfile() async {
    final profile = _profile;
    if (profile == null) {
      return;
    }

    final updated = await Navigator.of(context).push<UserProfile>(
      MaterialPageRoute<UserProfile>(
        builder: (_) => EditProfileScreen(
          initialProfile: profile,
          userService: _userService,
        ),
      ),
    );

    if (updated != null && mounted) {
      setState(() => _profile = updated);
    }
  }

  Future<void> _logout() async {
    await _authService.logout();
    if (!mounted) {
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
      (_) => false,
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
    try {
      await _feedService.deletePost(post.id);
      await reload();
    } on ApiException catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          if (_profile != null)
            IconButton(
              onPressed: _openEditProfile,
              icon: const Icon(Icons.edit_outlined),
              tooltip: 'Edit profile',
            ),
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            tooltip: 'Log out',
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            _errorMessage!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      );
    }

    final profile = _profile!;
    return RefreshIndicator(
      onRefresh: reload,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          _ProfileHeader(profile: profile),
          const SizedBox(height: 24),
          ..._buildPosts(profile),
        ],
      ),
    );
  }

  List<Widget> _buildPosts(UserProfile profile) {
    if (_posts.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Text(
            'You have not posted yet.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ];
    }
    return _posts
        .map(
          (post) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: PostTile(
              key: ValueKey(post.id),
              post: post,
              likeService: _likeService,
              currentUserId: profile.id,
              onDeleteRequested: _confirmAndDelete,
            ),
          ),
        )
        .toList();
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final bio = profile.bio.trim().isEmpty
        ? 'No bio yet. Tap edit to add one.'
        : profile.bio;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            PulseAvatar(username: profile.username, radius: 36),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.username,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    '@${profile.username}',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(bio, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
