import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermoso_store/data/model/products/product_model.dart';
import 'package:hermoso_store/presentation/views/product_grid_item.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/row_of_icons.dart';
import 'package:hermoso_store/presentation/widgets/shimmer_loading.dart';
import 'package:hermoso_store/presentation/widgets/show_snack_bar.dart';
import 'package:hermoso_store/utils/responsive_size.dart';
import 'package:sizer/sizer.dart';

import '../../../data/model/home_model/home_data.dart';
import '../../../data/model/home_model/home_model.dart';
import '../../../domain/cubit/global_cubit/cart/cart_cubit.dart';
import '../../../domain/cubit/global_cubit/products/products_cubit.dart';
import '../../../domain/cubit/global_cubit/settings/settings_cubit.dart';
import '../../../utils/colors.dart';
import '../../views/animated_swiper.dart';
import '../../views/shimmer_list_seperated.dart';
import '../../widgets/custom_widgets/cached_network_image.dart';
import '../../widgets/custom_widgets/custom_action_appbar.dart';
import '../../widgets/custom_widgets/empty_screen.dart';
import '../../widgets/custom_widgets/loading_widget.dart';
import '../../widgets/custom_widgets/search_field.dart';
import '../../widgets/show_dialog.dart';
import 'cart_screen.dart';
import 'notification_screen.dart';
import 'product_details_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen>
    with SnackBarMixin, AlertDialogMixin {
  final TextEditingController _searchController = TextEditingController();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_dataListItem(context).banners.isEmpty) {
      await _productsCubit(context).getBanners();
    }
    if (_dataListItem(context).products.isEmpty) {
      await _productsCubit(context).getProducts();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    if (mounted) super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().actionAppBar(
        isDark: _settingsCubit(context).isDarkMode,
        color: AppColor.kWhiteColor,
        barHeight: 6.h,
        context: context,
        widget: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: SearchField(
            isDark: _settingsCubit(context).isDarkMode,
            controller: _searchController,
            onChanged: (name) => _productsCubit(context).searchProductByName(name),
          ),
        ),
        widget2: BlocBuilder<CartCubit, CartStates>(
          builder: (context, state) => RowOfIcons(
            isDarK: _settingsCubit(context).isDarkMode,
            value: _cartCubit(context).cartItemModel.cartMap.length,
            onPressCart: () => Navigator.pushNamed(context, CartScreen.routeName),
            onPressFavorite: () =>
                Navigator.pushNamed(context, NotificationsScreen.routeName),
          ),
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 1.h),
        Expanded(child: _buildBannersList(context)),
        SizedBox(height: 2.5.h),
        Padding(
          padding: EdgeInsets.only(left: 2.w),
          child: Text(
            'Recent Item',
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: SizeConfig.getScreenHeight(8)),
        Expanded(flex: 3, child: _buildProductsWidget(context)),
      ]),
    );
  }

  BlocConsumer _buildProductsWidget(context) {
    return BlocConsumer<ProductsCubit, ProductsStates>(
      listener: (context, state) {
        if (state is ProductsErrorState) {
          return showSnackBar(context, 'Please Check Your Network Connection');
        }
        if (state is ProductsSuccessChangeFavoriteState) {
          showSnackBar(context, ' Product Added to Favorite');
        }
        if(state is ProductAddedToCartScreenState){
          final val = state.cartMap.entries.toString();
          showSnackBar(context, ' Product $val Added to cart');
        }
      },
      builder: (context, state) {
        if (state is ProductsInitialState) const LoadingWidget();

        if (state is BannersLoadingState) {
          return const ShimmerListSeparated(child: ShimmerLoading());
        }
        return _dataListItem(context).products.isNotEmpty
            ? RefreshIndicator(
                onRefresh: () => _productsCubit(context).getProducts(),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _searchController.text.isEmpty
                      ? _dataListItem(context).products.length
                      : _productsCubit(context).productSearchList.length,
                  padding: EdgeInsets.all(SizeConfig.getScreenWidth(4)),
                  itemBuilder: (context, index) {
                    final product = _dataListItem(context).products[index];
                    return BlocBuilder<CartCubit, CartStates>(
                      builder: (context, state) {
                        return ProductGridItem(
                            cartIcon: product.isInCart
                                ? Icons.shopping_cart
                                : Icons.add_shopping_cart,
                            onPressCart: () => onCartPressed(product, index),
                            onPressFavorite: () => _productsCubit(context)
                                .toggleFavoriteState(product.id),
                            title: _searchController.text.isNotEmpty
                                ? _productsCubit(context).productSearchList[index].name
                                : product.name,
                            price: _searchController.text.isNotEmpty
                                ? _productsCubit(context)
                                    .productSearchList[index]
                                    .price
                                : product.price,
                            oldPrice: _searchController.text.isNotEmpty
                                ? _productsCubit(context)
                                    .productSearchList[index]
                                    .oldPrice
                                : product.oldPrice,
                            networkImage: _searchController.text.isNotEmpty
                                ? _productsCubit(context)
                                    .productSearchList[index]
                                    .image
                                : product.image,
                            favoriteIcon:
                                _productsCubit(context).favoriteMap[product.id] ==
                                        true
                                    ? Icons.star
                                    : Icons.star_border,
                            onGestureTap: () =>
                                navigateToProductDetailsScreen(context, index));
                      },
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 2.4,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8),
                ),
              )
            : const EmptyScreen(text: 'Network occur \nan Error');
      },
    );
  }

  ProductsCubit _productsCubit(context) => BlocProvider.of<ProductsCubit>(context);

  CartCubit _cartCubit(context) => BlocProvider.of<CartCubit>(context);

  HomeData _dataListItem(context) => _productsCubit(context).homeModel.data;

  SettingsCubit _settingsCubit(context) => BlocProvider.of<SettingsCubit>(context);

  Widget _buildBannersList(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsStates>(
      builder: (context, state) {
        if (state is ProductsInitialState) return const LoadingWidget();

        if (state is BannersLoadingState) return const ShimmerLoading();

        if (state is BannersErrorState) {
          return const Center(child: Text('Something Went wrong'));
        }
        return _dataListItem(context).banners.isNotEmpty
            ? AnimationSwiper(
                itemLength: _dataListItem(context).banners.length,
                itemBuilder: (context, index) => CachedImage(
                    imageUrl: '${_dataListItem(context).banners[index].image}'),
              )
            : const EmptyScreen(text: 'Network occur an Error...');
      },
    );
  }

  /// add working great
  void onCartPressed(ProductModel products, index) async {
    await context.read<CartCubit>().toggleCartIcon(products);
     _productsCubit(context).toggleProductCartIcon(index);
    print('cartMap.length from Product screen ${_cartCubit(context).cartItemModel.cartMap.length}');
  }

  void navigateToProductDetailsScreen(context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: _productsCubit(context),
            child: ProductDetails(
              index: index, emptySearchList: _searchController.text.isNotEmpty),
        ),
      ),
    );
  }
}
