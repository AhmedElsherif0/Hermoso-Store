import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/colors.dart';

class RowOfIcons extends StatelessWidget {
  const RowOfIcons({
    Key? key,
    required this.onPressFavorite,
    required this.onPressCart,
  }) : super(key: key);

  final void Function() onPressFavorite;

  final void Function() onPressCart;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 7,
          child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: onPressCart,
              iconSize: 16.sp,
              icon: const Icon(Icons.shopping_cart_outlined,
                  color: AppColor.kSecondaryContainerColor)),
        ),
        const Spacer(),
        Expanded(flex: 11,
          child: IconButton(
            padding: EdgeInsets.zero,
              onPressed: onPressFavorite,
              iconSize: 16.sp,
              icon: const Icon(Icons.notifications_none,
                  color:AppColor. kSecondaryContainerColor )),
        ),
        const Spacer(flex: 2,),
      ],
    );
  }
}
