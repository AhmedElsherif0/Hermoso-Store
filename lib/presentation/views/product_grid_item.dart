import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hermoso_store/utils/colors.dart';
import 'package:sizer/sizer.dart';

import '../../utils/style.dart';
import '../widgets/custom_widgets/cached_network_image.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({
    Key? key,
    required this.onGestureTap,
    required this.onPressFavorite,
    required this.price,
    required this.oldPrice,
    required this.title,
    required this.networkImage,
    required this.favoriteIcon,
    required this.onPressCart,
    required this.cartIcon,
  }) : super(key: key);

  final void Function() onGestureTap;
  final String networkImage;
  final void Function() onPressFavorite;
  final void Function() onPressCart;
  final num? price;
  final IconData favoriteIcon;
  final IconData cartIcon;
  final num? oldPrice;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20.w,
      height: 20.w,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            borderRadius: BorderRadius.circular(2.h)),
        child: Column(
          children: [
            /// Favorite Icon
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  const Spacer(flex: 9),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                        alignment: Alignment.center,
                        padding: EdgeInsets.zero,
                        icon: Icon(favoriteIcon),
                        iconSize: 18.sp,
                        highlightColor: Colors.transparent,
                        color: AppColor.kSecondaryContainerColor,
                        onPressed: onPressFavorite),
                  ),
                ],
              ),
            ),

            /// Network Image
            Expanded(
              flex: 10,
              child: GestureDetector(
                onTap: onGestureTap,
                child: Hero(
                  tag: networkImage,
                  child: CachedImage(imageUrl: networkImage),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  const Spacer(),
                  FittedBox(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "\$${price}",
                            style: Theme.of(context).textTheme.bodyText2,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                          ),
                          if (price != oldPrice)
                            Text(
                              "\$${oldPrice}",
                              style: kDiscountStyle.copyWith(fontSize: 11.sp),
                              textAlign: TextAlign.start,
                              maxLines: 1,
                            ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 18,
                    child: Text(title,
                        style: Theme.of(context).textTheme.bodyText1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 6,
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 16.sp,
                        highlightColor: Colors.transparent,
                        icon: Icon(cartIcon, size: 16.sp),
                        color: AppColor.kSecondaryContainerColor,
                        onPressed: onPressCart),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
