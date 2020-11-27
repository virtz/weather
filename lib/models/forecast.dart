import 'package:weather_app1/models/cordinates.dart';
import 'package:weather_app1/models/weather.dart';
import 'package:weather_app1/models/mainT.dart';
import 'package:weather_app1/models/wind.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forecast.g.dart';

@JsonSerializable(explicitToJson: true)
class Forecast {
  Cordinate coord;
  List<Weather> weather;
  Main main;
  Wind wind;

  Forecast({
    this.coord,
    this.weather,
    this.main,
    this.wind
  });
  factory Forecast.fromJson(Map<String, dynamic> json) =>
      _$ForecastFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastToJson(this);

}
