import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// colors
const Color kRichBlack = Color(0xFF1E1E29);
const Color kSpaceGrey = Color(0xFF26262F);
const Color kOxfordBlue = Color(0xFF001D3D);
const Color kMikadoYellow = Color(0xFFffc300);

// text style
final TextStyle kHeading5 =
    GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400);
final TextStyle kHeading6 = GoogleFonts.poppins(
    fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15);
final TextStyle kSubtitle = GoogleFonts.poppins(
    fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15);
final TextStyle kBodyText = GoogleFonts.poppins(
    fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25);

// text theme
final kTextTheme = TextTheme(
  headline5: kHeading5,
  headline6: kHeading6,
  subtitle1: kSubtitle,
  bodyText2: kBodyText,
);

const kColorScheme = ColorScheme(
  primary: kMikadoYellow,
  primaryVariant: kMikadoYellow,
  secondary: kSpaceGrey,
  secondaryVariant: kSpaceGrey,
  surface: kRichBlack,
  background: kRichBlack,
  error: Colors.redAccent,
  onPrimary: kRichBlack,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  onBackground: Colors.white,
  onError: Colors.white,
  brightness: Brightness.dark,
);
