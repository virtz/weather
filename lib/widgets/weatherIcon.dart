import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({
    Key key,
    @required this.forecast,
    this.url,
  }) : super(key: key);

  final forecast;
  final  url;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      (forecast.weather[0].main == 'Rain')
          ? 'assets/images/cloud-rain.svg'
          : (forecast.weather[0].main == 'Drizzle')
              ? 'assets/images/cloud-drizzle.svg'
              : (forecast.weather[0].main == "Clouds")
                  ? 'assets/images/cloud.svg'
                  : (forecast.weather[0].main == "Snow")
                      ? 'assets/images/cloud-snow.svg'
                      : (forecast.weather[0].main == "ThunderStorm")
                          ? 'assets/images/cloud-lightning.svg'
                          : 'assets/images/cloud.svg',
      height: 100,
    );
  }
}