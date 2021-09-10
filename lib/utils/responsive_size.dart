import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData = const MediaQueryData();
  static double screenWidth = 781.09;
  static double screenHeight = 392.72;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

double getScreenHeight(double inputHeight) {
  return (inputHeight / 781.09) * SizeConfig.screenHeight;
}

double getScreenWidth(double inputWidth) {
  return (inputWidth / 392.72) * SizeConfig.screenWidth;
}
