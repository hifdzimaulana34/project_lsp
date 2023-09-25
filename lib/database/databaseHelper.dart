import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');
    print('Database path: $path');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        print('Creating database tables...');
        db.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT,
      password TEXT
    )
  ''');

        db.execute('''
    CREATE TABLE income (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      tanggal TEXT,
      nominal REAL,
      keterangan TEXT,
      kategori TEXT
    )
  ''');
      },
    );
  }

  Future<int> updatePassword(String username, String newPassword) async {
    final db = await database;
    return await db.update(
      'users',
      {
        'password': newPassword,
      },
      where: 'username = ?',
      whereArgs: [username],
    );
  }

  Future<int> insertTestUser() async {
    final db = await database;
    return await db.insert(
      'users',
      {
        'username': 'user',
        'password': 'user',
      },
    );
  }

  Future<Map<String, dynamic>?> getUser({required String username}) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<int> insertIncome(String tanggal, double nominal, String keterangan,
      String kategori) async {
    final db = await database;
    final kategori = 'pemasukan';
    return await db.insert(
      'income',
      {
        'tanggal': tanggal,
        'nominal': nominal,
        'keterangan': keterangan,
        'kategori': kategori,
      },
    );
  }

  Future<int> insertExpense(String tanggal, double nominal, String keterangan,
      String kategori) async {
    final db = await database;
    final kategori = 'pengeluaran';
    return await db.insert(
      'income',
      {
        'tanggal': tanggal,
        'nominal': nominal,
        'keterangan': keterangan,
        'kategori': kategori,
      },
    );
  }

  Future<List<Map<String, dynamic>>> getIncomeData() async {
    final db = await database;
    return await db.query('income');
  }

  Future<int> deleteIncome(int id) async {
    final db = await database;
    return await db.delete(
      'income',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
