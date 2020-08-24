import 'package:flutterlogin/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppPadding {
  static const EdgeInsets normalPadding = EdgeInsets.all(16);
}

final ThemeData themeData = ThemeData(
  primaryColor: AppColor.primaryColor,
  primaryColorBrightness: Brightness.light,
  primaryColorDark: AppColor.primaryDarkColor,
  accentColor: AppColor.accentColor,
  accentColorBrightness: Brightness.dark,
  primaryColorLight: AppColor.primaryColorLight,
  backgroundColor: AppColor.primaryColor,
  iconTheme: iconThemeData,
  appBarTheme: appBarTheme,
  buttonTheme: buttonThemeData,
  buttonColor: AppColor.primaryDarkColor,
  disabledColor: AppColor.disableColor,
  scaffoldBackgroundColor: AppColor.primaryColor,
  dialogTheme: dialogTheme,
);

final DialogTheme dialogTheme = DialogTheme(
  backgroundColor: AppColor.primaryColor,
  titleTextStyle: textTheme.headline6,
  contentTextStyle: textTheme.bodyText1,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
);
const ButtonThemeData buttonThemeData = ButtonThemeData(
  disabledColor: AppColor.disableColor,
  buttonColor: AppColor.primaryDarkColor,
  textTheme: ButtonTextTheme.primary,
);

final AppBarTheme appBarTheme = AppBarTheme(
  iconTheme: iconThemeData.copyWith(color: AppColor.white),
  color: AppColor.primaryColor,
  brightness: Brightness.light,
  actionsIconTheme: iconThemeData.copyWith(color: AppColor.white),
  textTheme: textTheme.copyWith(headline6: textTheme.headline6.copyWith(color: AppColor.white)),
);

const IconThemeData iconThemeData = IconThemeData(
  color: AppColor.black,
);

final TextTheme textTheme = TextTheme(
  headline1: GoogleFonts.cabin(
    fontSize: 96,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
    color: AppColor.black,
  ),
  headline2: GoogleFonts.cabin(
    fontSize: 60,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
    color: AppColor.black,
  ),
  headline3: GoogleFonts.cabin(
    fontSize: 48,
    fontWeight: FontWeight.w400,
    color: AppColor.black,
  ),
  headline4: GoogleFonts.cabin(
    fontSize: 34,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: AppColor.black,
  ),
  headline5: GoogleFonts.cabin(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: AppColor.black,
  ),
  headline6: GoogleFonts.cabin(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: AppColor.black,
  ),
  subtitle1: GoogleFonts.cabin(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    color: AppColor.black,
  ),
  subtitle2: GoogleFonts.cabin(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: AppColor.black,
  ),
  bodyText1: GoogleFonts.cabin(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: AppColor.black,
  ),
  bodyText2: GoogleFonts.cabin(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: AppColor.black,
  ),
  button: GoogleFonts.cabin(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
    color: AppColor.black,
  ),
  caption: GoogleFonts.cabin(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: AppColor.black,
  ),
  overline: GoogleFonts.cabin(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
    color: AppColor.black,
  ),
);
