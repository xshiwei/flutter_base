import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/common/utils/sp_utils.dart';
import 'package:flutter_base/db/base_db_manager.dart';
import 'package:flutter_base/common/config/sp_keys.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataDbManager extends BaseDbManager {
  static Database? _database;

  ///1
  static const DATA_DB_VER_CODE = 1;

  // 获取数据库中所有的表
  Future<List<String>> getTables() async {
    if (_database == null) {
      return Future.value([]);
    }
    List tables = await _database!
        .rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');
    List<String> targetList = [];
    tables.forEach((item) {
      targetList.add(item['name']);
    });
    return targetList;
  }

  // 检查数据库中, 表是否完整, 在部分android中, 会出现表丢失的情况
  Future checkTableIsRight() async {
    List<String> expectTables = ['TRANSLATION', 'level_title'];

    List<String> tables = await getTables();

    for (int i = 0; i < expectTables.length; i++) {
      if (!tables.contains(expectTables[i])) {
        return false;
      }
    }
    return true;
  }

  //初始化数据库
  @override
  Future init() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'translation.db');
    debugPrint(path);
    try {
      _database = await openDatabase(path);
    } catch (e) {
      debugPrint("Error $e");
    }
    bool tableIsRight = await this.checkTableIsRight();

    int dbDataVerCode = await SpUtil.getInt(SpKeys.DB_DATA_VERSION_CODE) ?? 0;

    //是否需要升级
    bool isUpgrade = DATA_DB_VER_CODE > dbDataVerCode;

    if (!tableIsRight || isUpgrade) {
      // 关闭上面打开的db，否则无法执行open
      _database?.close();
      debugPrint("重新加载");
      // Delete the database
      await deleteDatabase(path);

      ByteData data = await rootBundle.load(join("assets", "translation.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);

      _database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        debugPrint('db created version is $version');
      }, onOpen: (Database db) async {
        debugPrint('new db opened');
        //保存版本号
        await SpUtil.putInt(SpKeys.DB_DATA_VERSION_CODE, DATA_DB_VER_CODE);
      });
    } else {
      debugPrint("Opening existing database");
    }
  }

  /// 表是否存在
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
