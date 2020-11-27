import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app1/providers/userProvider.dart';
import 'package:weather_app1/widgets/appTextField.dart';
import 'package:weather_app1/widgets/appButton.dart';
import 'package:weather_app1/views/signinView.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  String username;
  String password;
  String email;
  var error;
  bool autoValidate = false;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    // final userProvider = Provider.of<UserProvider>(context, listen: false);

    // ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
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
                    'Create your account ',
                    style: TextStyle(
                      color: Color(0xFF2A3A64),
                      fontSize: ScreenUtil().setSp(15),
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(50)),
                  Form(
                    autovalidate: autoValidate,
                    autovalidateMode: null,
                    key: formKey,
                    child: Column(
                      children: [
                        AppTextField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                          style: TextStyle(fontSize: ScreenUtil().setSp(13)),
                          onsaved: (val) => username = val,
                          enabled: !userProvider.isLoading(),
                          hintText: 'Username',
                          enableSuggestions: true,
                          obscureText: false,
                          autoValidate: autoValidate,
                          keyboardType: TextInputType.text,
                          prefix: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Container(
                                child:
                                    SvgPicture.asset('assets/images/user.svg')),
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(20)),
                        AppTextField(
                          validator: (value) {
                            if (value.isEmpty) {
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
                      backgroundColor: Colors.white, strokeWidth: 2)
                  : Text('Signup',
                      style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(14))),
                            onPressed: ()=>_submit(),
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(20)),
                          GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SignIn()));
                          },
                          child: RichText(
                              text: TextSpan(
                                  text: "Already have an account ?",
                                  style: TextStyle(color: Color(0xFF687593)),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: 'Login',
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
      await userProvider.addUser(username, email, password);
      if (userProvider.message != null &&
          userProvider.message == 'successful') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => SignIn()));
      } else {
        _showCupertinoDialog(context);
      }
    } else {
      print('form autovalidate');
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
        builder: (_) => new CupertinoAlertDialog(
              title: new Text(
                "Error",
                style: TextStyle(color: Colors.red),
              ),
              content: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(userProvider.errorMessage),
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


