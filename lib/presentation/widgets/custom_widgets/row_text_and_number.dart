import 'package:flutter/material.dart';

import 'custom_text_button.dart';

class RowTextAndNumber extends StatelessWidget {
  final String text;
  final num price;

  const RowTextAndNumber(
      {required this.text,
      Key? key, required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: Theme.of(context).textTheme.subtitle1),
        const Spacer(),
        Text("\$${price.toStringAsFixed(2)}",
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
              fontWeight: FontWeight.bold
            )),
      ],
    );
  }
}
