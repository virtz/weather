import 'package:dio/dio.dart';
// import 'package:weather_app1/models/forecast.dart';
// import 'package:shared_preferences/shared_preferences.dart';

String apiKey = "xxxxxxxxxxxxxxxxx";

class WeatherApi {
  static Future getForecast(city) async {

    var url =
        "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey";
  return Dio().get(
      url,
    );
  }
}
