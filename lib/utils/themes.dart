import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hermoso_store/utils/colors.dart';

ThemeData lightThemeMode() {
  return ThemeData(
    primarySwatch: Colors.cyan,
    scaffoldBackgroundColor: kBackColor,
    textTheme: GoogleFonts.aBeeZeeTextTheme(TextTheme(
      headline6: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      subtitle1: const TextStyle(fontSize: 18, color: Colors.black),
      headline5: const TextStyle(fontSize: 24, color: Colors.white70),
      headline4: GoogleFonts.lato(
          color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
      button: const TextStyle(
          color: kCoWhiteColor, fontSize: 22, fontWeight: FontWeight.w600),
      bodyText1: const TextStyle(
          fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
      bodyText2: const TextStyle(fontSize: 14, color: Colors.black),
      caption: const TextStyle(fontSize: 18, color: kGreyColor),
      subtitle2: const TextStyle(fontSize: 16, color: kGreyColor),
    )),
    colorScheme: const ColorScheme.light(
      primary: kPrimary,
      secondaryContainer: kSecondaryContainer,
      primaryContainer: kWhiteColor,
      // secondaryVariant: ,
      onPrimaryContainer: kWhiteColor,
      secondary: kSecondary,
      background: kBackColor,
      surface: kWhiteColor

    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: kWhiteColor,
      type: BottomNavigationBarType.shifting,
    ),
    appBarTheme: const AppBarTheme(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
      centerTitle: true,
      backgroundColor: kWhiteColor,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: kWhiteColor,
          statusBarIconBrightness: Brightness.dark),
      elevation: 0.0,
      iconTheme: IconThemeData(color: kGreyColor, size: 24.0),
      titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      toolbarTextStyle: TextStyle(fontSize: 20, color: Colors.black),
    ),
  );
}

ThemeData darkThemeMode() {
  return ThemeData(
    primarySwatch: Colors.cyan,
    scaffoldBackgroundColor: kDarkGreyColor,
    backgroundColor: Colors.black87,
    textTheme: GoogleFonts.aBeeZeeTextTheme(
      TextTheme(
        headline6: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        subtitle1: const TextStyle(fontSize: 18, color: kCoWhiteColor),
        headline5: const TextStyle(fontSize: 24, color: Colors.white70),
        headline4: GoogleFonts.lato(
            color: kCoWhiteColor, fontSize: 30, fontWeight: FontWeight.bold),
        button: const TextStyle(
            color: kDarkGreyColor, fontSize: 24, fontWeight: FontWeight.w500),
        bodyText1: const TextStyle(
            color: kCoWhiteColor, fontSize: 14, fontWeight: FontWeight.bold),
        bodyText2: const TextStyle(fontSize: 14, color: kCoWhiteColor),
        caption: const TextStyle(fontSize: 18, color: kCoWhiteColor),
        subtitle2: const TextStyle(fontSize: 16, color: Colors.white70),
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: kPrimary,
      secondaryContainer: kSecondaryContainer,
      // secondaryVariant: ,
      onPrimaryContainer: Colors.black45,
      primaryContainer: Colors.black26,
      secondary: kSecondary,
      background: kDarkGreyColor,
        surface: kDarkGreyColor
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.shifting,
      backgroundColor: Colors.black87,
    ),
    appBarTheme: const AppBarTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.black12,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.black12,
          statusBarIconBrightness: Brightness.light),
      elevation: 0.0,
      iconTheme: IconThemeData(color: kDarkGreyColor, size: 24.0),
      titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      toolbarTextStyle: TextStyle(fontSize: 20, color: Colors.white70),
    ),
  );
}
