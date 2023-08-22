import 'package:flutter/material.dart';


class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key? key,
    this.text = 'Empty Screen...'})
      : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text,
          style: Theme.of(context).textTheme.caption,
          textAlign: TextAlign.center),
    );
  }
}
