import 'package:dio/dio.dart';
// import 'package:weather_app1/models/forecast.dart';
// import 'package:shared_preferences/shared_preferences.dart';

String apiKey = "099528c91cf62d3bd7f1fa3f61bc6c41";

class WeatherApi {
  static Future getForecast(city) async {

    var url =
        "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey";
  return Dio().get(
      url,
    );
  }
}
