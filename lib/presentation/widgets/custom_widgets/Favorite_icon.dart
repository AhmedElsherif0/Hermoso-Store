import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon({Key? key,
    required this.onPressFavorite,
    required this.icon,})
      : super(key: key);

  final void Function() onPressFavorite;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 16.sp,
      onPressed: onPressFavorite,
      icon: Icon(icon, color:
          Theme.of(context).colorScheme.primary),
    );
  }
}
