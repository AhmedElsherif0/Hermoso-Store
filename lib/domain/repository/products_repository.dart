import 'package:dio/dio.dart';
import 'package:hermoso_store/utils/constants.dart';

import '../../data/database/api_service/dio_service.dart';
import '../../data/database/local_data/sqlite_database.dart';
import '../../data/model/cart_model/cart_item_model.dart';
import '../../data/model/favorite_model/favorite_model.dart';
import '../../data/model/home_model/home_model.dart';
import '../../data/model/products/product_model.dart';

abstract class ProductsRepository {
  Future<HomeModel> getProductsData();

  Future<Map<int, CartItemModel>> addToCartRepo({required ProductModel productModel});

  Future<HomeModel> getBannersData();

  Future<FavoriteModel> postChangeFavorite(int? productId);
}

class MockProductsRepo extends ProductsRepository {
  HomeModel _homeModel = HomeModel();
  final SqliteDatabase _sqliteDatabase = SqliteDatabase();
  CartItemModel cartItemModel = CartItemModel.custom();

  @override
  Future<HomeModel> getProductsData() async {
    Response? _response =
        await DioService.getResponse(url: 'home', authorizationToken: token, lang: en);
    if (_response?.data != null) _homeModel = HomeModel.fromJson(_response?.data);
    return _homeModel;
  }

  @override
  Future<HomeModel> getBannersData() async {
    Response? _response =
        await DioService.getResponse(url: 'home', authorizationToken: token, lang: en);
    if (_response?.data != null) _homeModel = HomeModel.fromJson(_response?.data);
    return _homeModel;
  }

  @override
  Future<FavoriteModel> postChangeFavorite(int? productId) async {
    Response? _response = await DioService.postResponse(
        url: 'favorites',
        authorizationToken: token,
        lang: en,
        data: {'product_id': productId});
    FavoriteModel _favoriteModel = FavoriteModel();
    if (_response?.data != null) {
      _favoriteModel = FavoriteModel.fromJson(_response?.data);
    }
    return _favoriteModel;
  }

  @override
  Future<Map<int, CartItemModel>> addToCartRepo(
      {required ProductModel productModel}) async {
    if (!cartItemModel.cartMap.containsKey(productModel.id)) {
      CartItemModel cartModel = cartItemModel.cartMap.putIfAbsent(
          productModel.id,
          () => CartItemModel(
              id: productModel.id,
              name: productModel.name,
              price: productModel.price,
              oldPrice: productModel.oldPrice,
              image: productModel.image,
              quantity: 1));
      print('Cart Cubit cartMap added ${cartItemModel.cartMap} ');
      await _sqliteDatabase.insertProduct(
          product: cartModel, tableName: _sqliteDatabase.cartTableName);
    }
    return cartItemModel.cartMap;
  }
}
