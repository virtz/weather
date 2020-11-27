import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key key,
    this.initialValue,
    this.labelText,
    this.hintText,
    this.onsaved,
    this.enabled,
    this.validator,
    this.style,
    this.obscureText,
    this.autoValidate,
    this.enableSuggestions,
    this.keyboardType,
    this.inputFormatters,
    this.suffix,
    this.prefix,
    this.textfieldBorder,
    this.controller,
    this.errorText, this.onChanged,
  }) : super(key: key);

  final String initialValue;
  final String labelText;
  final String hintText;
  final void Function(String) onsaved;
  final bool enabled;
  final String Function(String) validator;
  final TextStyle style;
  final bool obscureText;
  final bool autoValidate;
  final bool enableSuggestions;
  final TextInputType keyboardType;
  final List inputFormatters;
  final TextEditingController controller;
  final Widget suffix;
  final Widget prefix;
  final double textfieldBorder;
  final String errorText;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;

    ScreenUtil.init(context,
        width: defaultScreenWidth,
        height: defaultScreenHeight,
        allowFontScaling: true);

    return TextFormField(
      style: TextStyle(fontSize: ScreenUtil().setSp(13)),
      autocorrect: true,
      onSaved: onsaved,
      validator: validator,
      keyboardType: TextInputType.text,
      enabled: enabled,
      obscureText: obscureText,
      decoration: InputDecoration(
        errorText: errorText,
        fillColor: Color(0xFFFFFFFFF),
        //  errorText: userProvider.getMessage(),
        filled: true,
        // errorText: email == null?'value cannot be empty':email,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: ScreenUtil().setSp(11)),
        // border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Color(0xFFD8D8DF), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Color(0xFFD8D8DF), width: 1),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: Color(0xFFD8D8DF), width: 1)),
        prefixIcon: prefix,
        prefixIconConstraints: BoxConstraints(maxHeight: 20.0),
        suffix: suffix,
        suffixIconConstraints: BoxConstraints(maxHeight: 20.0),

        // prefixIcon: Icon(Icons.person),
      ),
      controller: controller,
      onChanged: onChanged,
    );
  }
}
