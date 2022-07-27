import 'package:flutter/material.dart';

import '../../../utils/style.dart';

mixin ShowSnackBar {
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: kDetailsTitleStyle,
      ),
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
