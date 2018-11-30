import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "images-test1.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  // Creating a table name Employee with fields
  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE Image(id INTEGER PRIMARY KEY, file TEXT, description TEXT )");
    print("Created tables");
  }

  Future<List<dynamic>> getImages() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Image');
    print(list);
    List<dynamic> images = new List();
    for (int i = 0; i < list.length; i++) {
      print(list[i]);
      images.add(list[i]);
    }
    return images;
  }

  void saveImage(File image, String description) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO Image(file, description) VALUES(' +
              '\'' +
              image.path +
              '\'' +
              ',' +
              '\'' +
              description +
              '\'' +
              ')');
    });
  }
}
