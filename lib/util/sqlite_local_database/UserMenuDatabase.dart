import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class UserMenuDatabase {
  static final _databaseName = "My_Database117.db";
  static final _databaseVersion = 1;

  static final table = 'users_menus';

  static final userAccessToken = 'user_id';
  static final storeName = 'store_name';
  static final menuThumbnailPath = 'thumbnail_path';
  static final options = 'options';
  static final menuName = 'menu_name';

  // make this a singleton class
  UserMenuDatabase._privateConstructor();
  static final UserMenuDatabase instance =
      UserMenuDatabase._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, _databaseName);
    print(_databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    print(table);
    print("ttt");
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $table (
            $userAccessToken STRING,
            $storeName TEXT NOT NULL,
            $menuThumbnailPath STRING NOT NULL,
            $options STRING NOT NULL,
            $menuName STRING NOT NULL
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.

  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    String id = row[UserMenuDatabase.userAccessToken];
    String idKey = UserMenuDatabase.userAccessToken;
    // int? count =
    //   Sqflite.firstIntValue(await db!.rawQuery('SELECT * FROM $table WHERE $idKey="$id"'));
    // if (count! > 0) {
    //   return 0;
    // }
    return await db!.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  Future<List<Map<String, dynamic>>> queryRowByUserToken(
      String accessToken, int N) async {
    Database? db = await instance.database;
    return await db!.rawQuery(
        'SELECT * FROM $table WHERE $userAccessToken="$accessToken" LIMIT $N;');
  }
  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    String id = row[userAccessToken];
    return await db!
        .update(table, row, where: '$userAccessToken = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!
        .delete(table, where: '$userAccessToken = ?', whereArgs: [id]);
  }
}