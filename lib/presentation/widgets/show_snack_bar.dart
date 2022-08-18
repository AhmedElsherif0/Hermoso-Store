import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/style.dart';

mixin SnackBarMixin {
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message,
            textAlign: TextAlign.center,
            style: kDetailsTitleStyle.copyWith(fontSize: 16.sp)),
        duration: const Duration(milliseconds:  1500),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(5.w), right: Radius.circular(5.w))),
        elevation: 5,
      ),
    );
  }
}
