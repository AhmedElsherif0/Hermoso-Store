import 'package:flutter/material.dart';
import 'package:hermoso_store/utils/colors.dart';
import 'package:sizer/sizer.dart';

class DotsContainer extends StatelessWidget {
  final int index;
  final int? currentPage;

  const DotsContainer({
    Key? key,
    required this.index,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin:  EdgeInsets.all(1.w),
      height: 1.1.h ,
      width: currentPage == index ? 5.w : 2.w,
      decoration: BoxDecoration(
          color: currentPage == index
              ? Theme.of(context).colorScheme.primary
              :AppColor. kBackButtonColor,
          borderRadius: BorderRadius.circular(2.sp)),
      duration: const Duration(milliseconds: 300),
    );
  }
}
