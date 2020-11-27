import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

TextStyle myStyle({
  double fontSize,
  fontWeight,
  color,
}) {
  return GoogleFonts.montserrat(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}
