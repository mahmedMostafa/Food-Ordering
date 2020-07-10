import 'package:path/path.dart' as path;
import 'package:res_delivery/models/PopularItem.dart';
import 'package:sqflite/sqflite.dart' as sql;

class CartDatabase {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'cart.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_cart(id TEXT PRIMARY KEY, title TEXT, image TEXT, price DOUBLE, amount INTEGER)');
      },
      version: 1,
    );
  }

  static Future<void> insert(PopularItem data) async {
    final db = await database();
    await db.insert("user_cart", data.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getCart() async {
    final db = await database();
    return db.query("user_cart");
  }

  static Future<void> updateAmount(PopularItem data, bool increase) async {
    final db = await database();
    data.amount = increase ? data.amount++ : data.amount--;
    return db.update("user_car", data.toMap(), where: "id = ?");
  }
}
