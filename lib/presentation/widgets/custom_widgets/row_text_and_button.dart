import 'package:flutter/material.dart';

import 'custom_text_button.dart';

class RowTextAndButton extends StatelessWidget {
  final String text;
  final String title;
  final VoidCallback onPressed;

  const RowTextAndButton(
      {required this.text,
      required this.onPressed,
      required this.title,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: Theme.of(context).textTheme.subtitle1),
        CustomTextButton(text: text, onPressed: onPressed)
      ],
    );
  }
}
