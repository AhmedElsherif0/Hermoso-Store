import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HeaderTexts extends StatelessWidget {
  const HeaderTexts({required this.title, required this.subTitle, Key? key})
      : super(key: key);

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(title, style: Theme.of(context).textTheme.headline4)),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.subtitle2,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
