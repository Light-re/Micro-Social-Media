import 'package:flutter/material.dart';

import '../../core/di/app_scope.dart';
import '../../core/theme/pulse_theme.dart';
import '../home/home_shell.dart';
import '../home/welcome_screen.dart';
import 'auth_service.dart';

enum _AuthDestination { loading, welcome, home }

/// Restores session on startup and routes to feed or welcome (US-07).
class AuthGateScreen extends StatefulWidget {
  const AuthGateScreen({super.key, this.authService});

  final AuthService? authService;

  @override
  State<AuthGateScreen> createState() => _AuthGateScreenState();
}

class _AuthGateScreenState extends State<AuthGateScreen> {
  AuthService? _authService;
  _AuthDestination _destination = _AuthDestination.loading;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_authService != null) {
      return;
    }
    _authService = widget.authService ?? AppScope.of(context).authService;
    _resolveDestination();
  }

  Future<void> _resolveDestination() async {
    try {
      final session = await _authService!.currentSession().timeout(
        const Duration(seconds: 5),
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _destination = session == null
            ? _AuthDestination.welcome
            : _AuthDestination.home;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() => _destination = _AuthDestination.welcome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return switch (_destination) {
      _AuthDestination.loading => Theme(
          data: PulseTheme.light(),
          child: const Scaffold(
            backgroundColor: Color(0xFFF2F2F7),
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFFE07373)),
            ),
          ),
        ),
      _AuthDestination.welcome => const WelcomeScreen(),
      _AuthDestination.home => const HomeShell(),
    };
  }
}
