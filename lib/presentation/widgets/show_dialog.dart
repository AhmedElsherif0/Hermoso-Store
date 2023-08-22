import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hermoso_store/utils/colors.dart';

import '../../utils/style.dart';
import 'custom_widgets/custom_outline_button.dart';
import 'custom_widgets/custom_text_button.dart';

mixin AlertDialogMixin {
  void showAlertDialog(BuildContext context, String title, String message) {
    _customAlertDialog(
      context: context,
      title: title,
      actionButton: [
        Wrap(children: [
          Text(
            message,
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: AppColor.kPrimaryColor),
          )
        ]),
        CustomTextButton(
          onPressed: () => Navigator.of(context).pop(),
          text: 'Close',
        )
      ],
    );
  }
}

void showMeAlertDialog(BuildContext context, state) {
  _customAlertDialog(
    context: context,
    title: state,
    actionButton: [
      CustomOutlineButton(
        onPressed: () => Navigator.pop(context),
        text: 'Close',
      )
    ],
  );
}

void showLogoutDialog(String title, BuildContext context, String message,
    {required void Function() onPressed}) {
  _customAlertDialog(
    context: context,
    title: title,
    actionButton: [
      Wrap(children: [
        Text(
          message,
          style: const TextStyle(
              fontWeight: FontWeight.w500, color: AppColor.kPrimaryColor),
        )
      ]),
      Row(
        children: [
          CustomTextButton(
            onPressed: () => Navigator.of(context).pop(false),
            text: 'Not yet',
          ),
          CustomTextButton(
            onPressed: onPressed,
            text: 'Sure',
          )
        ],
      )
    ],
  );
}

/// This uses a platform-appropriate mechanism to show users multiple choices.

void _customAlertDialog(
    {required BuildContext context,
    required String title,
    Widget? message,
    required List<Widget> actionButton}) async {
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      await showDialog<void>(
        context: context,
        builder: (context) {
          return Center(
            child: SingleChildScrollView(
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                titleTextStyle: const TextStyle(color: Colors.black),
                title: Text(title,
                    style: Theme.of(context).textTheme.headline3,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center),
                content: message,
                actions: actionButton,
              ),
            ),
          );
        },
      );
      return;
    case TargetPlatform.iOS:
      await showCupertinoModalPopup<void>(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 250,
            child: CupertinoAlertDialog(
              title: Text(title, style: Theme.of(context).textTheme.subtitle1),
              content: message,
              actions: actionButton,
              scrollController: FixedExtentScrollController(initialItem: 1),
            ),
          );
        },
      );
      return;
    default:
      assert(false, 'Unexpected platform $defaultTargetPlatform');
  }
}
