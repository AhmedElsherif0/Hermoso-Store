import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class HeaderTexts extends StatelessWidget {
  const HeaderTexts({required this.title, required this.subTitle, Key? key})
      : super(key: key);

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (SizerUtil.orientation == Orientation.landscape) Spacer(flex: 2),
        Text(title, style: Theme.of(context).textTheme.headline4),
        Spacer(
          flex: SizerUtil.orientation == Orientation.landscape ? 5 : 1,
        ),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.subtitle2,
          textAlign: TextAlign.center,
        ),
        Spacer(flex: SizerUtil.orientation == Orientation.landscape ? 8 : 3),
      ],
    );
  }
}
