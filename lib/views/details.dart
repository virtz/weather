import 'package:flutter/material.dart';

import 'package:weather_app1/widgets/myStyle.dart';
// import 'package:weather_app1/widgets/weatherIcon.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app1/widgets/detailsTextWidget.dart';

class Details extends StatelessWidget {
  final double lon;
  final double lat;
  final double temp;
  final double feelslike;
  final double tempmin;
  final double tempmax;
  final double pressure;
  final double humidity;
  final double seaLevel;
  final double groundLevel;
  final double speed;
  final double deg;
  final int id;
  final String main;
  final String description;
  final String icn;
  final String city;

  const Details(
      {Key key,
      this.lon,
      this.lat,
      this.temp,
      this.feelslike,
      this.tempmin,
      this.tempmax,
      this.pressure,
      this.humidity,
      this.seaLevel,
      this.groundLevel,
      this.speed,
      this.deg,
      this.id,
      this.main,
      this.description,
      this.icn,
      this.city})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.blue[50],
              Colors.blue[100],
              Colors.blue[200],
              Colors.blue[300],
              Colors.blue[400]
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          )),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Text(city,
                        style: myStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Text(icn,
                        //     style: myStyle(fontSize: 50, color: Colors.white)),
                        SvgPicture.asset(
                          (main == "Rain")
                              ? 'assets/images/cloud-rain.svg'
                              : (main == "Drizzle")
                                  ? 'assets/images/cloud-drizzle.svg'
                                  : (main == "Clouds")
                                      ? 'assets/images/cloud.svg'
                                      : (main == "Snow")
                                          ? 'assets/images/cloud-snow.svg'
                                          : (main == "ThunderStorm")
                                              ? 'assets/images/cloud-lightning.svg'
                                              : 'assets/images/cloud.svg',
                          height: 100,
                        ),
                        // WeatherIcon(
                        //   forecast: main,
                        // ),
                        Column(
                          children: [
                            Text(
                              main,
                              style:
                                  myStyle(fontSize: 17.0, color: Colors.white),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(description,
                                style: myStyle(
                                    fontSize: 14.0, color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      "$temp K",
                      style: myStyle(fontSize: 40.0, color: Colors.white),
                    ),
                    Spacer(),
                    DetailsTextWidget(
                      firstText: "Longitude: ",
                      secondText: "Latitude: ",
                      size: 13.0,
                      dynamicText: lon.toString(),
                      dynamicText1: lat.toString(),
                    ),
                    Spacer(),
                         DetailsTextWidget(
                      firstText: "Humidity: ",
                      secondText: "Pressure: ",
                      size: 13.0,
                      dynamicText: humidity.toString(),
                      dynamicText1: pressure.toString(),
                    ),
                    Spacer(),
                        DetailsTextWidget(
                      firstText: "Temp_Min: ",
                      secondText: "Temp_Max: ",
                      size: 13.0,
                      dynamicText: tempmin.toString(),
                      dynamicText1: tempmax.toString(),
                    ),
                    Spacer(),
                        DetailsTextWidget(
                      firstText: "Wind Speed: ",
                      secondText: "Degree: ",
                      size: 13.0,
                      dynamicText: speed.toString(),
                      dynamicText1: deg.toString(),
                    ),
                    Spacer(),
                  ],
                ),
              ))),
    );
  }
}
