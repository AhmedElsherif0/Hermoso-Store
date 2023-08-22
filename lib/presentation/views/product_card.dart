import 'package:hermoso_store/presentation/widgets/custom_widgets/cached_network_image.dart';
import 'package:hermoso_store/utils/colors.dart';
import 'package:hermoso_store/utils/responsive_size.dart';
import 'package:hermoso_store/utils/style.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_widgets/price_and_discount.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {required this.image,
      required this.title,
      this.price,
      this.oldPrice,
      this.isFavorite,
      required this.cardIcon,
      Key? key,
      required this.onPressedFavorite,
      })
      : super(key: key);

  final String? image;
  final String? title;
  final num? price;
  final num? oldPrice;
  final IconData? isFavorite;
  final Widget cardIcon;
  final VoidCallback onPressedFavorite;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      elevation: 12.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        children: [
          SizedBox(
            width: SizeConfig.getScreenWidth(90),
            child: Hero(
              tag: title ?? '',
              child: AspectRatio(
                aspectRatio: 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child:CachedImage(imageUrl: image!),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: SizeConfig.getScreenWidth(4)),
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(children: [
                  Text(
                    title ?? '',
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ]),
                SizedBox(height: SizeConfig.getScreenHeight(12.0)),
                PriceAndDiscount(
                  price: price,
                  oldPrice: oldPrice,
                  oldPriceStyle: kDiscountStyle,
                  priceStyle: Theme.of(context).textTheme.bodyText1,
                )
              ],
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onPressedFavorite,
            icon: Icon(isFavorite,
                color: Theme.of(context).colorScheme.secondaryContainer,
                size: 26),
          ),
          if(cardIcon !=null)
          IconButton(
                onPressed: () {},
                icon: cardIcon,
                color: cardIcon != null
                    ? Theme.of(context).colorScheme.secondaryContainer
                    :AppColor. kGreyColor),
        ],
      ),
    );
  }
}
