import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app1/services/authService.dart';
import 'package:weather_app1/services/firebaseService.dart';

class UserProvider with ChangeNotifier {
  // User user;
  var errorMessage;
  var message;
  bool loading = false;
  bool isLoggedin = false;

  addUser(name, email, password) async {
    try {
      await AuthService()
          .createUserWithEmailandPassword(email, password, name)
          .then((data) {
        setLoading(true);
        FirebaseService.addUser(name, email);
        setMessage('successful');

        setLoading(false);
        notifyListeners();
      });
    } catch (e) {
      // throw Failure("Couldn't sign up, an error occured");
      setErrorMessage(e.message);
      // print(e);
      setLoading(false);
    }
  }

  getUserName(username) async {
    username = await AuthService().getCurrentName();
    notifyListeners();
    return username;
  }

  signin(email, password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      print('method was called');
      await AuthService()
          .signInWithEmailAndPassword(email, password)
          .then((value) {
        setLoading(true);
        setIsloggedIn(true);
        prefs.setString('email', email);
        prefs.setBool('isLoggedin', isLoggedin);
        print(isLoggedin.toString());
        setMessage('successful');
        setLoading(false);
      });
    } catch (e) {
      setLoading(false);
      setErrorMessage(e.message);
    }
  }

  signout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('isLoggedin');
  }

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

  void setIsloggedIn(value) {
    isLoggedin = value;
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
}
