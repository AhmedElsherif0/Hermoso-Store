import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermoso_store/domain/cubit/global_cubit/cart/cart_cubit.dart';
import 'package:hermoso_store/domain/repository/cart_repository.dart';
import 'package:meta/meta.dart';

import '../../../../data/model/cart_model/cart_item_model.dart';
import '../../../../data/model/favorite_model/favorite_data.dart';
import '../../../../data/model/favorite_model/favorite_datum.dart';
import '../../../../data/model/favorite_model/favorite_model.dart';
import '../../../../data/model/home_model/home_model.dart';
import '../../../../data/model/products/product_model.dart';
import '../../../repository/favorite_repository.dart';
import '../../../repository/products_repository.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsStates> {
  ProductsCubit() : super(ProductsInitialState());

  final ProductsRepository _productsRepository = MockProductsRepo();
  final FavoriteRepository _favoriteRepository = MockFavoriteRepo();
  final CartRepository _cartRepository = MockCartRepo();
  CartItemModel cartItemModel = CartItemModel.custom();

  HomeModel homeModel = HomeModel();
  FavoriteData favoriteData = FavoriteData();
  FavoriteModel _favoriteData = FavoriteModel();
  Map<int?, bool?> favoriteMap = {};
  List<ProductModel> productSearchList = [];

  /// related by favoriteItems Cubit
  List<FavoriteList> favoriteSearchList = [];

//****

  bool _isCartExistByID(ProductModel productModel) =>
      cartItemModel.cartMap.values.any((element) => element.id == productModel.id);

  Future<void> toggleCartIcon(ProductModel productModel) async {
    CartCubit cartCubit = CartCubit();
    if (_isCartExistByID(productModel)) {
      await cartCubit.removeCartItem(productModel.id);
      print('cart cubit remove by id toggle item');
    } else {
      await addToCart(productModel: productModel);
      print('cart cubit add toggle ${cartItemModel.cartMap.values.length}');
    }
    cartItemModel.cartMap = await cartCubit.readCart();
  }

  Future<void> addToCart({required ProductModel productModel}) async {
    emit(ProductCartLoadingState());
    try {
      cartItemModel.cartMap =
          await _cartRepository.addToCartRepo(productModel: productModel);
      emit(ProductAddedToCartScreenState(cartItemModel.cartMap));
    } catch (error) {
      emit(ProductsErrorState(error.toString()));
      print('cart cubit error ${error.toString()} item');
    }
  }

  Future<List<void>> getAllRemoteData() async =>
      await Future.wait([getBanners(), getProducts()]);

  Future<void> getBanners() async {
    emit(BannersLoadingState());
    try {
      homeModel = await _productsRepository.getBannersData();
      print('cubit getBanners success ');
      emit(BannersSuccessState(homeModel));
    } on SocketException catch (error) {
      print('socket getProducts error : ${error.toString()}');
      emit(BannersErrorState(error.message));
    } catch (error) {
      print('cubit getBanners error : ${error.toString()}');
      emit(BannersErrorState(error.toString()));
    }
  }

  Future<void> getProducts() async {
    emit(ProductsLoadingState());
    try {
      homeModel = await _productsRepository.getProductsData();
      _addItemToFavoriteList();
    } on SocketException catch (error) {
      print('cubit getProducts error : ${error.toString()}');
      emit(ProductsErrorState(error.message));
    } catch (error) {
      print('cubit getProducts error : ${error.toString()}');
      emit(ProductsErrorState(error.toString()));
    }
  }

  Future<void> toggleFavoriteState(int? productId) async {
    _restartFavoriteState(productId);
    try {
      _favoriteData = await _productsRepository.postChangeFavorite(productId);
      if (_favoriteData.status == false) {
        print('product cubit change 1 favorite is : ${_favoriteData.message}');
        _restartFavoriteState(productId);
      } else {
        getFavorites();
        emit(ProductsRestartFavoriteState());
      }
      print('product cubit change 2 favorite is : ${_favoriteData.message}');
      emit(ProductsSuccessChangeFavoriteState());
    } on SocketException catch (error) {
      print('socket getProducts error : ${error.toString()}');
      emit(ProductsErrorFavoriteState(error.message));
    } catch (error) {
      favoriteMap[productId] = favoriteMap[productId] == false;
      print('product cubit change favorite error is : ${error.toString()}');
      emit(ProductsErrorFavoriteState(error.toString()));
    }
  }

  bool toggleProductCartIcon(int index) {
    homeModel.data.products[index].isInCart = !homeModel.data.products[index].isInCart;
    emit(ProductsSuccessChangeCartState());
    return homeModel.data.products[index].isInCart;
  }

  void removeAllInCart() {
    homeModel.data.products.any((element) => element.isInCart = false);
    emit(ProductsClearAllCartState());
  }

  /// related by favoriteItems Cubit
  Future<void> getFavorites() async {
    emit(FavoriteLoadingState());
    try {
      favoriteData.favoriteList = await _favoriteRepository.getFavoriteResponse();
      print('get Favorite cubit success is : ${favoriteData.favoriteList.length}');
      emit(FavoriteSuccessState(favoriteData.favoriteList));
    } on SocketException catch (error) {
      emit(FavoriteNetworkErrorState(error.toString()));
    } on HttpException catch (error) {
      emit(FavoriteNetworkErrorState(error.toString()));
    } catch (error) {
      print('Favorite cubit error is : ${error.toString()}');
      emit(FavoriteErrorState(error.toString()));
    }
  }

  void searchProductByName(String name) {
    productSearchList = homeModel.data.products
        .where((element) => element.name.toLowerCase().startsWith(name))
        .toList();
    emit(ProductsSuccessSearchState());
  }

  void searchFavoriteByName(String name) {
    favoriteSearchList = favoriteData.favoriteList
        .where(
            (element) => element.favoriteProduct.name.toLowerCase().startsWith(name))
        .toList();
    emit(FavoritesSuccessSearchState());
  }

  void onPressedFavorite(int index) {
    int productId = favoriteData.favoriteList[index].favoriteProduct.id;
    favoriteMap.containsValue(productId) == false
        ? _removeItemToFavoriteList(productId)
        : _addItemToFavoriteList();
    toggleFavoriteState(favoriteData.favoriteList[index].favoriteProduct.id);
  }

  void _restartFavoriteState(productId) {
    favoriteMap[productId] = favoriteMap[productId] == false;
    emit(ProductsRestartFavoriteState());
  }

  void _removeItemToFavoriteList(Object favoriteItem) {
    favoriteData.favoriteList.remove(favoriteItem);
    emit(FavoriteRemoveItemState());
  }

  void _addItemToFavoriteList() {
    homeModel.data.products.forEach((element) {
      favoriteMap.putIfAbsent(element.id, () => element.inFavorites);
    });
    print('cubit Favorites added  : ${favoriteMap.toString()}');
    emit(FavoriteAddItemState());
  }

  int findCartById(int cartId) =>
      homeModel.data.products.indexWhere((element) => element.id == cartId);
}
