import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hermoso_store/ui/widgets/custom_widgets/hero_animation.dart';
import 'package:hermoso_store/utils/colors.dart';
import 'package:hermoso_store/utils/responsive_size.dart';

import '../../utils/style.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({
    Key? key,
    required this.onGestureTap,
    required this.onFavorite,
    required this.price,
    required this.oldPrice,
    required this.title,
    required this.imageUrl, required this.favoriteIcon,
  }) : super(key: key);

  final void Function() onGestureTap;

  final String imageUrl;
  final void Function() onFavorite;
  final num? price;
  final IconData favoriteIcon ;

  final num? oldPrice;

  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onGestureTap,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            borderRadius: BorderRadius.circular(14)),
        width: SizeConfig.getScreenHeight(200),
        height: SizeConfig.getScreenHeight(200),
        child: GridTile(
          header: Container(
            alignment: Alignment.topRight,
            child: IconButton(
                icon: Icon(favoriteIcon),
                color: kSecondaryContainer,
                onPressed: onFavorite),
          ),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(SizeConfig.getScreenHByW(8, 7)),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: HeroAnimation(
                  tag: imageUrl, imageUrl: imageUrl, fit: BoxFit.contain),
            ),
          ),
          footer: GridTileBar(
            leading: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("\$${price}",
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.start),
                if (price != oldPrice)
                  Text("\$${oldPrice}",
                      style: kDiscountStyle, textAlign: TextAlign.start),
              ],
            ),
            title: Text(title,
                style: Theme.of(context).textTheme.bodyText1,
                overflow: TextOverflow.clip,
                maxLines: 1,
                textAlign: TextAlign.start),
            trailing: IconButton(
                icon: const Icon(Icons.add_shopping_cart, size: 22),
                color: kSecondaryContainer,
                onPressed: () {},
                alignment: Alignment.bottomRight),
          ), /* GridTileBar(
             trailing: IconButton(
              icon: const Icon(Icons.add_shopping_cart),
              color: theme.accentColor,
              onPressed: () async {
                try {
                  cart.addItem(product.productId, product.title, product.price);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text(
                      'Added Item to The Card',
                      textAlign: TextAlign.center,
                    ),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          cart.removeSingleItem(product.productId);
                        }),
                  ));
                } catch (error) {
                  print(error.toString());
                }
              },
            ),
          ),*/
        ),
      ),
    );
  }
}
