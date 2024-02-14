import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../../../../entity/product.dart';

class SQLHelper {
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""create table products(
      id integer primary key autoincrement not null,
      quantity integer,
      productId integer,
      createdAt timestamp not null default current_timestamp      
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase("byproduct.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTable(database);
    });
  }

  static Future<int> createProduct(data) async {
    final db = await SQLHelper.db();
    final id = await db.insert("products", data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getProducts() async {
    final db = await SQLHelper.db();
    return await db.query("products", orderBy: 'id');
  }

  static Future<List<Map<String, Object?>>> getProduct(int? id) async {
    final db = await SQLHelper.db();
    return await db.query("products",
        where: 'productId = ?', whereArgs: [id], limit: 1);
  }

  static Future<int> updateProduct(
      int? id, int quantity, Product? product) async {
    final db = await SQLHelper.db();

    // final jsonProduct = product.toJson();

    final data = {
      "quantity": quantity,
      "productId": product?.id,
      "createdAt": DateTime.now().toString()
    };

    final result = await db
        .update("products", data, where: "productId = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteProduct(int? id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("products", where: "productId = ?", whereArgs: [id]);
    } catch (e) {
      debugPrint("Something went wrong when deleting an product: $e");
    }
  }
  static Future<void> deleteProducts() async {
    final db = await SQLHelper.db();
    try {
      await db.delete("products");
    } catch (e) {
      debugPrint("Something went wrong when deleting an product: $e");
    }
  }


  static Future<void> createThemeState(String name) async {
    final db = await SQLHelper.db();
    try {
      db.insert("isDark", {"dark": name});
    } catch (err) {
        debugPrint("unknown error for theme query $err");
    }
  }

  static Future<List<Map<String, Object?>>> readThemeState() async {
    final db = await SQLHelper.db();
    List<Map<String, dynamic>> result = [];
    try {
      result = await db.query("isDark");
    } catch (err) {
      debugPrint("unknown error for theme query $err");
    }
    return result;
  }
}
