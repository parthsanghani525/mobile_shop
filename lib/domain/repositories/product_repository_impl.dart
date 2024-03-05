import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../data/models/product.dart';
import '../../data/repositories/product_repository.dart';

/// Concrete implementation of the ProductRepository interface using SQLite database.
class ProductRepositoryImpl extends ProductRepository {
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
          "CREATE TABLE products(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, price REAL, image TEXT, category TEXT)",
        );
      },
    );
  }

  /// Adds a product to the database.
  @override
  Future<void> addProduct(Product product) async {
    final db = await database;
    await db.insert(
      'products',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Retrieves all products from the database.
  @override
  Future<List<Product>> getAllProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }
}
