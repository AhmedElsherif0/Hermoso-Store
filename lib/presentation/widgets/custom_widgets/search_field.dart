import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/colors.dart';
import '../../../utils/responsive_size.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
    required this.controller,
    required this.onChanged,
    this.isDark = true,
  }) : super(key: key);

  final TextEditingController controller;
  final void Function(String) onChanged;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6,left: 6,top: 2,bottom: 6),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isDark ? AppColor.kDarkGreyColor : AppColor.kDetailsColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          focusNode: FocusNode(canRequestFocus: false),
          autofocus: false,
          controller: controller,
          onChanged: onChanged,
          style: const TextStyle(color: AppColor.kBackButtonColor),
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search ",
            hintStyle: TextStyle(
                color: isDark ? AppColor.kCoWhiteColor : AppColor.kGreyColor),
            prefixIcon: Icon(Icons.search,
                color: AppColor.kSecondaryContainerColor, size: 16.sp),
          ),
        ),
      ),
    );
  }
}
