import 'dart:async';
import 'package:flutter_base/db/base_db_manager.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDbManager extends BaseDbManager {
  static const _VERSION = 1;

  static const _NAME = "user.db";

  static Database? _database;

  ///初始化
  @override
  Future init() async {
    // open the database
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _NAME);
    _database = await openDatabase(path,
        version: _VERSION, onCreate: (Database db, int version) async {},
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
      // var batch = db.batch();
      // await batch.commit(continueOnError: true);
    });
  }

  ///表是否存在
  @override
  isTableExits(String tableName) async {
    await getCurrentDatabase();
    var res = await _database?.rawQuery(
        "select * from Sqlite_master where type = 'table' and name = '$tableName'");
    return res != null && res.length > 0;
  }

  ///获取当前数据库对象
  @override
  Future<Database> getCurrentDatabase() async {
    if (_database == null) {
      await init();
    }
    return _database!;
  }

  ///关闭
  @override
  Future close() async {
    _database?.close();
    _database = null;
  }
}
