import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/responsive_size.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, top: 8,bottom: 8),
      decoration: BoxDecoration(
        color: kDetailsColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(SizeConfig.getScreenHeight(12)),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: "Search ",
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          prefixIcon: const Icon(Icons.search,
            color: kSecondaryContainer,
          ),
        ),
      ),
    );
  }
}
