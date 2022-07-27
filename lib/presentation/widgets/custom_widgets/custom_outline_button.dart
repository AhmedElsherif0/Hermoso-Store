import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.alignment = Alignment.center})
      : super(key: key);

  final void Function()? onPressed;
  final String text;
  final Alignment alignment;


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 1.3),
        ),
        child: Text(text),
      ),
    );
  }
}
