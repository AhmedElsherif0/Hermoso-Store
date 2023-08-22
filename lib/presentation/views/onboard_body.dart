import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OnBoardBody extends StatelessWidget {
  const OnBoardBody({Key? key, required this.text, required this.image})
      : super(key: key);

  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Spacer(),
        Expanded(
          child: Text('Hermoso',
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center),
        ),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.subtitle2,
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(),
        Expanded(
            flex: 5,
            child: Image.asset(image,
                fit: BoxFit.contain, width: 180.sp, height: 180.sp, )),
      ],
    );
  }
}
