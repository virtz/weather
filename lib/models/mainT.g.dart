// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mainT.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Main _$MainFromJson(Map<String, dynamic> json) {
  return Main(
    temp: (json['temp'] as num)?.toDouble(),
    feelslike: (json['feels_like'] as num)?.toDouble(),
    tempmin: (json['temp_min'] as num)?.toDouble(),
    tempmax: (json['temp_max'] as num)?.toDouble(),
    pressure: (json['pressure'] as num)?.toDouble(),
    humidity: (json['humidity'] as num)?.toDouble(),
   
  );
}

Map<String, dynamic> _$MainToJson(Main instance) => <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feelslike,
      'temp_min': instance.tempmin,
      'temp_max': instance.tempmax,
      'pressure': instance.pressure,
      'humidity': instance.humidity,

    };
