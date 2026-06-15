import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

/// Opens the local SQLite database used for session and cache data.
class AppDatabase {
  AppDatabase({DatabaseFactory? databaseFactory})
      : _databaseFactory = databaseFactory;

  static const databaseName = 'pulse.db';
  static const databaseVersion = 1;

  final DatabaseFactory? _databaseFactory;
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _open();
    return _database!;
  }

  Future<Database> _open() async {
    final factory = _databaseFactory ?? databaseFactory;
    final basePath = await factory.getDatabasesPath();
    final path = p.join(basePath, databaseName);

    return factory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: databaseVersion,
        onCreate: _onCreate,
      ),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user_session (
        id INTEGER PRIMARY KEY CHECK (id = 1),
        user_id TEXT NOT NULL,
        email TEXT NOT NULL,
        username TEXT NOT NULL,
        token TEXT NOT NULL,
        saved_at TEXT NOT NULL
      )
    ''');
  }

  Future<void> close() async {
    await _database?.close();
    _database = null;
  }
}
