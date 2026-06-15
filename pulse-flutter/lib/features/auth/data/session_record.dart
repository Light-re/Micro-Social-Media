/// Local session data stored in SQLite (`user_session` table).
class SessionRecord {
  const SessionRecord({
    required this.userId,
    required this.email,
    required this.username,
    required this.token,
    required this.savedAt,
  });

  final String userId;
  final String email;
  final String username;
  final String token;
  final DateTime savedAt;

  Map<String, Object> toRow() {
    return {
      'id': 1,
      'user_id': userId,
      'email': email,
      'username': username,
      'token': token,
      'saved_at': savedAt.toUtc().toIso8601String(),
    };
  }

  factory SessionRecord.fromRow(Map<String, Object?> row) {
    return SessionRecord(
      userId: row['user_id']! as String,
      email: row['email']! as String,
      username: row['username']! as String,
      token: row['token']! as String,
      savedAt: DateTime.parse(row['saved_at']! as String),
    );
  }
}
