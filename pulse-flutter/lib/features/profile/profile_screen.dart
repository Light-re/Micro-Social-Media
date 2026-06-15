import 'package:flutter/material.dart';

import '../../core/di/app_services.dart';
import '../../core/widgets/pulse_components.dart';
import '../user/data/user_api_repository.dart';
import '../user/data/user_profile.dart';
import '../user/user_service.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.userService});

  final UserService? userService;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final UserService _userService;
  UserProfile? _profile;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _userService = widget.userService ?? AppServices().userService;
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final profile = await _userService.loadProfile();
      if (!mounted) {
        return;
      }
      setState(() {
        _profile = profile;
        _isLoading = false;
      });
    } on StateError {
      if (!mounted) {
        return;
      }
      setState(() {
        _errorMessage = 'Sign in to view your profile.';
        _isLoading = false;
      });
    } on UserApiException catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _errorMessage = error.message;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _errorMessage = 'Could not load profile.';
        _isLoading = false;
      });
    }
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
    final bio = profile.bio.trim().isEmpty
        ? 'No bio yet. Tap edit to add one.'
        : profile.bio;

    return RefreshIndicator(
      onRefresh: _loadProfile,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
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
      ),
    );
  }
}
