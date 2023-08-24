import 'package:dio/dio.dart';
import 'package:hermoso_store/domain/repository/cart_repository.dart';
import 'package:hermoso_store/utils/constants.dart';

import '../../data/database/api_service/dio_service.dart';
import '../../data/database/local_data/sqlite_database.dart';
import '../../data/model/cart_model/cart_item_model.dart';
import '../../data/model/favorite_model/favorite_model.dart';
import '../../data/model/home_model/home_model.dart';
import '../../data/model/products/product_model.dart';

abstract class ProductsRepository {
  Future<HomeModel> getProductsData();

  Future<HomeModel> getBannersData();

  Future<FavoriteModel> postChangeFavorite(int? productId);
}

class MockProductsRepo extends ProductsRepository {
  HomeModel _homeModel = HomeModel();

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

}
