import 'package:flutter/material.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/linear_container_color.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final TextStyle? textStyle;
  final double borderRadius;
  final double? height;
  final double width;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.textStyle = const TextStyle(color: AppColor.kWhiteColor, fontSize: 18),
    this.borderRadius = 8,
    this.height,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 6.h,
      width: width,
      child: LinearContainerColor(
        borderRadius: borderRadius,
        child: MaterialButton(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
          ),
          child: Text(text, style: textStyle),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
