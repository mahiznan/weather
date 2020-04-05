import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather/core/model/city.dart';

class DatabaseHelper {
  static final _databaseName = "customweather.db";
  static final _databaseVersion = 2;

  static final table = 'cities';

  static final columnWoeId = 'woeid';
  static final columnTitle = 'title';
  static final columnLocationType = 'location_type';
  static final columnLattLong = 'latt_long';
  static final columnIsFavorite = 'favorite';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + '/' + _databaseName;
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);

    //deleteDB();
  }

  deleteDB() async {
    print('Delete DB is called');
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + '/' + _databaseName;
    deleteDatabase(path);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnWoeId INTEGER PRIMARY KEY,
            $columnTitle TEXT NOT NULL,
            $columnLocationType TEXT NOT NULL,
            $columnLattLong TEXT NOT NULL,
            $columnIsFavorite INTEGER NOT NULL
          )
          ''');
  }

  Future<int> insertBookMark(City city) async {
    if (await notExist(city.woeid)) {
      Map<String, dynamic> row = {
        DatabaseHelper.columnWoeId: city.woeid,
        DatabaseHelper.columnTitle: city.title,
        DatabaseHelper.columnLocationType:
            locationTypeValues.reverse[city.locationType],
        DatabaseHelper.columnLattLong: city.lattLong,
        DatabaseHelper.columnIsFavorite: 0,
      };
      Database db = await instance.database;
      return await db.insert(table, row);
    }
    return -1;
  }

  Future<void> setFavoriteBookMark(City city) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnWoeId: city.woeid,
      DatabaseHelper.columnTitle: city.title,
      DatabaseHelper.columnLocationType:
          locationTypeValues.reverse[city.locationType],
      DatabaseHelper.columnLattLong: city.lattLong,
      DatabaseHelper.columnIsFavorite: 1,
    };
    Database db = await instance.database;
    await db.rawQuery('UPDATE $table set favorite=0');
    if (await notExist(city.woeid)) {
      print('Entry does not exist, so inserting');
      db.insert(table, row);
    } else {
      print('Entry does exist, so updating');
      update(row);
    }
  }

  void removeFavoriteBookMark(City city) {
    Map<String, dynamic> row = {
      DatabaseHelper.columnWoeId: city.woeid,
      DatabaseHelper.columnTitle: city.title,
      DatabaseHelper.columnLocationType:
          locationTypeValues.reverse[city.locationType],
      DatabaseHelper.columnLattLong: city.lattLong,
      DatabaseHelper.columnIsFavorite: 0,
    };
    update(row);
  }

  Future<bool> notExist(int woeid) async {
    Database db = await instance.database;
    List<Map> result = await db.query(table,
        columns: [columnWoeId], where: '$columnWoeId = ?', whereArgs: [woeid]);
    if (result.length == 0) {
      return true;
    }
    return false;
  }

  Future<bool> isFavorite(int woeid) async {
    Database db = await instance.database;
    List<Map> result = await db.query(table,
        columns: [columnWoeId, columnIsFavorite],
        where: '$columnWoeId = ? and $columnIsFavorite = ?',
        whereArgs: [woeid, 1]);
    if (result.length > 0) {
      return true;
    }
    return false;
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  // Future<List<Map<String, dynamic>>>
  Future<List<City>> queryAllRows() async {
    Database db = await instance.database;
    var response = await db.query(table);
    return List.generate(response.length, (i) {
      return City.fromJson(response[i]);
    });
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnWoeId];
    return await db
        .update(table, row, where: '$columnWoeId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnWoeId = ?', whereArgs: [id]);
  }
}
