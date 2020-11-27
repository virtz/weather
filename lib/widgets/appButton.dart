import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key key,
    this.text,
    this.child,
    this.onPressed,
  }) : super(key: key);
  final String text;
  final Widget child;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 10.w),
    // child:
   return MaterialButton(
     minWidth: MediaQuery.of(context).size.width,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        height: ScreenUtil().setHeight(50),
        onPressed: onPressed,
        color: Color(0xFF257ED9),
        child: child);
    // );
  }
}
