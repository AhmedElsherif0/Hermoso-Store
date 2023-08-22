import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData = const MediaQueryData();
  static double screenWidth = 392.72;

  static double screenHeight = 829.09;

  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }

  static double getScreenHeight(double inputHeight) {
    return (inputHeight / 829.0) * screenHeight;
  }

  static double getScreenHByW(double inputHeight, double inputWidth) {
    return ((inputWidth * inputHeight) / 829.0) * screenHeight;
  }

  static double getScreenWidth(double inputWidth) {
    return (inputWidth / 392.72) * screenWidth;
  }
  static bool isLandScape() => orientation == Orientation.landscape;

  static bool isPortrait() => orientation == Orientation.portrait;
}
