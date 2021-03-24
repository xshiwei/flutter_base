import 'dart:async';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_base/db/base_db_manager.dart';

///基类
abstract class BaseDbProvider {
  bool isTableExits = false;

  tableSqlString();

  tableName();

  BaseDbManager getDbManager();

  tableBaseString(String name, String columnId) {
    return '''
        create table $name (
        $columnId integer primary key autoincrement,
      ''';
  }

  Future<Database> getDataBase() async {
    return await open();
  }

  @mustCallSuper
  prepare(name, String createSql) async {
    isTableExits = await getDbManager().isTableExits(name);
    if (!isTableExits) {
      Database db = await getDbManager().getCurrentDatabase();
      return await db.execute(createSql);
    }
  }

  @mustCallSuper
  open() async {
    if (!isTableExits) {
      await prepare(tableName(), tableSqlString());
    }
    return await getDbManager().getCurrentDatabase();
  }
}
