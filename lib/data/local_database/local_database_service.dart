import 'package:codetomobile/shared/errors.dart';
import 'package:codetomobile/shared/exceptions.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_object.dart';

class LocalDatabaseService {
  final String _name;
  final int _version;
  final List<DataBaseObject> _dataBaseObjects;
  Database? _database;

  LocalDatabaseService(this._name, this._version, this._dataBaseObjects);

  Future<String?> _databasePath() async {
    return join(await getDatabasesPath(), _name);
  }

  Future<void> _openDatabase() async {
    try {
      var path = await _databasePath();

      if (path != null) {
        _database = await databaseFactory.openDatabase(path,
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

  // insert
  Future<int> _insert(
      String tableName, Map<String, dynamic> map, dynamic x) async {
    return await x.insert(tableName, map);
  }

  Future<int> insertQuery(String tableName, Map<String, dynamic> map) async {
    await _checkIfOpen();
    return await _insert(tableName, map, _database!);
  }

  // query
  Future<List<Map<String, Object?>>> _query(String tableName, dynamic x) async {
    return await x.query(tableName);
  }

  Future<List<Map<String, Object?>>> query(String tableName) async {
    await _checkIfOpen();
    return await _query(tableName, _database!);
  }
}
