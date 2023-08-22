import 'package:flutter/material.dart';
import 'package:hermoso_store/utils/colors.dart';

class CategoryItemCard extends StatelessWidget {
  const CategoryItemCard({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      elevation: 12.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 1.19,
            child: FadeInImage(
              fadeInCurve: Curves.bounceIn,
              placeholder:
                  const AssetImage('assets/product-placeholder.png'),
              image: NetworkImage(image),
              fit: BoxFit.contain,
              matchTextDirection: true,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/product-placeholder.png');
              },
            ),
          ),
          Positioned(
            height: 30,
            width: 200,
            left: 110,
            bottom: 0.0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColor.kBlack26.withOpacity(0.7)
              ),
              child: Center(
                child: Text(
                  title ,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
