
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {Key? key,
      required this.onPressFavorite,
      required this.icon,
      this.backgroundColor,
      this.iconSize, this.iconColor})
      : super(key: key);

  final void Function() onPressFavorite;
  final IconData icon;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      color: backgroundColor,
      iconSize: iconSize ?? 16.sp,
      onPressed: onPressFavorite,
      icon: Icon(icon, color: iconColor ),
    );
  }
}
