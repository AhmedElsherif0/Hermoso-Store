import 'package:flutter/material.dart';
import 'package:hermoso_store/utils/colors.dart';
import 'package:hermoso_store/utils/responsive_size.dart';


class BackIosButton extends StatelessWidget {
  const BackIosButton({Key? key, this.color = Colors.transparent}) : super(key: key);
  final Color color ;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(SizeConfig.getScreenHeight(8)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConfig.getScreenHeight(20)), color: color),
      child: IconButton(
        icon:  Icon(
          Icons.arrow_back_ios,
          size: SizeConfig.getScreenWidth(22),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
