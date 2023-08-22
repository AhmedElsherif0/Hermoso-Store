import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermoso_store/presentation/views/product_card.dart';
import 'package:hermoso_store/presentation/widgets/show_snack_bar.dart';
import 'package:hermoso_store/utils/colors.dart';
import 'package:hermoso_store/utils/responsive_size.dart';
import '../../../domain/cubit/global_cubit/products/products_cubit.dart';
import '../../../domain/cubit/global_cubit/settings/settings_cubit.dart';
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

class _FavoritesScreenState extends State<FavoritesScreen>
    with SnackBarMixin, AlertDialogMixin {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isGetFavorite(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().changeAppAndStatusBarColor(
          isDark: _settingsCubit(context).isDarkMode,
          color: AppColor.kBackColor),
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
              onChanged: (name) =>
                  _productCubit(context).searchFavoriteByName(name),
            ),
            Expanded(
              child: BlocConsumer<ProductsCubit, ProductsStates>(
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
                  return _productCubit(context)
                          .favoriteData
                          .favoriteList
                          .isNotEmpty
                      ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: _searchController.text.isEmpty
                              ? _favoriteList(context).length
                              : _productCubit(context).favoriteMap.length,
                          itemBuilder: (context, index) {
                            final favoriteList =
                                _favoriteList(context)[index].favoriteProduct;
                            return ProductCard(
                              cardIcon: const Icon(null),
                              title: favoriteList.name,
                              oldPrice: favoriteList.oldPrice,
                              price: favoriteList.price,
                              onPressedFavorite: () => _productCubit(context)
                                  .onPressedFavorite(index),
                              image: favoriteList.image,
                              isFavorite: _productCubit(context).favoriteMap[
                                          _favoriteList(context)[index]
                                              .favoriteProduct
                                              .id] ==
                                      true
                                  ? Icons.star
                                  : Icons.star_border,
                            );
                          },
                        )
                      : state is FavoriteNetworkErrorState
                          ? const EmptyScreen(text: 'Network occur an Error...')
                          : const EmptyScreen(text: 'Empty Screen...');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void isGetFavorite(BuildContext context) {
  if (_favoriteList(context).isEmpty) {
    _productCubit(context).getFavorites();
  }
}

_favoriteList(context) {
  return _productCubit(context).favoriteData.favoriteList;
}

ProductsCubit _productCubit(context) {
  return BlocProvider.of<ProductsCubit>(context);
}

SettingsCubit _settingsCubit(context) {
  return BlocProvider.of<SettingsCubit>(context);
}
