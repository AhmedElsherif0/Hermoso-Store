import 'package:flutter/material.dart';
import 'package:hermoso_store/utils/colors.dart';
import 'package:sizer/sizer.dart';

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Padding(
        padding: EdgeInsets.all(1.sp),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColor.kBlack26.withOpacity(0.1),
          ),
        ),
      ),
    );
  }
}
