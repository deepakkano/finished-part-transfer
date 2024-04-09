import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
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
CREATE TABLE  IF NOT EXISTS usertable (id INTEGER PRIMARY KEY ,name Text ,companyid TEXT,username TEXT,password TEXT,email Text, role Text)
''');
    print("table created 2");
    await db.execute('''
CREATE TABLE IF NOT EXISTS ProductInformation (id INTEGER PRIMARY KEY ,barCodeNo TEXT,productId Text,productName TEXT, manufacturingPlant TEXT,productDiminsion TEXT,productionDescription TEXT,productionReview TEXT,productionCheckUSerId Text,qualityCheckRemark Text,qualityCheckStatus Text,qualityCheckUserID Text,storeRemark Text,StoreStatus Text,storeUserID Text)
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
    Future<List<Map<String, dynamic>>> fetchUserSingleData(companyId) async {
    Database? database = await db;
    return await database!.query('usertable',   where: 'companyid = ?',
      whereArgs: [companyId],
);
  }
     fetchUseremailData(productionId,CheckByUser_QA,CheckByUser_production) async {
    Database? database = await db;
     var result = await database!.rawQuery(
        "select email from usertable where companyId IN('${productionId}','${CheckByUser_QA}','${CheckByUser_production}')");
    if (result.isNotEmpty) {
      // print(result);
      return result;
    } else {
      return false;
    }

  }




  getUserAuth(dbModel model) async {
    Database? database = await db;
    var result = await database!.rawQuery(
        "select * from usertable where companyId = '${model.companyId}' AND username = '${model.username}'AND password = '${model.password}'AND role = '${model.role}'");
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

Future<void>updataproduct(int id,String Description,String Review,String checkuserid)async{
    Database? database = await db;
  await database!.update('ProductInformation', {
    'productionDescription':Description,
    'productionReview':Review,
    'productionCheckUSerId':checkuserid,


},where: 'id=?',
whereArgs: [id]

);
}



Future<List<dbModelAddInformation>>getlistitem(barcode) async{
      Database? database = await db;
      final List<Map<String,dynamic>> queryResult  =await database!.query('ProductInformation' , where: 'barCodeNo = ?',
      whereArgs: [barcode]);
return queryResult.map((e) => dbModelAddInformation.formMap(e)).toList();



}
 Future<List<Map<String, dynamic>>> fetchDataForCompany(companyId) async {
      Database? database = await db;
    return await database!.query(
      'ProductInformation',
      where: 'companyId = ?',
      whereArgs: [companyId],
    );
  }
}

