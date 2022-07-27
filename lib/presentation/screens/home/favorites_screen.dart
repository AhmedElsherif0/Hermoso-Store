import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermoso_store/cubit/home/favorite_cubit/favorite_cubit.dart';
import 'package:hermoso_store/cubit/home/products/products_cubit.dart';
import 'package:hermoso_store/model/favorite_model/favorite_datum.dart';
import 'package:hermoso_store/presentation/views/product_card.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/show_snack_bar.dart';

import 'package:hermoso_store/utils/colors.dart';
import 'package:hermoso_store/utils/responsive_size.dart';

import '../../../cubit/home/settings/settings_cubit.dart';
import '../../widgets/custom_widgets/custom_action_appbar.dart';
import '../../widgets/custom_widgets/empty_screen.dart';
import '../../widgets/custom_widgets/loading_widget.dart';
import '../../widgets/custom_widgets/search_field.dart';
import '../../widgets/show_dialog.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> with ShowSnackBar, ShowAlertMixin {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _favoriteCubit(context).getFavorites();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FavoritesScreen oldWidget) {
    _favoriteCubit(context).getFavorites();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: changeAppAndStatusBarColor(
          isDark: _settingsCubit(context).isDarkMode, color: kBackColor),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.getScreenWidth(9)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeConfig.getScreenHeight(40)),
            Text('Favorite', style: Theme.of(context).textTheme.headline4),
            SizedBox(height: SizeConfig.getScreenHeight(14)),
            SearchField(
              controller: _searchController,
              onChanged: (value) {},
            ),
            Expanded(
                child: BlocConsumer<FavoriteCubit, FavoriteStates>(
              listener: (context, state) {
                if (state is FavoriteErrorState) {
                  return showSnackBar(
                      context, 'Please Check Your Network Connection');
                }
                if (state is FavoriteSuccessState) {
                  return showSnackBar(context, 'Done!');
                }
              },
              builder: (context, state) {
                print('favorite screen builder is : ${state.toString()}');

                if (state is FavoriteLoadingState) {
                  return const LoadingWidget();
                }
                return _favoriteList(context).isEmpty
                    ? state is FavoriteNetworkErrorState
                        ? const EmptyScreen(text: 'Network occur an Error...')
                        : const EmptyScreen(text: 'Empty Screen...')
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: _favoriteList(context).length,
                        itemBuilder: (context, index) => ProductCard(
                          cardIcon:
                              const Icon(Icons.add_shopping_cart_outlined),
                          title: _favoriteList(context)[index]
                              .favoriteProduct
                              .name,
                          oldPrice: _favoriteList(context)[index]
                              .favoriteProduct
                              .oldPrice,
                          price: _favoriteList(context)[index]
                              .favoriteProduct
                              .price,
                          onPressedFavorite: () {
                            _productCubit(context).toggleFavoriteState(
                                _favoriteList(context)[index]
                                    .favoriteProduct
                                    .id);
                            _favoriteCubit(context).getFavorites();
                            if (_productCubit(context).favoriteMap[
                                    _favoriteList(context)[index]
                                        .favoriteProduct
                                        .id] ==
                                true) {
                              _favoriteCubit(context).removeFavoriteItem(
                                  _favoriteList(context)[index].id);
                              _favoriteList(context).removeWhere(
                                  (element) => element.id == false);
                            }
                          },
                          image: _favoriteList(context)[index]
                                  .favoriteProduct
                                  .image ??
                              'assets/product-placeholder.png',
                          isFavorite: _productCubit(context).favoriteMap[
                                      _favoriteList(context)[index]
                                          .favoriteProduct
                                          .id] ==
                                  true
                              ? Icons.star
                              : Icons.star_border,
                        ),
                      );
              },
            )),
          ],
        ),
      ),
    );
  }
}

FavoriteCubit _favoriteCubit(context) {
  return BlocProvider.of<FavoriteCubit>(context);
}

List<FavoriteList> _favoriteList(context) {
  return _favoriteCubit(context).favoriteList;
}

ProductsCubit _productCubit(context) {
  return BlocProvider.of<ProductsCubit>(context);
}

SettingsCubit _settingsCubit(context) {
  return BlocProvider.of<SettingsCubit>(context);
}
