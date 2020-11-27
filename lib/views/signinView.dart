import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app1/providers/userProvider.dart';
import 'package:weather_app1/widgets/appTextField.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app1/widgets/appButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app1/views/homeView.dart';
import 'package:weather_app1/views/signupView.dart';
import 'package:weather_app1/widgets/emailRegex.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  String username;
  String password;
  String email;
  var error;
  bool autoValidate = false;
  bool obscureText = true;

  RegExp emmailRegExp = new RegExp(emmailRegExpString);

  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;

    ScreenUtil.init(context,
        width: defaultScreenWidth,
        height: defaultScreenHeight,
        allowFontScaling: true);

    return Scaffold(
        backgroundColor: Color(0xFFF9FDFF),
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child:
                Consumer<UserProvider>(builder: (context, userProvider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ScreenUtil().setHeight(60)),
                  Text('Welcome,',
                      style: TextStyle(
                          color: Color(0xFF2A3A64),
                          fontSize: ScreenUtil().setSp(22),
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: ScreenUtil().setHeight(7)),
                  Text(
                    'Sign in to your account ',
                    style: TextStyle(
                      color: Color(0xFF2A3A64),
                      fontSize: ScreenUtil().setSp(15),
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(50)),
                  Form(
                    key: formKey,
                    autovalidate: autoValidate,
                    autovalidateMode: null,
                    child: Column(
                      children: [
                        AppTextField(
                          validator: (value) {
                            if (value.isEmpty) {
                              // bool isEmail = emmailRegExp.hasMatch(value);
                              // return isEmail ? null : "Invalid email format";
                                return 'Please enter your mail';
                              }
                              if (!value.contains('@')) {
                                return 'Incorrect email format';
                              }
                              return null;
                            
                           
                          },
                          style: TextStyle(fontSize: ScreenUtil().setSp(13)),
                          onsaved: (val) => email = val,
                          enabled: !userProvider.isLoading(),
                          hintText: 'Email e.g irene@gmail.com',
                          enableSuggestions: true,
                          obscureText: false,
                          autoValidate: autoValidate,
                          prefix: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Container(
                                child:
                                    SvgPicture.asset('assets/images/mail.svg')),
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(20)),
                        AppTextField(
                          style: TextStyle(fontSize: ScreenUtil().setSp(13)),
                          onsaved: (val) => password = val,
                          enabled: !userProvider.isLoading(),
                          hintText: 'Password',
                          enableSuggestions: true,
                          obscureText: obscureText,
                          autoValidate: autoValidate,
                          validator: (value) {
                            if (value.isEmpty || value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                          suffix: GestureDetector(
                              onTap: _toggle,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  obscureText ? "Show" : "Hide",
                                ),
                              )),
                          prefix: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Container(
                                child:
                                    SvgPicture.asset('assets/images/lock.svg')),
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(55)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: AppButton(
                            child: userProvider.isLoading()
                                // _isButtonDisabled == true
                                ? CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                    strokeWidth: 2)
                                : Text('Sign in',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(14))),
                            onPressed: () => _submit(),
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(20)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SignUp()));
                          },
                          child: RichText(
                              text: TextSpan(
                                  text: "Don't have an account ?",
                                  style: TextStyle(color: Color(0xFF687593)),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: 'Sign up',
                                    style: TextStyle(fontSize: 15))
                              ])),
                        )
                      ],
                    ),
                  )
                ],
              );
            })));
  }

  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  _submit() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      userProvider.setLoading(true);
      await userProvider.signin(email, password);
      if (userProvider.message != null &&
          userProvider.message == 'successful') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => HomeView()));
      } else {
        _showCupertinoDialog(context);
      }
    } else {
      print('autovalidate triggered');
      setState(() {
        autoValidate = true;
      });
    }
  }

  _showCupertinoDialog(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => CupertinoAlertDialog(
              title: new Text(
                "Error",
                style: TextStyle(color: Colors.red),
              ),
              content: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(userProvider.errorMessage == null
                    ? "An error occured"
                    : userProvider.errorMessage),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}
