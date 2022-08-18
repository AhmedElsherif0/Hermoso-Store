import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hermoso_store/utils/colors.dart';
import 'package:sizer/sizer.dart';

ThemeData lightThemeMode() {
  return ThemeData(
    primarySwatch: Colors.cyan,
    scaffoldBackgroundColor: AppColor.kBackColor,
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
    textTheme: GoogleFonts.aBeeZeeTextTheme(
      TextTheme(
        headline1: TextStyle(
            fontSize: 27.sp, fontWeight: FontWeight.bold, color:AppColor. kPrimaryColor),
        headline6: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        subtitle1: TextStyle(fontSize: 13.sp, color: Colors.black),
        headline3: const TextStyle(fontSize: 22, color: Colors.black),
        headline5: const TextStyle(fontSize: 24, color: Colors.white70),
        headline4: GoogleFonts.lato(
            color: Colors.black, fontSize: 22.sp, fontWeight: FontWeight.bold),
        button: TextStyle(
            color: AppColor. kCoWhiteColor, fontSize: 16.sp, fontWeight: FontWeight.w600),
        bodyText1: TextStyle(
            fontSize: 11.1.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold),
        bodyText2: TextStyle(fontSize: 11.sp, color: Colors.black),
        caption: const TextStyle(fontSize: 18, color: AppColor.kGreyColor),
        subtitle2: TextStyle(fontSize: 12.sp, color: AppColor.kGreyColor),
      ),
    ),
    colorScheme: const ColorScheme.light(
        primary: AppColor.kPrimaryColor,
        secondaryContainer: AppColor. kSecondaryContainerColor,
        primaryContainer: AppColor.kWhiteColor,
        // secondaryVariant: ,
        onPrimaryContainer: AppColor.kWhiteColor,
        secondary: AppColor.kSecondaryColor,
        background: AppColor.kBackColor,
        surface: AppColor. kWhiteColor),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColor.kWhiteColor,
      type: BottomNavigationBarType.shifting,
    ),
    appBarTheme: const AppBarTheme(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
      centerTitle: true,
      backgroundColor: AppColor.kWhiteColor,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
      elevation: 0.0,
      iconTheme: IconThemeData(color: AppColor.kGreyColor, size: 24.0),
      titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      toolbarTextStyle: TextStyle(fontSize: 20, color: Colors.black),
    ),
  );
}

ThemeData darkThemeMode() {
  return ThemeData(
    primarySwatch: Colors.cyan,
    scaffoldBackgroundColor: AppColor.kDarkGreyColor,
    backgroundColor: Colors.black87,
    textTheme: GoogleFonts.aBeeZeeTextTheme(
      TextTheme(
        headline6: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        headline5: const TextStyle(fontSize: 24, color: Colors.white70),
        headline3: const TextStyle(fontSize: 22, color: Colors.white70),
        headline4: GoogleFonts.lato(
            color: AppColor.kCoWhiteColor, fontSize: 30, fontWeight: FontWeight.bold),
        button: const TextStyle(
            color: AppColor.kCoWhiteColor, fontSize: 24, fontWeight: FontWeight.w500),
        bodyText1: const TextStyle(
            color: AppColor.kCoWhiteColor, fontSize: 14, fontWeight: FontWeight.bold),
        bodyText2: const TextStyle(fontSize: 14, color: AppColor.kCoWhiteColor),
        caption: const TextStyle(fontSize: 18, color: AppColor.kCoWhiteColor),
        subtitle1: const TextStyle(fontSize: 18, color: AppColor.kCoWhiteColor),
        subtitle2: const TextStyle(fontSize: 16, color: Colors.white70),
      ),
    ),
    colorScheme: const ColorScheme.dark(
        primary: AppColor.kPrimaryColor,
        secondaryContainer: AppColor.kSecondaryContainerColor,
        // secondaryVariant: ,
        onPrimaryContainer: AppColor.kBlack54,
        primaryContainer: AppColor.kBlack26,
        secondary: AppColor.kSecondaryColor,
        background:AppColor.kDarkGreyColor,
        surface: AppColor.kDarkGreyColor),
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
      backgroundColor: Colors.black87,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.black12,
          statusBarIconBrightness: Brightness.light),
      elevation: 0.0,
      iconTheme: IconThemeData(color:AppColor. kDarkGreyColor, size: 24.0),
      titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      toolbarTextStyle: TextStyle(fontSize: 20, color: Colors.white70),
    ),
  );
}
