import 'package:flutter/material.dart';
import 'package:hermoso_store/utils/colors.dart';
import 'package:sizer/sizer.dart';

import 'cart_badge.dart';

class RowOfIcons extends StatelessWidget {
  const RowOfIcons({
    Key? key,
    required this.onPressFavorite,
    required this.onPressCart,
    required this.value,
    required this.isDarK,
  }) : super(key: key);

  final void Function() onPressFavorite;
  final void Function() onPressCart;
  final int value;
  final bool isDarK;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: CartBadge(
            color: value != 0
                ? AppColor.red
                : isDarK
                    ? AppColor.kDarkGreyColor
                    : AppColor.kWhiteColor,
            value: value,
            widget: IconButton(
              padding: EdgeInsets.zero,
              onPressed: onPressCart,
              iconSize: 16.sp,
              icon: const Icon(Icons.shopping_cart_outlined,
                  color: AppColor.kSecondaryContainerColor),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: onPressFavorite,
            iconSize: 18.sp,
            icon: const Icon(Icons.notifications_none,
                color: AppColor.kSecondaryContainerColor),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
