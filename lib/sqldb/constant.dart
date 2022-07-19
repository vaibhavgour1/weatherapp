class DBConstant {
  static const DATA_BASE_NAME = "my_test_db";
  static const WEATHER_TABLE = "weather_table";
  static const WEATHERID = "id";
  static const DATETIME = "dt";
  static const WIND = "speed";
  static const LIGHTRAIN = "rain";
  static const PRESSURE = "pressure";
  static const HUMIDITY = "humidity";
  static const TEMP = "temp";
  static const NAME = "name";

  static const String CREATE_WEATHER_TABLE = "CREATE TABLE " +
      WEATHER_TABLE +
      "(" +
      WEATHERID +
      " INTEGER PRIMARY KEY AUTOINCREMENT , " +
      DATETIME +
      " TEXT," +
      WIND +
      " TEXT," +
      LIGHTRAIN +
      " TEXT," +
      PRESSURE +
      " TEXT," +
      HUMIDITY +
      " TEXT," +
      TEMP +
      " TEXT," +
      NAME +
      " TEXT )";
}
