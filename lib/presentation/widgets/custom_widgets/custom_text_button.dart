import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final AlignmentGeometry alignment;

  const CustomTextButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.alignment = Alignment.bottomRight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: TextButton(
        onPressed: onPressed,
        child: Text(text,
            style:  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
