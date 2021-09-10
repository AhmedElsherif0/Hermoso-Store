import 'package:hermoso_store/utils/style.dart';
import 'package:flutter/material.dart';

class OnBoardBody extends StatelessWidget {
  const OnBoardBody({Key? key, required this.text, required this.image}) : super (key: key);

  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
      const  Spacer(),
        Container(
            margin: const EdgeInsets.all(8),
            child: const Text('Hermoso',
                style: kHermosoLogo, textAlign: TextAlign.center),),
        Text(
          text,
          style: kSubTitle,
          textAlign: TextAlign.center,
        ),
       const Spacer(),
        Expanded(flex:4, child: Image.asset(image, fit: BoxFit.contain, width: 250, height: 250)),
      ],
    );
  }
}
