import 'package:firstdesign/utils/style.dart';
import 'package:flutter/cupertino.dart';

class HeaderTexts extends StatelessWidget {
  const HeaderTexts({required this.title, required this.subTitle});

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child:  Text(title,
                style: kMainText, textAlign: TextAlign.center)),
         Text(
          subTitle,
          style: kSubTitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
