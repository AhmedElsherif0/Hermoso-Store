import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DescriptionText extends StatelessWidget {
  const DescriptionText({
    Key? key,
    required this.description,
  }) : super(key: key);
  final String description;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.h,
      width: double.infinity,
      child: Text(
        description,
        style: Theme.of(context).textTheme.subtitle2,
        textAlign: TextAlign.start,
        softWrap: true,
        maxLines: 8,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
