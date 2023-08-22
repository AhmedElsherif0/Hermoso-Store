import 'package:flutter/material.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/linear_container_color.dart';
import 'package:sizer/sizer.dart';

class CustomCircleButton extends StatelessWidget {
  const CustomCircleButton({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  final void Function()? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return LinearContainerColor(
      borderRadius: 14.sp,
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 14.sp,
        child: IconButton(
            iconSize: 14.sp,
            onPressed: onPressed,
            icon: Icon(icon,
                size: 14.sp, color: Theme.of(context).colorScheme.surface)),
      ),
    );
  }
}
