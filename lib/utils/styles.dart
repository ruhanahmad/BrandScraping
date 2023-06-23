import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyle({
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
}) {
  return GoogleFonts.dmSans(
      fontSize: fontSize, color: color, fontWeight: fontWeight);
}
