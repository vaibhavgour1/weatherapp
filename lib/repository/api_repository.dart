import 'dart:developer';

import 'package:auth_app/home_screen/response/response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static var client = http.Client();

  static Future<CityData> fetchData() async {
    var response = await client.post(Uri.parse(
        "https://api.openweathermap.org/data/2.5/find?q=surat&lang=en&mode=json&appid=a8a37db71ea612cdd8c0e13c23416a7a"));

    if (response.statusCode == 200) {
      CityData res = CityData.fromJson(response.body);
      return res;
    }
    return CityData(count: 0, cod: '', message: '');
  }
}
