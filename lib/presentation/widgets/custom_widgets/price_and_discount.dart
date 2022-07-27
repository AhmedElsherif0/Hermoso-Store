import 'package:flutter/material.dart';
import 'package:hermoso_store/utils/responsive_size.dart';
import 'package:hermoso_store/utils/style.dart';


class PriceAndDiscount extends StatelessWidget {
  const PriceAndDiscount(
      {Key? key,
      required this.price,
      required this.oldPrice,
      this.oldPriceStyle = kDetailsDiscountStyle,
      this.priceStyle })
      : super(key: key);
  final num? price;

  final num? oldPrice;

  final TextStyle oldPriceStyle;

  final TextStyle? priceStyle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.start,
      children: [
        if(price != null)
        Text('\$${price}',
            style: priceStyle),
        SizedBox(width: SizeConfig.getScreenWidth(4)),
        if (price != oldPrice)
          Text('$oldPrice',
              style: oldPriceStyle)
      ],
    );
  }
}
