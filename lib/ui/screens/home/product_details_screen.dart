import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermoso_store/model/products/product_model.dart';
import 'package:hermoso_store/ui/widgets/custom_widgets/back_ios_button.dart';
import 'package:hermoso_store/ui/widgets/custom_widgets/hero_animation.dart';
import 'package:hermoso_store/utils/responsive_size.dart';
import 'package:hermoso_store/utils/style.dart';

import '../../../cubit/home/products/products_cubit.dart';
import '../../../utils/colors.dart';
import '../../widgets/custom_widgets/price_and_discount.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails(
      {Key? key,
      required this.name,
      required this.price,
      required this.oldPrice,
      required this.description,
      required this.networkImage,
      required this.onPressFavorite,
      required this.id})
      : super(key: key);

  static const routeName = 'productDetails-Screen';

  final int id;

  final String name;

  final num? price;

  final num? oldPrice;

  final String description;

  final String networkImage;
  final VoidCallback onPressFavorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
        SliverAppBar(
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          leading: const BackIosButton(color: kDetailsColor),
          expandedHeight: MediaQuery.of(context).size.height * 0.85,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: price == oldPrice
                  ? newCollection('New')
                  : newCollection('Sale Collection'),
              background: HeroAnimation(imageUrl: networkImage, tag: name)),
        ),
        BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            print('details builder ');
            return SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30))),
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: SizeConfig.getScreenHeight(10)),
                        Text(
                          name,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.subtitle1,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: SizeConfig.getScreenHeight(10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PriceAndDiscount(
                                price: price,
                                oldPrice: oldPrice,
                                priceStyle:
                                    Theme.of(context).textTheme.subtitle1,
                                oldPriceStyle: kDetailsDiscountStyle),
                            IconButton(
                              onPressed: () {
                                _productsCubit(context).toggleFavoriteState(id);
                              },
                              icon: Icon(
                                  _productsCubit(context).favoriteMap[id] ==
                                          true
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 26),
                            )
                          ],
                        ),
                        SizedBox(height: SizeConfig.getScreenHeight(14)),
                        SizedBox(
                            height: 900,
                            width: double.infinity,
                            child: Text(
                              description,
                              style: Theme.of(context).textTheme.subtitle2,
                              textAlign: TextAlign.start,
                              softWrap: true,
                              maxLines: 8,
                              overflow: TextOverflow.ellipsis,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ]),
    );
  }

  ProductsCubit _productsCubit(context) {
    return BlocProvider.of<ProductsCubit>(context);
  }

  List<ProductModel> _productsListItem(context) {
    return _productsCubit(context).homeModel.data.products;
  }

  Widget newCollection(String newCollection) {
    return Text(newCollection,
        style: kTitleCardStyle, textAlign: TextAlign.center);
  }
}
