import 'package:dio/dio.dart';
import 'package:hermoso_store/data/service/dio_service.dart';
import 'package:hermoso_store/model/favorite_model/favorite_model.dart';
import 'package:hermoso_store/model/home_model/home_model.dart';
import 'package:hermoso_store/utils/constants.dart';

abstract class ProductsRepository {
  Future<HomeModel> getProductsData();

  Future<HomeModel> getBannersData();

  Future<FavoriteModel> postChangeFavorite(int? productId);
}

class MockProductsRepo extends ProductsRepository {
  HomeModel _homeModel = HomeModel();

  @override
  Future<HomeModel> getProductsData() async {
    Response? _response = await DioService.getResponse(
        url: 'home', authorizationToken: token, lang: en);
    if (_response?.data != null) _homeModel = HomeModel.fromJson(_response?.data);
    return _homeModel;
  }

  @override
  Future<HomeModel> getBannersData() async {
    Response? _response = await DioService.getResponse(
        url: 'home', authorizationToken: token, lang: en);
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
