import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'micro_habits.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE habits(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        frequency TEXT,
        completed_count INTEGER DEFAULT 0,
        last_completed TEXT
      )
    ''');
  }

  // CRUD Operations
  Future<int> insertHabit(Map<String, dynamic> habit) async {
    Database db = await database;
    return await db.insert('habits', habit);
  }

  Future<List<Map<String, dynamic>>> getHabits() async {
    Database db = await database;
    return await db.query('habits');
  }

  Future<int> updateHabit(Map<String, dynamic> habit) async {
    Database db = await database;
    return await db.update(
      'habits',
      habit,
      where: 'id = ?',
      whereArgs: [habit['id']],
    );
  }

  Future<int> deleteHabit(int id) async {
    Database db = await database;
    return await db.delete(
      'habits',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Compliance: Data Deletion
  Future<void> deleteAllData() async {
    Database db = await database;
    await db.delete('habits');
    // Alternatively, delete the database file itself
    // String path = join(await getDatabasesPath(), 'micro_habits.db');
    // await deleteDatabase(path);
  }
}
