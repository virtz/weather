import 'package:json_annotation/json_annotation.dart';

part 'mainT.g.dart';

@JsonSerializable()
class Main {
  double temp;
  double feelslike;
  double tempmin;
  double tempmax;
  double pressure;
  double humidity;


  Main(
      {this.temp,
      this.feelslike,
      this.tempmin,
      this.tempmax,
      this.pressure,
      this.humidity,
   
      });

      factory Main.fromJson(Map<String, dynamic> json) =>
      _$MainFromJson(json);
  Map<String, dynamic> toJson() =>_$MainToJson(this);  
}
