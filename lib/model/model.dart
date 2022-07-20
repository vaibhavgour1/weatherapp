// To parse this JSON data, do
//
//     final weathar = weatharFromMap(jsonString);

import 'dart:convert';

class WeatherModel {
  WeatherModel({
    this.id,
    this.dt,
    this.speed,
    this.lightRain,
    this.pressure,
    this.humidity,
    this.temp,
    this.name,
  });

  int? id;
  String? dt;
  String? speed;
  String? lightRain;
  String? pressure;
  String? humidity;
  String? temp;
  String? name;

  factory WeatherModel.fromJson(String str) =>
      WeatherModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromMap(Map<String, dynamic> json) => WeatherModel(
        id: json["id"] == null ? null : json["id"],
        dt: json["dt"] == null ? null : json["dt"],
        speed: json["speed"] == null ? null : json["speed"],
        lightRain: json["rain"] == null ? null : json["rain"],
        pressure: json["pressure"] == null ? null : json["pressure"],
        humidity: json["humidity"] == null ? null : json["humidity"],
        temp: json["temp"] == null ? null : json["temp"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "dt": dt == null ? null : dt,
        "speed": speed == null ? null : speed,
        "rain": lightRain == null ? null : lightRain,
        "pressure": pressure == null ? null : pressure,
        "humidity": humidity == null ? null : humidity,
        "temp": temp == null ? null : temp,
        "name": name == null ? null : name,
      };
}
