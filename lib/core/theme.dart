import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color gClr = Color(0xff0f4751);
const Color errorClr = Color(0xfff85245);
final Color gClrwithAlpha = gClr.withAlpha(48);
const Color wClr = Color(0xffffffff);

var fontStyle = GoogleFonts.poppins;
final TextStyle g18 = fontStyle(
  color: gClr,
  fontSize: 18,
  fontWeight: FontWeight.w700,
);
final TextStyle g16 = fontStyle(
  color: gClr,
  fontSize: 16,
  fontWeight: FontWeight.w700,
);
final TextStyle w18 = fontStyle(
  color: wClr,
  fontSize: 18,
  fontWeight: FontWeight.w700,
);
final TextStyle w16 = fontStyle(
  color: wClr,
  fontSize: 16,
  fontWeight: FontWeight.w700,
);
final TextStyle w16l = fontStyle(
  color: wClr,
  fontSize: 16,
  fontWeight: FontWeight.w500,
);
final TextStyle w14l = fontStyle(
  color: wClr,
  fontSize: 14,
  fontWeight: FontWeight.w300,
);