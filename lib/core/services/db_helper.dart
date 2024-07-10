import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;

  DBHelper._internal();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'cashbook.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT NOT NULL,
        amount REAL NOT NULL,
        description TEXT,
        date TEXT NOT NULL,
        user_id INTEGER NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(id)
      )
    ''');
  }

  Future<int> insertTransaction(Map<String, dynamic> transaction) async {
    Database? db = await database;
    return await db!.insert('transactions', transaction);
  }

  Future<List<Map<String, dynamic>>> getTransactionsByUser(int userId) async {
    Database? db = await database;
    return await db!.query(
      'transactions',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  Future<int> signUp(String username, String password) async {
    Database? db = await database;
    // Cek apakah username sudah ada
    var existingUser = await db!.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    if (existingUser.isNotEmpty) {
      throw Exception("Username already exists");
    }
    // Tambahkan pengguna baru
    var user = {
      'username': username,
      'password': password,
    };
    return await db.insert('users', user);
  }

  Future<Map<String, double>> getMonthlySummary(int userId) async {
    Database? db = await database;
    String currentMonth = DateTime.now().toString().substring(0, 7);

    List<Map<String, dynamic>> incomeResult = await db!.rawQuery('''
      SELECT SUM(amount) as total FROM transactions 
      WHERE user_id = ? AND type = 'income' AND date LIKE ?
    ''', [userId, '$currentMonth%']);

    List<Map<String, dynamic>> outcomeResult = await db.rawQuery('''
      SELECT SUM(amount) as total FROM transactions 
      WHERE user_id = ? AND type = 'outcome' AND date LIKE ?
    ''', [userId, '$currentMonth%']);

    double totalIncome = incomeResult[0]['total'] ?? 0.0;
    double totalOutcome = outcomeResult[0]['total'] ?? 0.0;

    return {
      'income': totalIncome,
      'outcome': totalOutcome,
    };
  }

  Future<List<Map<String, dynamic>>> getDailySummary(int userId) async {
    Database? db = await database;
    String currentMonth = DateTime.now().toString().substring(0, 7);

    return await db!.rawQuery('''
      SELECT 
        date, 
        SUM(CASE WHEN type = 'income' THEN amount ELSE 0 END) as totalIncome,
        SUM(CASE WHEN type = 'outcome' THEN amount ELSE 0 END) as totalOutcome
      FROM transactions
      WHERE user_id = ? AND date LIKE ?
      GROUP BY date
      ORDER BY date ASC
    ''', [userId, '$currentMonth%']);
  }

  Future<Map<String, dynamic>?> getUser(String username) async {
    Database? db = await database;
    List<Map<String, dynamic>> result = await db!.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<int> updateUserPassword(String username, String newPassword) async {
    Database? db = await database;
    return await db!.update(
      'users',
      {'password': newPassword},
      where: 'username = ?',
      whereArgs: [username],
    );
  }

  Future<Map<String, dynamic>?> getUserByUsernameAndPassword(
      String username, String password) async {
    Database? db = await database;
    List<Map<String, dynamic>> result = await db!.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }
}
