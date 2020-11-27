import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:weather_app1/widgets/appTextField.dart';
import 'package:weather_app1/views/signinView.dart';
import 'package:weather_app1/widgets/appButton.dart';
import 'package:weather_app1/widgets/weatherIcon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app1/models/forecast.dart';

import 'package:weather_app1/providers/forecastProvider.dart';
import 'package:weather_app1/providers/userProvider.dart';
import 'package:weather_app1/widgets/myStyle.dart';
import 'package:weather_app1/views/details.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  TextEditingController _controller = TextEditingController();
  bool showResult = false;
  String savedCity;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }
    print(_connectionStatus);
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final forecastProvider = Provider.of<ForeCastProvider>(context);
    // final userProvider = Provider.of<UserProvider>(context);

    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.init(context,
        width: defaultScreenWidth,
        height: defaultScreenHeight,
        allowFontScaling: true);
    var size = MediaQuery.of(context).size;

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
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                AppTextField(
                    onChanged: (val) {
                      forecastProvider.setErrorMessage(null);
                    },
                    obscureText: false,
                    enableSuggestions: false,
                    controller: _controller,
                    errorText: forecastProvider.getErrorMessage()),
                FlatButton(
                  onPressed: () {
                    // saveCity();
                    getForecast();
                  },
                  child: Text('Get Forecast'),
                ),
                SizedBox(height: 20),
                showResult
                    ? Consumer<ForeCastProvider>(
                        builder: (context, forecastProvider, child) {
                        return FutureBuilder(
                            future: getForecast(),
                            // _controller.text.isEmpty
                            //     ? forecastProvider.getForecast(savedCity)
                            //     : forecastProvider
                            // .getForecast(_controller.text),
                            builder: (context, snapshot) {
                              Forecast forecast = forecastProvider.forcast;
                              return forecastProvider.forcast == null
                                  ? Container()
                                  : GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    Details(
                                                        lon: forecast.coord.lon,
                                                        lat: forecast.coord.lat,
                                                        temp:
                                                            forecast.main.temp,
                                                        feelslike: forecast
                                                            .main.feelslike,
                                                        tempmin:
                                                            forecast.main.temp,
                                                        tempmax: forecast
                                                            .main.tempmax,
                                                        pressure: forecast
                                                            .main.pressure,
                                                        humidity: forecast
                                                            .main.humidity,
                                                        speed:
                                                            forecast.wind.speed,
                                                        deg: forecast.wind.deg,
                                                        id: forecast
                                                            .weather[0].id,
                                                        main: forecast
                                                            .weather[0].main,
                                                        description: forecast
                                                            .weather[0]
                                                            .description,
                                                        icn: forecast
                                                            .weather[0].icn,
                                                        city: (_controller
                                                                    .text ==
                                                                null)
                                                            ? forecastProvider.savedCity
                                                            : (_connectionStatus ==
                                                                    'ConnectivityResult.none')
                                                                ? forecastProvider.savedCity
                                                                : _controller
                                                                    .text)));
                                      },
                                      child: Card(
                                        child: Container(
                                            constraints: BoxConstraints(
                                              minHeight: size.height * 0.05,
                                              maxHeight: size.height * 0.5,
                                            ),
                                            width: size.width,
                                            height: size.height * 0.25,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 10,
                                              ),
                                              child: Column(
                                                children: [
                                                  Text('Today',
                                                      style: myStyle(
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black)),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      WeatherIcon(
                                                          forecast: forecast),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              forecast
                                                                  .weather[0]
                                                                  .main,
                                                              style: myStyle(
                                                                fontSize: 15.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              )),
                                                          Text(
                                                              forecast
                                                                  .weather[0]
                                                                  .description,
                                                              style: myStyle(
                                                                  color: Colors
                                                                      .black54))
                                                        ],
                                                      ),
                                                      Text(forecast
                                                          .weather[0].icn)
                                                    ],
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: RichText(
                                                        text: TextSpan(
                                                            text: "Temp: ",
                                                            style: myStyle(
                                                                fontSize: 14.0,
                                                                color: Colors
                                                                    .black54),
                                                            children: <
                                                                TextSpan>[
                                                          TextSpan(
                                                              text:
                                                                  "${forecast.main.temp} K")
                                                        ])),
                                                  ),
                                                  Spacer(),
                                                  // Text(forecast.coord.lat.toString(),style:myStyle(fontSize: 12.0))
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      RichText(
                                                          text: TextSpan(
                                                              text:
                                                                  "Latitude: ",
                                                              style: myStyle(
                                                                  fontSize:
                                                                      12.0,
                                                                  color: Colors
                                                                      .black54),
                                                              children: <
                                                                  TextSpan>[
                                                            TextSpan(
                                                                text: forecast
                                                                    .coord.lat
                                                                    .toString())
                                                          ])),
                                                      RichText(
                                                          text: TextSpan(
                                                              text:
                                                                  "Longitude: ",
                                                              style: myStyle(
                                                                  fontSize:
                                                                      12.0,
                                                                  color: Colors
                                                                      .black54),
                                                              children: <
                                                                  TextSpan>[
                                                            TextSpan(
                                                                text: forecast
                                                                    .coord.lon
                                                                    .toString())
                                                          ])),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )),
                                      ),
                                    );
                            });
                      })
                    : Container(),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                AppButton(child: Text('Sign Out'), onPressed: () => signout()),
          ),
        ),
      ),
    );
  }

  signout() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.signout();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => SignIn()));
  }

  getSavedCity() async {
    final forecastProvider =
        Provider.of<ForeCastProvider>(context, listen: false);
    savedCity = forecastProvider.savedCity;
    // print(savedCity);
  }

  Future getForecast() async {
    setState(() {
      showResult = true;
    });

    final forecastProvider =
        Provider.of<ForeCastProvider>(context, listen: false);
    print(forecastProvider.errorMessage);
    // _controller.text.isEmpty
    //     ? await forecastProvider.getForecast(savedCity)
    //     : await forecastProvider.getForecast(_controller.text);
    if (_connectionStatus == "ConnectivityResult.none") {
      await forecastProvider.getSavedForcast();
    } else {
      await forecastProvider.getForecast(_controller.text);
    }
    print(_controller.text);
    if (forecastProvider.errorMessage == null) {
      print(forecastProvider.errorMessage);
    }
    forecastProvider.setLoading(false);
  }

  goToDetails() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => Details()));
  }
}
