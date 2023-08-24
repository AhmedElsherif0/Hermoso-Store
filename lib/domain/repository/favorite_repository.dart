import 'package:dio/dio.dart';

import 'package:hermoso_store/utils/constants.dart';

import '../../data/database/api_service/dio_service.dart';
import '../../data/model/favorite_model/favorite_base.dart';
import '../../data/model/favorite_model/favorite_datum.dart';

abstract class FavoriteRepository {
  Future<List<FavoriteList>> getFavoriteResponse();
}

class MockFavoriteRepo implements FavoriteRepository {
  @override
  Future<List<FavoriteList>> getFavoriteResponse() async {
    Response? successData = await DioService.getResponse(
        url: AppStrings.favorites,
        authorizationToken: AppStrings.token,
        lang: AppStrings.en);
    FavoriteBase favoriteBase = FavoriteBase.fromJson(successData?.data);
    return favoriteBase.favoriteData.favoriteList;
  }
}
