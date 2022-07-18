import 'dart:convert';

class CityData {
  CityData({
    required this.message,
    required this.cod,
    required this.count,
    this.list,
  });

  String message;
  String cod;
  int count;
  List<ListElement>? list;

  factory CityData.fromJson(String str) => CityData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CityData.fromMap(Map<String, dynamic> json) => CityData(
        message: json["message"] == null ? "" : json["message"],
        cod: json["cod"] == null ? "" : json["cod"],
        count: json["count"] == null ? 0 : json["count"],
        list: json["list"] == null
            ? []
            : List<ListElement>.from(json["list"].map((x) => ListElement.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message == null ? null : message,
        "cod": cod == null ? null : cod,
        "count": count == null ? null : count,
        "list": list == null ? null : List<dynamic>.from(list!.map((x) => x.toMap())),
      };
}

class ListElement {
  ListElement({
    required this.id,
    required this.name,
    this.coord,
    this.main,
    required this.dt,
    this.wind,
    this.sys,
    required this.rain,
    required this.snow,
    this.clouds,
    this.weather,
  });

  String id;
  String name;
  Coord? coord;
  Main? main;
  int dt;
  Wind? wind;
  Sys? sys;
  dynamic rain;
  dynamic snow;
  Clouds? clouds;
  List<Weather>? weather;

  factory ListElement.fromJson(String str) => ListElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListElement.fromMap(Map<String, dynamic> json) => ListElement(
        id: json["id"] == null ? "" : json["id"].toString(),
        name: json["name"] == null ? "" : json["name"].toString(),
        coord: json["coord"] == null ? null : Coord.fromMap(json["coord"]),
        main: json["main"] == null ? null : Main.fromMap(json["main"]),
        dt: json["dt"] == null ? null : json["dt"],
        wind: json["wind"] == null ? null : Wind.fromMap(json["wind"]),
        sys: json["sys"] == null ? null : Sys.fromMap(json["sys"]),
        rain: json["rain"],
        snow: json["snow"],
        clouds: json["clouds"] == null ? null : Clouds.fromMap(json["clouds"]),
        weather: json["weather"] == null
            ? null
            : List<Weather>.from(json["weather"].map((x) => Weather.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "coord": coord == null ? null : coord!.toMap(),
        "main": main == null ? null : main!.toMap(),
        "dt": dt == null ? null : dt,
        "wind": wind == null ? null : wind!.toMap(),
        "sys": sys == null ? null : sys!.toMap(),
        "rain": rain,
        "snow": snow,
        "clouds": clouds == null ? null : clouds!.toMap(),
        "weather": weather == null ? null : List<dynamic>.from(weather!.map((x) => x.toMap())),
      };
}

class Clouds {
  Clouds({
    required this.all,
  });

  String all;

  factory Clouds.fromJson(String str) => Clouds.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Clouds.fromMap(Map<String, dynamic> json) => Clouds(
        all: json["all"] == null ? "" : json["all"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "all": all == null ? null : all,
      };
}

class Coord {
  Coord({
    required this.lat,
    required this.lon,
  });

  String lat;
  String lon;

  factory Coord.fromJson(String str) => Coord.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Coord.fromMap(Map<String, dynamic> json) => Coord(
        lat: json["lat"] == null ? "0" : json["lat"].toString(),
        lon: json["lon"] == null ? "0" : json["lon"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "lat": lat == null ? null : lat,
        "lon": lon == null ? null : lon,
      };
}

class Main {
  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
  });

  String temp;
  String feelsLike;
  String tempMin;
  String tempMax;
  String pressure;
  String humidity;
  String seaLevel;
  String grndLevel;

  factory Main.fromJson(String str) => Main.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Main.fromMap(Map<String, dynamic> json) => Main(
        temp: json["temp"] == null ? "" : json["temp"].toString(),
        feelsLike: json["feels_like"] == null ? "" : json["feels_like"].toString(),
        tempMin: json["temp_min"] == null ? "" : json["temp_min"].toString(),
        tempMax: json["temp_max"] == null ? "" : json["temp_max"].toString(),
        pressure: json["pressure"] == null ? "" : json["pressure"].toString(),
        humidity: json["humidity"] == null ? "" : json["humidity"].toString(),
        seaLevel: json["sea_level"] == null ? "" : json["sea_level"].toString(),
        grndLevel: json["grnd_level"] == null ? "" : json["grnd_level"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "temp": temp == null ? null : temp,
        "feels_like": feelsLike == null ? null : feelsLike,
        "temp_min": tempMin == null ? null : tempMin,
        "temp_max": tempMax == null ? null : tempMax,
        "pressure": pressure == null ? null : pressure,
        "humidity": humidity == null ? null : humidity,
        "sea_level": seaLevel == null ? null : seaLevel,
        "grnd_level": grndLevel == null ? null : grndLevel,
      };
}

class Sys {
  Sys({
    required this.country,
  });

  String country;

  factory Sys.fromJson(String str) => Sys.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Sys.fromMap(Map<String, dynamic> json) => Sys(
        country: json["country"] == null ? "" : json["country"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "country": country == null ? null : country,
      };
}

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  String id;
  String main;
  String description;
  String icon;

  factory Weather.fromJson(String str) => Weather.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Weather.fromMap(Map<String, dynamic> json) => Weather(
        id: json["id"] == null ? "0" : json["id"].toString(),
        main: json["main"] == null ? "" : json["main"].toString(),
        description: json["description"] == null ? "" : json["description"].toString(),
        icon: json["icon"] == null ? "" : json["icon"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "main": main == null ? null : main,
        "description": description == null ? null : description,
        "icon": icon == null ? null : icon,
      };
}

class Wind {
  Wind({
    required this.speed,
    required this.deg,
  });

  String speed;
  String deg;

  factory Wind.fromJson(String str) => Wind.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Wind.fromMap(Map<String, dynamic> json) => Wind(
        speed: json["speed"] == null ? "" : json["speed"].toString(),
        deg: json["deg"] == null ? "" : json["deg"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "speed": speed == null ? null : speed,
        "deg": deg == null ? null : deg,
      };
}
