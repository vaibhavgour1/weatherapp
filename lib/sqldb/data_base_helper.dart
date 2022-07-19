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
      await db.execute(DBConstant.CREATE_WEATHER_TABLE);
    });
  }

  static Future<int> addWeatherData(WeatherModel weatherModel) async {
    print("addWeatherData--");
    int id = 0;
    try {
      final db = await getDatabase();

      // bool exist = await checkGiftExist(giftDataModel.id.toString());

      // if (exist) {
      //   List<Map<String, dynamic>> data = await db.query(DBConstant.CART_TABLE,
      //       columns: [DBConstant.QUANTITY],
      //       where: DBConstant.GIFT_ID + "= ? AND " + DBConstant.USER_ID + "= ?",
      //       whereArgs: [
      //         giftDataModel.id.toString(),
      //         await Utility.getStringPreference(Constant.USER_ID)
      //       ]);
      //
      //   int q = data.first["quantity"] as int;
      //
      //   giftDataModel.quantity = giftDataModel.quantity! + q;
      //
      //   id = await db.update(DBConstant.CART_TABLE, giftDataModel.toMap(),
      //       whereArgs: [
      //         giftDataModel.id.toString(),
      //         await Utility.getStringPreference(Constant.USER_ID)
      //       ],
      //       where:
      //           DBConstant.GIFT_ID + "= ? AND " + DBConstant.USER_ID + "= ?");
      // } else {
      id = await db.insert(
          DBConstant.CREATE_WEATHER_TABLE, weatherModel.toMap());
      // }

      /**
       * close database
       */
      // db.close();
    } catch (error) {
      print('DatabaseHelper.addProductInRetrievalTable: $error');
    }

    return id;
  }

  static Future<List<WeatherModel>> getWeatherData() async {
    List<WeatherModel> userdata = [];

    try {
      final db = await getDatabase();
      String selectQuery =
          "SELECT  * FROM ${DBConstant.CREATE_WEATHER_TABLE} WHERE ${DBConstant.WEATHERID}= ?";
      List<Map<String, dynamic>> data =
          await db.rawQuery(selectQuery, [DBConstant.WEATHERID]);

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
