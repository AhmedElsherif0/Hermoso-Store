import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/loading_widget.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    Key? key,
    required this.imageUrl,
    this.curves = Curves.bounceIn, this.boxFit = BoxFit.cover,
  }) : super(key: key);

  final String imageUrl;

  final Curve curves;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fadeInCurve: curves,
      placeholder: (context, url) => const Center(child:  CircularProgressIndicator.adaptive()),
      imageUrl: imageUrl,
      fit: boxFit,
      errorWidget: (context, error, stackTrace) {
        return Image.asset('assets/product-placeholder.png');
      },
    );
  }
}
