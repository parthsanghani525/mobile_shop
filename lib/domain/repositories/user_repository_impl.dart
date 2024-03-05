import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../data/models/user.dart';
import '../../data/repositories/user_repository.dart';
import '../../main.dart';

/// Concrete implementation of the UserRepository interface using SQLite database and SharedPreferences.
class UserRepositoryImpl extends UserRepository {
  static Database? _database;

  /// Getter for the database instance.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  /// Initialize the database.
  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, password TEXT, email TEXT, confirmPassword TEXT)",
        );
        await db.execute(
          "CREATE TABLE products(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, price REAL, image TEXT, category TEXT)",
        );
      },
    );
  }

  /// Registers a user in the database.
  @override
  Future<void> registerUser(User user) async {
    final db = await database;
    await db.insert('users', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// Logs in a user with the given username and password.
  @override
  Future<User?> loginUser(String username, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users',
        where: 'username = ? AND password = ?', whereArgs: [username, password]);
    if (maps.isEmpty) {
      return null;
    } else {
      /// Set the login status to true in SharedPreferences.
      await prefs!.setBool('isLogin', true);
      return User.fromMap(maps.first);
    }
  }

  /// Logs out the current user.
  @override
  Future<void> logout() async {
    /// Get SharedPreferences instance.
    prefs = await SharedPreferences.getInstance();
    /// Set the login status to false in SharedPreferences.
    await prefs!.setBool("isLogin", false);
  }
}
