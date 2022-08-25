import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'vests.db'),
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE basic_vests(id INTEGER PRIMARY KEY,size TEXT)');
        await db.execute(
            'CREATE TABLE borrowed_vests(id INTEGER PRIMARY KEY,name TEXT,duration INTEGER,arrivalTime TEXT,size TEXT)');
        await db.execute(
            'CREATE TABLE daily_customers(id INTEGER PRIMARY KEY,name TEXT,duration INTEGER,signature TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.ignore);
  }

  static Future<void> remove(String table, int delid) async {
    final db = await DBHelper.database();
    db.delete(table, where: 'id = ?', whereArgs: [delid]);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
