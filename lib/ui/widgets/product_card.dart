import 'package:firstdesign/utils/responsive_size.dart';
import 'package:firstdesign/utils/style.dart';
import 'package:flutter/material.dart';

class CartCard extends StatelessWidget {
  const CartCard(
      {required this.image,
      required this.title,
      required this.price,
      required this.oldPrice,this.isFavorite = false});

  final String image;
  final String title;
  final dynamic price;
  final dynamic oldPrice;
  final bool isFavorite ;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: getScreenWidth(45),
          child: AspectRatio(
            aspectRatio: 0.8,
            child: Container(
              padding: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FadeInImage(
                  fadeInCurve: Curves.bounceIn,
                  placeholder: AssetImage('assets/product-placeholder.png'),
                  image: NetworkImage('$image'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: getScreenWidth(4)),
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: "${double.parse(price.toString()).toStringAsFixed(2)}",
                  style: (Theme.of(context).textTheme.bodyText1),
                  children: [
                    if (price != oldPrice)
                      TextSpan(
                          text: " ${double.parse(oldPrice.toString()).toStringAsFixed(2)}",
                          style: kDiscountStyle)
                  ],
                ),
              ),

            ],
          ),
        ),
        SizedBox(width: getScreenWidth(14)),
        IconButton(
            onPressed: () {},
            icon: Icon(isFavorite? Icons.favorite:  Icons.favorite_border,
                color:  isFavorite ? Colors.red : Colors.grey, size: 26)),
        IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_shopping_cart_outlined,
                color: isFavorite ? Colors.red :Colors.grey, size: 26)),
      ],
    );
  }
}
