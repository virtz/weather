// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cordinates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cordinate _$CordinateFromJson(Map<String, dynamic> json) {
  return Cordinate(
    lon: (json['lon'] as num)?.toDouble(),
    lat: (json['lat'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CordinateToJson(Cordinate instance) => <String, dynamic>{
      'lon': instance.lon,
      'lat': instance.lat,
    };
