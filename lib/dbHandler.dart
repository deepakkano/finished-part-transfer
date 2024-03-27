import 'dart:async';
import 'dart:io';

import 'package:ftp/modelClass/dbModelAddInformation.dart';
import 'package:ftp/modelClass/db_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class dbHandler {
  Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      Directory directory = await getApplicationDocumentsDirectory();
      final path = join(directory.path, 'techelecondatabase');
      _db = await openDatabase(path, version: 1, onCreate: (_onCreate));
      return _db;
    }
  }

  Future _onCreate(Database db, int version) async {
    print("table created 1");
    await db.execute('''
CREATE TABLE  IF NOT EXISTS usertable (id INTEGER PRIMARY KEY ,companyid TEXT,username TEXT,password TEXT)
''');
    print("table created 2");
    await db.execute('''
CREATE TABLE IF NOT EXISTS ProductInformation (id INTEGER PRIMARY KEY ,barCodeNo TEXT,productName TEXT, manufacturingPlant TEXT,productDiminsion TEXT,Description TEXT,Review TEXT)
''');
  }

  Future insertUserInfomation(dbModel model) async {
    Database? databaseinsert = await db;
    await databaseinsert!.insert('usertable', model.toMap());
  }

  Future<List<Map<String, dynamic>>> fetchUserData() async {
    Database? database = await db;
    return await database!.query('usertable');
  }

  getUserAuth(dbModel model) async {
    Database? database = await db;
    var result = await database!.rawQuery(
        "select * from usertable where companyId = '${model.companyId}' AND username = '${model.username}'AND password = '${model.password}'");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future insertData(dbModelAddInformation model) async {
    Database? databaseinsert = await db;
    await databaseinsert!.insert('ProductInformation', model.toMap());
  }

  Future<List<Map<String, dynamic>>> fetchdata() async {
    Database? database = await db;
    return await database!.query('usertable');
  }

 Future fetchdataProduct( barcode) async {
    Database? database = await db;
    return await database!.query('ProductInformation'   ,   where: 'barCodeNo = ?',
      whereArgs: [barcode],
);
  }

Future<void>updataproduct(int id,String Description,String Review)async{
    Database? database = await db;
  await database!.update('ProductInformation', {
    'Description':Description,
    'Review':Review

},where: 'id=?',
whereArgs: [id]

);
}
}

