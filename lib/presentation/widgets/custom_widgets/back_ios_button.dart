import 'package:flutter/material.dart';
import 'package:hermoso_store/utils/colors.dart';
import 'package:hermoso_store/utils/responsive_size.dart';
import 'package:sizer/sizer.dart';

class BackIosButton extends StatelessWidget {
  const BackIosButton({
    Key? key,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      radius: 5.w,
      child: IconButton(
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
        iconSize: 6.5.w,
        icon: Icon(Icons.arrow_back_ios_new_outlined,
            size: 6.5.w, color: AppColor.kBlackColor),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
