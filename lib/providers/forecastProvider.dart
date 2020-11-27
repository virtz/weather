import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather_app1/api/weatherApi.dart';
import 'package:weather_app1/models/forecast.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ForeCastProvider with ChangeNotifier {
  var message;
  var errorMessage;
  bool loading = false;
  var forcast;
  var forecaatList = [];
  String savedCity;

  bool isLoading() {
    return loading;
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  void setMessage(value) {
    message = value;
    notifyListeners();
  }

  String getMessage() {
    return message;
  }

  void setErrorMessage(value) {
    errorMessage = value;
    notifyListeners();
  }

  String getErrorMessage() {
    return errorMessage;
  }

  Future getForecast(city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      await WeatherApi.getForecast(city).then((response) {
        if (response != null) {
          // setLoading(false);
          prefs.setString('savedCity', city);
          savedCity = prefs.getString('savedCity');

          setMessage('Data was fetched succesfully');
        }

        Map<dynamic, dynamic> map = response.data;
        forcast = Forecast.fromJson(map);

        var storedData = json.encode(map);
        prefs.setString('storedData', storedData);
        print('$storedData this is it');
        return forcast;
      });
    } on DioError catch (e) {
      setLoading(false);
      setErrorMessage(e.response.toString());
    }
  }

  Future getSavedForcast() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String dataInString = prefs.getString("storedData");
      savedCity = prefs.getString('savedCity');
      Map<dynamic, dynamic> map1 = json.decode(dataInString);
      print(map1);
      forcast = Forecast.fromJson(map1);
    } catch (e) {
      setErrorMessage(e.message);
    }
  }
}
