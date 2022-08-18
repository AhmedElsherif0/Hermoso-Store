import 'package:flutter/material.dart';

import '../../../utils/responsive_size.dart';

class CustomCircleImage extends StatelessWidget {
  const CustomCircleImage({Key? key, required this.networkImage}) : super(key: key);

  final String networkImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.getScreenHeight(100),
      width: SizeConfig.getScreenWidth(100),
      child: ClipOval(
        child: FadeInImage(
          placeholder: const AssetImage('assets/product-placeholder.png'),
          image: NetworkImage(networkImage),
          fit: BoxFit.cover,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset('assets/product-placeholder.png');
          },
        ),
      ),
    );
  }
}
