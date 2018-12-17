import 'dart:io';
import 'package:flutter_login_sample/models/user.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;
  static int databaseVersion = 1;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  DatabaseHelper.internal();

  initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "sample.db");
    var ourDb = await openDatabase(path, version: databaseVersion, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE user_login_details(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT NOT NULL, password TEXT NOT NULL)");
    print("user_login_details table is created");
  }

  //insertion
  Future<bool> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("user_login_details", user.toMap());
    print(user.toMap().toString());
    return res != -1;
  }

  //deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.delete("user_login_details");
    return res;
  }

  //check login details
  Future<bool> checkLogin(String username, String password) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("select * from user_login_details where username ='"+username+"' and password ='"+password+"'");
    if (result.length > 0) {
      return true;
    } else{
      return false;
    }
  }
}
