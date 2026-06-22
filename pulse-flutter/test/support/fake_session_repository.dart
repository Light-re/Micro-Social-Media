import 'package:pulse/features/auth/data/session_record.dart';
import 'package:pulse/features/auth/data/session_repository.dart';

/// In-memory [SessionRepository] so tests avoid sqflite, whose isolate-backed
/// futures do not resolve under the widget tester's clock.
class FakeSessionRepository implements SessionRepository {
  FakeSessionRepository([this._record]);

  SessionRecord? _record;

  @override
  Future<void> saveSession(SessionRecord session) async => _record = session;

  @override
  Future<SessionRecord?> getSession() async => _record;

  @override
  Future<void> clearSession() async => _record = null;
}
