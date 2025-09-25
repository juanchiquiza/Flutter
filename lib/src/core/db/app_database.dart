import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class AppDatabase {
  AppDatabase._private();

  static final AppDatabase instance = AppDatabase._private();
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    final docs = await getApplicationDocumentsDirectory();
    final path = join(docs.path, 'user_addresses_fixed.db');
    _db = await openDatabase(path, version: 1, onCreate: _onCreate);
    await _db!.execute('PRAGMA foreign_keys = ON');
    return _db!;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        firstName TEXT NOT NULL,
        lastName TEXT NOT NULL,
        dob TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE addresses (
        id TEXT PRIMARY KEY,
        userId TEXT NOT NULL,
        line TEXT NOT NULL,
        country TEXT NOT NULL,
        department TEXT NOT NULL,
        municipality TEXT NOT NULL,
        isPhysicalToAccount INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY(userId) REFERENCES users(id) ON DELETE CASCADE
      );
    ''');
  }
}
