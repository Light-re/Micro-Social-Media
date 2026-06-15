import '../auth/data/session_record.dart';
import '../auth/data/session_repository.dart';
import 'data/user_api_repository.dart';
import 'data/user_profile.dart';

/// Loads and updates the authenticated user's profile.
class UserService {
  UserService(this._userApiRepository, this._sessionRepository);

  final UserApiRepository _userApiRepository;
  final SessionRepository _sessionRepository;

  Future<UserProfile> loadProfile() async {
    final session = await _requireSession();
    return _userApiRepository.fetchMe(session.token);
  }

  Future<UserProfile> updateProfile({
    required String username,
    required String bio,
  }) async {
    final session = await _requireSession();
    final profile = await _userApiRepository.updateMe(
      token: session.token,
      username: username,
      bio: bio,
    );
    await _sessionRepository.saveSession(
      SessionRecord(
        userId: session.userId,
        email: session.email,
        username: profile.username,
        token: session.token,
        savedAt: DateTime.now().toUtc(),
      ),
    );
    return profile;
  }

  Future<SessionRecord> _requireSession() async {
    final session = await _sessionRepository.getSession();
    if (session == null) {
      throw StateError('No active session');
    }
    return session;
  }
}
