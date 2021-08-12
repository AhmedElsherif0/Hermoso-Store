import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      child: TextButton(
        onPressed: onPressed,
        child: Text(text, style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
