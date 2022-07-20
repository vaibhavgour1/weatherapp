import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/model.dart';
import 'constant.dart';

class DatabaseHelper extends ChangeNotifier {
  static final DatabaseHelper db = DatabaseHelper.internal();

  DatabaseHelper.internal();

  factory DatabaseHelper() {
    return db;
  }

  static Database? database;

  static Future<Database> getDatabase() async {
    if (database == null) {
      database = await initDB();
    }
    return database!;
  }

  static initDB() async {
    print("init-----db");
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DBConstant.DATA_BASE_NAME);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE ${DBConstant.WEATHER_TABLE} ("
          "${DBConstant.WEATHERID} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
          "${DBConstant.DATETIME} TEXT NOT NULL,"
          "${DBConstant.WIND} TEXT NOT NULL,"
          "${DBConstant.LIGHTRAIN} TEXT NOT NULL,"
          "${DBConstant.PRESSURE} TEXT NOT NULL,"
          "${DBConstant.HUMIDITY} TEXT NOT NULL,"
          "${DBConstant.TEMP} TEXT NOT NULL,"
          "${DBConstant.NAME} TEXT NOT NULL"
          ")");
    });
  }

  static Future<int> addWeatherData(WeatherModel weatherModel) async {
    print("addWeatherData--");
    int id = 0;
    try {
      final db = await getDatabase();

      var data =
          await db.insert(DBConstant.WEATHER_TABLE, weatherModel.toMap());
      print("data-->$data");

      /**
       * close database
       */
      // db.close();
    } catch (error) {
      print('DatabaseHelper: $error');
    }

    return id;
  }

  // static Future<bool> checkData(
  //     String TableName, String dbfield, String fieldValue) async {
  //   bool isExist = false;
  //   final db = await getDatabase();
  //   String Query =
  //       "Select * from " + TableName + " where " + dbfield + " = " + fieldValue;
  //   List<Map> result = await db.rawQuery(Query);
  //   if (result.length > 0) {
  //     isExist = true;
  //   }
  //   return isExist;
  // }

  static Future<List<WeatherModel>> getWeatherData() async {
    print("getWeatherData-->");
    List<WeatherModel> userdata = [];

    try {
      final db = await getDatabase();
      // String selectQuery =
      //     "SELECT  * FROM ${} WHERE ${DBConstant.WEATHERID}= ?";
      List<Map<String, dynamic>> data =
          await db.rawQuery("SELECT * FROM ${DBConstant.WEATHER_TABLE}");

      if (data.isNotEmpty) {
        data.forEach((element) {
          WeatherModel weatherModel =
              WeatherModel.fromJson(jsonEncode(element));
          print("weatherModel.toMap()-->${weatherModel.toMap()}");
          userdata.add(weatherModel);
        });
      }
    } catch (error) {
      print('DatabaseHelper.addProductInRetrievalTable: $error');
    }

    return userdata;
  }
}
