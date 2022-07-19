import 'package:auth_app/home_screen/response/response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static var client = http.Client();

  static Future<CityData> fetchData({required String city}) async {
    var response = await client.post(Uri.parse(
        "https://api.openweathermap.org/data/2.5/find?q=$city&lang=en&mode=json&appid=a8a37db71ea612cdd8c0e13c23416a7a"));

    if (response.statusCode == 200) {
      CityData res = CityData.fromJson(response.body);
      print("res-->$res");
      debugPrint("res-->$res");
      return res;
    }
    return CityData(count: 0, cod: '', message: '');
  }
}
