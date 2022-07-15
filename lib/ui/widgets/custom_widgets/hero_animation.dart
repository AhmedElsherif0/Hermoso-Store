import 'package:flutter/cupertino.dart';

class HeroAnimation extends StatelessWidget {
  const HeroAnimation(
      {Key? key, required this.tag, required this.imageUrl, this.fit = BoxFit
          .cover})
      : super(key: key);

  final String tag;
  final String imageUrl;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: FadeInImage(
          fadeInCurve: Curves.bounceIn,
          placeholder: const AssetImage('assets/product-placeholder.png'),
          image: NetworkImage(imageUrl),
          fit: fit,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset('assets/product-placeholder.png');
          }
      ),
    );

  }
}
