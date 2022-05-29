import 'dart:io';

import 'package:attendance_tracker/models/user_image.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String databaseName = 'images.db';
  static const int databaseVersion = 1;

  static const String tableName = 'images';
  static const String columnId = 'id';
  static const String columnEmail = 'mail';
  static const String columnImageModel = 'image';

  factory DatabaseHelper() => _databaseHelper;
  static final DatabaseHelper _databaseHelper = DatabaseHelper._();
  DatabaseHelper._() {
    initDatabase();
  }

  static late Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    await initDatabase();
    return _database;
  }

  Future initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);

    _database = await openDatabase(path,
        version: databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $tableName (
          $columnId INTEGER PRIMARY KEY,
          $columnEmail TEXT NOT NULL,
          $columnImageModel TEXT NOT NULL
        )
    ''');
  }

  Future<int> insert(UserImageModel userImageModel) async {
    Database db = await _databaseHelper.database;
    return await db.insert(tableName, userImageModel.toJson());
  }

  Future<List<UserImageModel>> queryAllImages() async {
    Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> userImages = await db.query(tableName);
    return userImages
        .map((userImage) => UserImageModel.fromJson(userImage))
        .toList();
  }

  Future<int> deleteAll() async {
    Database db = await _databaseHelper.database;
    return await db.delete(tableName);
  }
}
