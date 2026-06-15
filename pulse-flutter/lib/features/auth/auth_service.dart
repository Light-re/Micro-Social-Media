import 'data/auth_repository.dart';
import 'data/auth_response.dart';
import 'data/session_record.dart';
import 'data/session_repository.dart';

/// Orchestrates authentication and local session persistence.
class AuthService {
  AuthService({
    required AuthRepository authRepository,
    required SessionRepository sessionRepository,
    DateTime Function() now = DateTime.now,
  })  : _authRepository = authRepository,
        _sessionRepository = sessionRepository,
        _now = now;

  final AuthRepository _authRepository;
  final SessionRepository _sessionRepository;
  final DateTime Function() _now;

  Future<AuthResponse> login(String email, String password) async {
    final result = await _authRepository.login(email, password);
    await _persist(result);
    return result;
  }

  Future<String?> currentUserId() async {
    final session = await _sessionRepository.getSession();
    return session?.userId;
  }

  Future<void> _persist(AuthResponse result) {
    return _sessionRepository.saveSession(
      SessionRecord(
        userId: result.userId,
        email: result.email,
        username: result.username,
        token: result.token,
        savedAt: _now(),
      ),
    );
  }
}
