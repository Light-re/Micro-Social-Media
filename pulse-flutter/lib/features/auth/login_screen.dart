import 'package:flutter/material.dart';

import '../../core/di/app_scope.dart';
import '../../core/network/api_exception.dart';
import '../../core/widgets/pulse_components.dart';
import '../home/home_shell.dart';
import 'auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Sign in to see posts from people you follow.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).textTheme.labelMedium?.color,
                    ),
              ),
              const SizedBox(height: 32),
              PulseTextField(
                label: 'Email',
                controller: _emailController,
              ),
              const SizedBox(height: 16),
              PulseTextField(
                label: 'Password',
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 28),
              PulseButton(
                label: _isSubmitting ? 'Signing in…' : 'Sign in',
                onPressed: _isSubmitting ? null : _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final AuthService authService = AppScope.of(context).authService;
    setState(() => _isSubmitting = true);
    try {
      await authService.login(
        _emailController.text.trim(),
        _passwordController.text,
      );
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (_) => const HomeShell()),
        (_) => false,
      );
    } on ApiException catch (error) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message)));
    }
  }
}
