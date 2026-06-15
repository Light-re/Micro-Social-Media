import 'data/auth_api_repository.dart';
import 'data/session_record.dart';
import 'data/session_repository.dart';

/// Orchestrates auth API calls and local session persistence.
class AuthService {
  AuthService(this._authApiRepository, this._sessionRepository);

  final AuthApiRepository _authApiRepository;
  final SessionRepository _sessionRepository;

  Future<void> register({
    required String email,
    required String username,
    required String password,
  }) async {
    final response = await _authApiRepository.register(
      email: email,
      username: username,
      password: password,
    );
    await _saveSession(response);
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final response = await _authApiRepository.login(
      email: email,
      password: password,
    );
    await _saveSession(response);
  }

  Future<SessionRecord?> currentSession() {
    return _sessionRepository.getSession();
  }

  Future<void> logout() {
    return _sessionRepository.clearSession();
  }

  Future<void> _saveSession(dynamic response) async {
    await _sessionRepository.saveSession(
      SessionRecord(
        userId: response.userId,
        email: response.email,
        username: response.username,
        token: response.token,
        savedAt: DateTime.now().toUtc(),
      ),
    );
  }
}
