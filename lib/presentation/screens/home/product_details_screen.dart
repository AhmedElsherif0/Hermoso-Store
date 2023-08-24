import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/cached_network_image.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/descreprtion_text.dart';
import 'package:hermoso_store/utils/style.dart';
import 'package:sizer/sizer.dart';

import '../../../data/model/products/product_model.dart';
import '../../../domain/cubit/global_cubit/products/products_cubit.dart';
import '../../../utils/colors.dart';
import '../../widgets/custom_widgets/back_ios_button.dart';
import '../../widgets/custom_widgets/custom_icon_button.dart';
import '../../widgets/custom_widgets/price_and_discount.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    Key? key,
    required this.emptySearchList,
    required this.index,
  }) : super(key: key);

  static const routeName = 'productDetails-Screen';

  final bool emptySearchList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            systemOverlayStyle:
                const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
            leading: const BackIosButton(backgroundColor: AppColor.kDetailsColor),
            expandedHeight: 85.h,
            toolbarHeight: 10.h,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: priceFunc(context) == oldPriceFunc(context)
                  ? newCollection('New Collection')
                  : newCollection('Sale Collection'),
              background: Hero(
                tag: emptySearchList
                    ? _searchProduct(context).image
                    : _dataListItem(context).image,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: CachedImage(
                      imageUrl: emptySearchList
                          ? _searchProduct(context).image
                          : _dataListItem(context).image,
                      boxFit: BoxFit.scaleDown),
                ),
              ),
            ),
          ),
          BlocBuilder<ProductsCubit, ProductsStates>(
            builder: (context, state) {
              print('details builder ');
              return SliverList(
                delegate: SliverChildListDelegate(
                  [
                    DecoratedBox(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 1.4.h),
                            Text(
                              emptySearchList
                                  ? _searchProduct(context).name
                                  : _dataListItem(context).name,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.subtitle1,
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 1.4.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PriceAndDiscount(
                                    price: emptySearchList
                                        ? _searchProduct(context).price
                                        : _dataListItem(context).price,
                                    oldPrice: emptySearchList
                                        ? _searchProduct(context).oldPrice
                                        : _dataListItem(context).oldPrice,
                                    priceStyle: Theme.of(context).textTheme.subtitle1,
                                    oldPriceStyle: kDetailsDiscountStyle),
                                CustomIconButton(
                                  onPressFavorite: () => _productsCubit(context)
                                      .toggleFavoriteState(_dataListItem(context).id),
                                  icon: _productsCubit(context).favoriteMap[
                                              emptySearchList
                                                  ? _searchProduct(context).id
                                                  : _dataListItem(context).id] ==
                                          true
                                      ? Icons.star
                                      : Icons.star_border,
                                )
                              ],
                            ),
                            SizedBox(height: 1.4.h),
                            DescriptionText(
                                description: emptySearchList
                                    ? _searchProduct(context).description
                                    : _dataListItem(context).description)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  num priceFunc(context) {
    num price =
        emptySearchList ? _searchProduct(context).price : _dataListItem(context).price;
    return price;
  }

  num oldPriceFunc(context) {
    num oldPrice = emptySearchList
        ? _searchProduct(context).oldPrice
        : _dataListItem(context).oldPrice;
    return oldPrice;
  }

  ProductModel _searchProduct(context) =>
      _productsCubit(context).productSearchList[index];

  ProductModel _dataListItem(context) =>
      _productsCubit(context).homeModel.data.products[index];

  ProductsCubit _productsCubit(context) => BlocProvider.of<ProductsCubit>(context);

  Widget newCollection(String newCollection) {
    return Text(newCollection, style: kTitleCardStyle, textAlign: TextAlign.center);
  }
}
