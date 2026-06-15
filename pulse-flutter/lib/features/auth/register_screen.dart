import 'package:flutter/material.dart';

import '../../core/di/app_scope.dart';
import '../../core/widgets/pulse_components.dart';
import '../home/home_shell.dart';
import 'auth_service.dart';
import 'data/auth_api_repository.dart';
import 'validators/form_validators.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, this.authService});

  final AuthService? authService;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  late final AuthService _authService;
  bool _servicesResolved = false;
  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_servicesResolved) {
      return;
    }
    _servicesResolved = true;
    _authService = widget.authService ?? AppScope.of(context).authService;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _errorMessage = null);
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      await _authService.register(
        email: _emailController.text.trim(),
        username: _usernameController.text.trim(),
        password: _passwordController.text,
      );
      if (!mounted) {
        return;
      }
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (_) => const HomeShell()),
        (_) => false,
      );
    } on AuthApiException catch (error) {
      setState(() => _errorMessage = error.message);
    } catch (_) {
      setState(() => _errorMessage = 'Registration failed. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create account')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Join Pulse',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Create an account to share posts with people you follow.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).textTheme.labelMedium?.color,
                      ),
                ),
                const SizedBox(height: 32),
                PulseTextField(
                  label: 'Email',
                  controller: _emailController,
                  validator: validateEmail,
                ),
                const SizedBox(height: 16),
                PulseTextField(
                  label: 'Username',
                  controller: _usernameController,
                  validator: validateUsername,
                ),
                const SizedBox(height: 16),
                PulseTextField(
                  label: 'Password',
                  controller: _passwordController,
                  obscureText: true,
                  validator: validatePassword,
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
                  label: _isSubmitting ? 'Creating account…' : 'Create account',
                  onPressed: _isSubmitting ? () {} : _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
