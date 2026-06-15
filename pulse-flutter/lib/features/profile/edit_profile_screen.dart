import 'package:flutter/material.dart';

import '../../core/widgets/pulse_components.dart';
import '../auth/validators/form_validators.dart';
import '../user/data/user_api_repository.dart';
import '../user/data/user_profile.dart';
import '../user/user_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
    required this.initialProfile,
    required this.userService,
  });

  final UserProfile initialProfile;
  final UserService userService;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  late final TextEditingController _bioController;
  bool _isSaving = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.initialProfile.username);
    _bioController = TextEditingController(text: widget.initialProfile.bio);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _errorMessage = null);
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSaving = true);
    try {
      final profile = await widget.userService.updateProfile(
        username: _usernameController.text.trim(),
        bio: _bioController.text.trim(),
      );
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop(profile);
    } on UserApiException catch (error) {
      setState(() => _errorMessage = error.message);
    } catch (_) {
      setState(() => _errorMessage = 'Could not save profile.');
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit profile')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PulseTextField(
                  label: 'Username',
                  controller: _usernameController,
                  validator: validateUsername,
                ),
                const SizedBox(height: 16),
                PulseTextField(
                  label: 'Bio',
                  controller: _bioController,
                  maxLines: 4,
                  validator: validateBio,
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                  ),
                ],
                const SizedBox(height: 28),
                PulseButton(
                  label: _isSaving ? 'Saving…' : 'Save changes',
                  onPressed: _isSaving ? () {} : _save,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
