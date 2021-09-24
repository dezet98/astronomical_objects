class DatabaseColumn {
  final String name;
  final DbColumnType columnType;
  final bool isPrimaryKey;

  DatabaseColumn({
    required this.name,
    required this.columnType,
    this.isPrimaryKey = false,
  });

  String get type {
    switch (columnType) {
      case DbColumnType.STRING:
        return "STRING";
      case DbColumnType.INT:
        return "INTEGER";
      case DbColumnType.TEXT:
        return "TEXT";
      case DbColumnType.DOUBLE:
        return "DOUBLE";
    }
  }
}

class DataBaseObject {
  List<DatabaseColumn> databaseColumns;
  String tableName;

  DataBaseObject({required this.databaseColumns, required this.tableName});

  String createTable() {
    String query = "CREATE TABLE $tableName (";

    var columnsLength = databaseColumns.length;
    for (var i = 0; i < columnsLength; i++) {
      query += "${databaseColumns[i].name} ${databaseColumns[i].type}";

      if (databaseColumns[i].isPrimaryKey) query += " " + primaryKeyName;

      query += (i == columnsLength - 1) ? '' : ', ';
    }

    query += ")";

    return query;
  }

  static String get primaryKeyName => "PRIMARY KEY";
}

enum DbColumnType { STRING, INT, TEXT, DOUBLE }
