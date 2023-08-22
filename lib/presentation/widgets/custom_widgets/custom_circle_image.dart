import 'package:flutter/material.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/cached_network_image.dart';

import '../../../utils/responsive_size.dart';

class CustomCircleImage extends StatelessWidget {
  const CustomCircleImage({Key? key, required this.networkImage}) : super(key: key);

  final String networkImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.getScreenHeight(100),
      width: SizeConfig.getScreenWidth(100),
      child: CircleAvatar(
        child: CachedImage(imageUrl: networkImage),
      ),
    );
  }
}
