import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/style.dart';
import 'custom_widgets/custom_text_button.dart';

mixin ShowAlertMixin {
  void showMeDialog(BuildContext context, String state, String message) {
    showAlertDialog(
      context: context,
      title: state,
      actionButton: [
        Wrap(children: [
          Text(message, style: const TextStyle(fontWeight: FontWeight.w500))
        ]),
        CustomTextButton(
          onPressed: () => Navigator.of(context).pop(),
          text: 'Close',
        )
      ],
    );
  }

  void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, textAlign: TextAlign.center,
        style: kDetailsTitleStyle,),
      duration: const Duration(seconds: 3),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20), right: Radius.circular(20))),
      elevation: 5,
      /*action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          cart.removeSingleItem(product.productId);
        }),*/
    ));
  }
}

/// This uses a platform-appropriate mechanism to show users multiple choices.



void showAlertDialog(
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
                    borderRadius: BorderRadius.circular(16)),
                titleTextStyle: const TextStyle(color: Colors.black),
                title: Text(title,
                    style: Theme.of(context).textTheme.subtitle1,
                    maxLines: 4,
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
