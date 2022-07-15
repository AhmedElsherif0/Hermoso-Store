import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/colors.dart';
import '../../screens/home/card_screen.dart';
import '../../screens/home/notification_screen.dart';

PreferredSizeWidget changeAppAndStatusBarColor(
    {Color color = kBackColor,
    double barHeight = 0.0,
    bool isDark = false,
    Widget backButton = const Icon(null)}) {
  return AppBar(
    leading: backButton,
    toolbarHeight: barHeight,
    backgroundColor: isDark ? kDarkGreyColor : color,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: isDark ? kDarkGreyColor : color,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.light : Brightness.dark),
  );
}

PreferredSizeWidget customActionAppBar(
    {bool isDark = false,
    Color color = kBackColor,
    required BuildContext context,
    required Widget widget}) {
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: isDark ? kDarkGreyColor : color,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.light : Brightness.dark),
    backgroundColor: isDark ? kDarkGreyColor : color,
    leading: const Icon(null),
    actions: [
      Expanded(child: widget),
      IconButton(
          onPressed: () => Navigator.pushNamed(context, CardScreen.routeName),
          icon: const Icon(Icons.shopping_cart_outlined,
              color: kSecondaryContainer, size: 26)),
      IconButton(
          onPressed: () =>
              Navigator.pushNamed(context, NotificationsScreen.routeName),
          icon: const Icon(Icons.notifications_none,
              color: kSecondaryContainer, size: 26)),
    ],
  );
}
