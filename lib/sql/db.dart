import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../Model/Expense.dart';

class DatabaseHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE Expense(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        type TEXT,
        date TEXT,
        amount REAL,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'db.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createItem(
    String title,
    String type,
    String date,
    double amount,
  ) async {
    final db = await DatabaseHelper.db();

    final data = {
      'title': title,
      'type': type,
      'date': date,
      'amount': amount,
    };
    final id = await db.insert('Expense', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    print('item has been added');
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DatabaseHelper.db();
    return db.query('Expense', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(String type) async {
    final db = await DatabaseHelper.db();
    return db.query('Expense', where: "type = ?", whereArgs: [type]);
  }

  static Future<int> updateItem(
      int id, String title, String type, String date, double amount) async {
    final db = await DatabaseHelper.db();

    final data = {
      'title': title,
      'type': type,
      'date': date,
      'amount': amount,
      'createdAt': DateTime.now().toString()
    };
    final result =
        await db.update('Expense', data, where: "id=?", whereArgs: [id]);

    return result;
  }

// Delete
  static Future<void> deleteItem(int id) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete("Expense", where: "id = ?", whereArgs: [id]);
      print('iteam has been deleted');
    } catch (err) {
      print("Something went wrong when deleting an item: $err");
    }
  }
}
