import 'package:flutter/material.dart';
import '../../../utils/responsive_size.dart';

class CustomText extends StatelessWidget {
  const CustomText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: SizeConfig.getScreenHeight(50),
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimaryContainer),
        child: Padding(
          padding: EdgeInsets.only(left: SizeConfig.getScreenWidth(16)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
