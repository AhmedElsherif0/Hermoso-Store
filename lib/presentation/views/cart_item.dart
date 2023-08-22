import 'package:hermoso_store/presentation/widgets/custom_widgets/cached_network_image.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/custom_circle_button.dart';
import 'package:hermoso_store/utils/colors.dart';
import 'package:hermoso_store/utils/responsive_size.dart';
import 'package:hermoso_store/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../data/model/cart_model/cart_item_model.dart';
import '../widgets/custom_widgets/price_and_discount.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    this.onPressIncrement,
    this.onPressDecrement,
    this.onDismissed,
    required this.cartItemModel,
  }) : super(key: key);

  final VoidCallback? onPressIncrement;
  final VoidCallback? onPressDecrement;
  final void Function(DismissDirection)? onDismissed;
  final CartItemModel cartItemModel;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: ValueKey(cartItemModel.id),
        direction: DismissDirection.endToStart,
        background: DecoratedBox(
          decoration: const BoxDecoration(color: AppColor.kSecondaryColor),
          child: Row(
            children: [
              const Spacer(flex: 4),
              Icon(Icons.delete, size: 20.sp, color: AppColor.kCoWhiteColor),
              const Spacer(),
            ],
          ),
        ),
        onDismissed: onDismissed,
        child: Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          elevation: 4.w,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3.5.sp)),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 3.sp),
            child: Row(
              children: [
                /// Cart image
                Expanded(
                  flex: 4,
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.sp),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3.sp),
                        child: CachedImage(imageUrl: cartItemModel.image ??
                            'assets/product-placeholder.png'),
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
                        ///  Cart name
                        Text(
                          cartItemModel.name,
                          style: Theme.of(context).textTheme.subtitle1,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ]),
                      SizedBox(height: SizeConfig.getScreenHeight(12.0)),

                      /// Cart Price and OldPrice
                      PriceAndDiscount(
                        price: cartItemModel.price,
                        oldPrice: cartItemModel.oldPrice,
                        oldPriceStyle: kDiscountStyle,
                        priceStyle: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  ),
                ),
                const Spacer(),

                /// Cart Quantity Increment and Decrement
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      CustomCircleButton(
                          onPressed: onPressIncrement, icon: Icons.add),
                      Text(
                        '${cartItemModel.quantity}',
                        style: Theme.of(context).textTheme.subtitle1),
                      CustomCircleButton(
                          onPressed: onPressDecrement, icon: Icons.remove),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ));
  }
}
