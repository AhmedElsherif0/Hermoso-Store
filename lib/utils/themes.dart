import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightThemeMode() {
  return ThemeData(
    scaffoldBackgroundColor: Color(0xffffffff),
    textTheme: GoogleFonts.aBeeZeeTextTheme(ThemeData.light().textTheme),
    colorScheme: const ColorScheme.light(
      primary: Color(0xff6ae7d9),
      primaryVariant: Color(0xff00ceb8),
      secondary: Color(0xff6200EE),
      background: Color(0xffffffff),
    ),
    appBarTheme: const AppBarTheme(
      backwardsCompatibility: false,
      centerTitle: true,
      backgroundColor: const Color(0xffffffff) ,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      elevation: 0.0,
      iconTheme: IconThemeData(color:Colors.black,size: 24.0),
      textTheme: TextTheme(
        bodyText2: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 20,color: Colors.black),
      ),
    ),
  );
}
