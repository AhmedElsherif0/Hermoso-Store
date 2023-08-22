import 'package:flutter/material.dart';
import 'package:hermoso_store/utils/colors.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton(
      {Key? key,
      required this.onPressed,
      this.text,
      this.alignment = Alignment.center,
      this.textStyle,
      this.icon,
      this.height,
      this.borderColor = Colors.black,
      this.width,
      this.iconColor })
      : super(key: key);

  final void Function()? onPressed;
  final String? text;
  final Alignment alignment;
  final TextStyle? textStyle;
  final IconData? icon;
  final double? height;
  final double? width;
  final Color borderColor;
  final Color? iconColor ;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
            side: BorderSide(color: borderColor, width: 2),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            padding: EdgeInsets.zero),
        child: text != null
            ? Row(
                children: [
                  const Spacer(flex: 6),
                  if (icon != null) Icon(icon, color: iconColor),
                  const Spacer(),
                  Text(text!, style: textStyle),
                  const Spacer(flex: 7)
                ],
              )
            : Icon(icon, color: iconColor,),
      ),
    );
  }
}
