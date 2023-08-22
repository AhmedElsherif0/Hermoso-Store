import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/back_ios_button.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/row_of_icons.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/colors.dart';
import '../../screens/home/cart_screen.dart';
import '../../screens/home/notification_screen.dart';

class CustomAppBar {
  SystemUiOverlayStyle _systemUiOverlayStyle(isDark, color) => SystemUiOverlayStyle(
      statusBarColor: isDark ? AppColor.kVeryDarkGreyColor : color,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark ? Brightness.light : Brightness.dark);

  PreferredSizeWidget changeAppAndStatusBarColor(
      {Color color = AppColor.kBackColor,
      double barHeight = 0.0,
      bool isDark = false,
      Widget backButton = const Icon(null)}) {
    return AppBar(
      leading: backButton,
      toolbarHeight: barHeight,
      backgroundColor: isDark ? AppColor.kDarkGreyColor : color,
      systemOverlayStyle: _systemUiOverlayStyle(isDark, color),
    );
  }

  PreferredSizeWidget notificationAppBar(
      {required void Function() onPressed,
      required Color color,
      bool isDark = false,
      textStyle}) {
    return AppBar(
      systemOverlayStyle: _systemUiOverlayStyle(isDark, color),
      leading: const BackIosButton(),
      title: Text(
        'Notifications',
        style: textStyle,
      ),
      actions: [
        CircleAvatar(
            child: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: onPressed,
                iconSize: 30,
                color: AppColor.red),
            radius: 26,
            backgroundColor: AppColor.kDetailsColor),
        SizedBox(width: 1.h)
      ],
    );
  }

  PreferredSizeWidget actionAppBar(
      {bool isDark = false,
      Color color = AppColor.kBackColor,
      double barHeight = 0.0,
      required BuildContext context,
      required Widget widget,
      required Widget widget2}) {
    return AppBar(
      systemOverlayStyle: _systemUiOverlayStyle(isDark, color),
      backgroundColor: isDark ? AppColor.kVeryDarkGreyColor : color,
      leading: const Icon(null),
      toolbarHeight: barHeight,
      actions: [
        Expanded(flex: 6, child: widget),
        Expanded(flex: 2, child: widget2),
      ],
    );
  }
}
