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
            'CREATE TABLE borrowed_vests(id INTEGER PRIMARY KEY,name TEXT,duration INTEGER,arrivalTime TEXT,size TEXT,isStopped INTEGER, isOver INTEGER)');
        await db.execute(
            'CREATE TABLE daily_customers(arrivalTime TEXT PRIMARY KEY,name TEXT,number INTEGER,signature TEXT, expdate TEXT)');
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

  static Future<void> removeAll(String table) async {
    final db = await DBHelper.database();
    db.delete(table, where: null);
  }

  static Future<void> removeS(String table, String delid) async {
    final db = await DBHelper.database();
    db.delete(table, where: 'arrivalTime = ?', whereArgs: [delid]);
  }

  static Future<void> updateIntData(
      String table, String columnName, int data, int id) async {
    final db = await DBHelper.database();
    int res = await db.rawUpdate(
        'UPDATE ${table} SET ${columnName} = ? WHERE id = ?', [data, id]);
    return res;
  }

  static Future<void> updateData(
      String table, String expdate, String arrivalTime) async {
    final db = await DBHelper.database();
    int res = await db.rawUpdate(
        'UPDATE ${table} SET expdate = ? WHERE arrivalTime = ?',
        [expdate, arrivalTime]);
    return res;
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<void> pushAllData(
    String table,
    List<Map<String, Object>> data,
  ) async {
    final db = await DBHelper.database();
    data.forEach((element) async {
      await db.insert(
        table,
        element,
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
    });
  }
}
