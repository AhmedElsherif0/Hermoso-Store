import 'package:firstdesign/ui/widgets/custom_text_button.dart';
import 'package:firstdesign/utils/style.dart';
import 'package:flutter/material.dart';

class RowTextAndButton extends StatelessWidget {
  final String text;
  final String title;
  final VoidCallback onPressed;

  const RowTextAndButton({required this.text, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       Text(
      title,
      style: kTitleStyle,
    ),
    CustomTextButton(
    text: text,
    onPressed: onPressed
    )],
    );
  }
}
