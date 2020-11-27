import 'package:json_annotation/json_annotation.dart';

part 'cordinates.g.dart';

@JsonSerializable()
class Cordinate {
  double lon;
  double lat;

  Cordinate({
    this.lon,
    this.lat,
  });

  factory Cordinate.fromJson(Map<String, dynamic> json) =>
      _$CordinateFromJson(json);
  Map<String, dynamic> toJson() => _$CordinateToJson(this);
}
