import 'package:hermoso_store/cubit/home/products/products_cubit.dart';
import 'package:hermoso_store/cubit/home/settings/settings_cubit.dart';
import 'package:hermoso_store/model/home_model/home_data.dart';
import 'package:hermoso_store/ui/screens/home/product_details_screen.dart';

import 'package:hermoso_store/ui/widgets/animated_swiper.dart';
import 'package:hermoso_store/ui/widgets/custom_widgets/custom_action_appbar.dart';
import 'package:hermoso_store/ui/widgets/custom_widgets/empty_screen.dart';
import 'package:hermoso_store/ui/widgets/custom_widgets/loading_widget.dart';
import 'package:hermoso_store/ui/widgets/search_field.dart';
import 'package:hermoso_store/ui/widgets/show_dialog.dart';
import 'package:hermoso_store/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/colors.dart';
import '../../widgets/product_grid_item.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> with ShowAlertMixin {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_dataListItem(context).products.isEmpty) {
      _productsCubit(context).getProducts();
    }
    if (_dataListItem(context).banners.isEmpty) {
      _productsCubit(context).getBanners();
    }
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customActionAppBar(
          isDark: _settingsCubit(context).isDarkMode,
          color: kWhiteColor,
          context: context,
          widget: SearchField(
              controller: _searchController,
              onChanged: (value) {
                _productsCubit(context).searchProductByName(value);
              }),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: _buildBannersWidget(context)),
        SizedBox(height: SizeConfig.getScreenHeight(24)),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'Recent Item',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: SizeConfig.getScreenHeight(8)),
        Expanded(flex: 4, child: _buildProductsWidget(context)),
      ]),
    );
  }

  BlocConsumer _buildProductsWidget(context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
        listener: (context, state) {
      if (state is ProductsErrorState) {
        return showToast(context, 'Please Check Your Network Connection');
      }
    }, builder: (context, state) {
      print('Products builder Widget Screen ');
      if (state is BannersLoadingState) {
        print('products Loading states Screen ');
        return const LoadingWidget();
      }
      return _dataListItem(context).products.isNotEmpty
          ? RefreshIndicator(
              onRefresh: () => _productsCubit(context).getProducts(),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _searchController.text.isEmpty
                    ? _dataListItem(context).products.length
                    : _productsCubit(context).searchedProductList.length,
                padding: EdgeInsets.all(SizeConfig.getScreenWidth(4)),
                itemBuilder: (context, index) => ProductGridItem(
                  onFavorite: () {
                    _productsCubit(context)
                      .toggleFavoriteState(_dataListItem(context).products[index].id);
                  print('${_dataListItem(context).products[index].id}');},
                  onGestureTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductDetails(
                          id: _searchController.text.isNotEmpty
                              ? _productsCubit(context)
                                  .searchedProductList[index]
                                  .id
                              : _dataListItem(context).products[index].id,
                          price: _searchController.text.isNotEmpty
                              ? _productsCubit(context)
                                  .searchedProductList[index]
                                  .price
                              : _dataListItem(context).products[index].price,
                          name: _searchController.text.isNotEmpty
                              ? _productsCubit(context)
                                  .searchedProductList[index]
                                  .name
                              : _dataListItem(context).products[index].name,
                          networkImage: _searchController.text.isNotEmpty
                              ? _productsCubit(context)
                                  .searchedProductList[index]
                                  .image
                              : _dataListItem(context).products[index].image,
                          oldPrice: _searchController.text.isNotEmpty
                              ? _productsCubit(context)
                                  .searchedProductList[index]
                                  .oldPrice
                              : _dataListItem(context).products[index].oldPrice,
                          description: _searchController.text.isNotEmpty
                              ? _productsCubit(context)
                                  .searchedProductList[index]
                                  .description
                              : _dataListItem(context)
                                  .products[index]
                                  .description,
                          onPressFavorite: () => _productsCubit(context)
                              .toggleFavoriteState(
                                  _dataListItem(context).products[index].id),
                        ),
                      ),
                    );
                  },
                  title: _searchController.text.isNotEmpty
                      ? _productsCubit(context).searchedProductList[index].name
                      : _dataListItem(context).products[index].name,
                  price: _searchController.text.isNotEmpty
                      ? _productsCubit(context).searchedProductList[index].price
                      : _dataListItem(context).products[index].price,
                  oldPrice: _searchController.text.isNotEmpty
                      ? _productsCubit(context)
                          .searchedProductList[index]
                          .oldPrice
                      : _dataListItem(context).products[index].oldPrice,
                  imageUrl: _searchController.text.isNotEmpty
                      ? _productsCubit(context).searchedProductList[index].image
                      : _dataListItem(context).products[index].image,
                  favoriteIcon:  _productsCubit(context).favoriteMap[
                _dataListItem(context).products[index].id] ==
                    true
                    ? Icons.star
                    : Icons.star_border,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 2.4,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8),
              ),
            ) /*ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _productsListItem(context).length,
            itemBuilder: (context, index) => ProductCard(
              onPressedFavorite: () {

              },

              onTapInkWell: () {
              Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProductDetails(
                      id: _productsListItem(context)[index].id,
                          price: _productsListItem(context)[index].price,
                          name: _productsListItem(context)[index].name,
                          networkImage: _productsListItem(context)[index].image,
                          oldPrice: _productsListItem(context)[index].oldPrice,
                          description:
                              _productsListItem(context)[index].description,
                          onPressFavorite: () => _productsCubit(context)
                              .toggleFavoriteState(
                                  _productsListItem(context)[index].id),
                        )));
              },
            ),
          )*/

          : const EmptyScreen(text: 'Network occur \nan Error');
    });
  }

  ProductsCubit _productsCubit(context) => ProductsCubit.get(context);

  SettingsCubit _settingsCubit(context) => SettingsCubit.get(context);

  BlocBuilder _buildBannersWidget(context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        print('banners builder Widget Screen ');
        if (state is BannersLoadingState) {
          print('banners loading states Screen ');
          return const LoadingWidget();
        }
        if (state is BannersErrorState) {
          print('banners error states Screen :${state.error.toString()}');
        }
        return _dataListItem(context).banners.isNotEmpty
            ? AnimationSwiper(
                itemBuilder: (context, index) {
                  return FadeInImage(
                      placeholder:
                          const AssetImage('assets/product-placeholder.png'),
                      image: NetworkImage(
                          '${_dataListItem(context).banners[index].image}'),
                      fit: BoxFit.cover);
                },
                itemLength: _dataListItem(context).banners.length,
              )
            : const EmptyScreen(text: 'Network occur an Error...');
      },
    );
  }

  HomeData _dataListItem(context) {
    return _productsCubit(context).homeModel.data;
  }
}
