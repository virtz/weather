import 'package:flutter/material.dart';
import 'package:weather_app1/widgets/myStyle.dart';
class DetailsTextWidget extends StatelessWidget {
  const DetailsTextWidget({
    Key key,
    @required this.firstText,
    @required this.secondText,
    this.color,
    this.size, this.dynamicText, this.dynamicText1,
  }) : super(key: key);

  final String firstText;
  final String secondText;
  final String dynamicText;
  final String dynamicText1;
  final color;
  final size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RichText(
            text: TextSpan(
                text: firstText,
                style: myStyle(fontSize: size, color: Colors.white),
                children: <TextSpan>[
              TextSpan(text: dynamicText),
            ])),
        RichText(
            text: TextSpan(
                text: secondText,
                style: myStyle(fontSize: size, color: Colors.white),
                children: <TextSpan>[TextSpan(text: dynamicText1)])),
      ],
    );
  }
}
