import 'package:sqflite/sqflite.dart';

import '../../../core/database/app_database.dart';
import 'session_record.dart';

/// Persists JWT session data locally for offline auth checks (US-07).
class SessionRepository {
  SessionRepository(this._database);

  final AppDatabase _database;

  Future<void> saveSession(SessionRecord session) async {
    final db = await _database.database;
    await db.insert(
      'user_session',
      session.toRow(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<SessionRecord?> getSession() async {
    final db = await _database.database;
    final rows = await db.query(
      'user_session',
      where: 'id = ?',
      whereArgs: [1],
      limit: 1,
    );

    if (rows.isEmpty) {
      return null;
    }

    return SessionRecord.fromRow(rows.first);
  }

  Future<void> clearSession() async {
    final db = await _database.database;
    await db.delete('user_session', where: 'id = ?', whereArgs: [1]);
  }
}
