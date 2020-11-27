import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app1/views/homeView.dart';
import 'package:weather_app1/views/signinView.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: GestureDetector(
          onTap: ()=>next(context),
                  child: Container(
            child:SvgPicture.asset('assets/images/splash.svg',)
          ),
        ),
      )
    );
  }
    next(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedin');
    print(prefs.getBool('isLoggedin'));

    if (isLoggedIn == true) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => HomeView()));
    } else if (isLoggedIn == false) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => SignIn()));
    } else if (isLoggedIn == null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => SignIn()));
    }else{
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => SignIn()));
    }
  }
}
