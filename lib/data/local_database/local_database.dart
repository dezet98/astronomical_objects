import 'package:codetomobile/shared/errors.dart';
import 'package:codetomobile/shared/exceptions.dart';
import 'package:codetomobile/shared/logger/app_logger.dart';
import 'package:codetomobile/shared/platforms.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'database_object.dart';

class LocalDatabase {
  final String _name;
  final int _version;
  final List<DataBaseObject> _dataBaseObjects;
  Database? _database;

  LocalDatabase(this._name, this._version, this._dataBaseObjects);

  Future<String?> _databasePath() async {
    if (PlatformInfo.isDesktop) {
      sqfliteFfiInit();
      return join((await databaseFactoryFfi.getDatabasesPath()), _name);
    } else if (PlatformInfo.isMobile) {
      return join(((await getApplicationDocumentsDirectory()).path), _name);
    }
    return Future.value(null);
  }

  Future<void> _openDatabase() async {
    try {
      var path = await _databasePath();

      if (path != null) {
        _database = await databaseFactoryFfi.openDatabase(path,
            options:
                OpenDatabaseOptions(onCreate: _onCreate, version: _version));
      } else {
        throw LocalDatabaseFailureException(
            LocalDatabaseError.DATABASE_PATH_NULL_ERROR);
      }
    } catch (e) {
      throw LocalDatabaseFailureException(
          LocalDatabaseError.OPEN_DATABASE_ERROR);
    }
  }

  Future<void> closeDatabase() async {
    try {
      if (_database!.isOpen) {
        await _database!.close();
      }
    } catch (e) {
      throw LocalDatabaseFailureException(
          LocalDatabaseError.CLOSE_DATABASE_ERROR);
    }
  }

  void _onCreate(Database db, int version) async {
    try {
      for (DataBaseObject dataBaseObject in _dataBaseObjects) {
        String query = dataBaseObject.createTable();
        await db.execute(query);
      }
    } catch (e) {
      throw LocalDatabaseFailureException(
          LocalDatabaseError.CREATE_TABLES_ERROR);
    }
  }

  Future<void> _checkIfOpen() async {
    if (_database == null || _database!.isOpen == false) {
      return await _openDatabase();
    }
  }

  // ---------------- insert ----------------
  Future<int> insertQuery(String tableName, Map<String, dynamic> map) async {
    await _checkIfOpen();
    return await _database!.insert(tableName, map).whenComplete(
          () => AppLogger().log(
              message:
                  "LocalDatabase INSERT complete for { tableName: $tableName, map: $map }",
              logLevel: LogLevel.info),
        );
  }

  // ---------------- query ----------------
  Future<List<Map<String, Object?>>> query(String tableName) async {
    await _checkIfOpen();
    return await _database!.query(tableName).whenComplete(
          () => AppLogger().log(
              message:
                  "LocalDatabase QUERY complete for { tableName: $tableName }",
              logLevel: LogLevel.info),
        );
  }

  // ---------------- delete ----------------
  Future<int> delete(
      String tableName, String? columnName, dynamic? columnValue) async {
    await _checkIfOpen();

    return await _database!
        .delete(
          tableName,
          where: columnName != null ? "$columnName = ?" : null,
          whereArgs: columnName != null ? [columnValue] : null,
        )
        .whenComplete(
          () => AppLogger().log(
              message:
                  "LocalDatabase DELETE complete for { tableName: $tableName, columnName: $columnName, columnValue: $columnValue }",
              logLevel: LogLevel.info),
        );
  }
}
