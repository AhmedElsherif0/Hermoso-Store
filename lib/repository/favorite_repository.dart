import 'package:dio/dio.dart';
import 'package:hermoso_store/model/favorite_model/favorite_base.dart';
import 'package:hermoso_store/model/favorite_model/favorite_datum.dart';
import 'package:hermoso_store/utils/constants.dart';

import '../data/service/dio_service.dart';

abstract class FavoriteRepository {
  Future<List<FavoriteList>> getFavoriteResponse();
}

class MockFavoriteRepo implements FavoriteRepository {

  @override
   Future<List<FavoriteList>> getFavoriteResponse() async {
    Response? successData = await DioService.getResponse(
        url: 'favorites', authorizationToken: token, lang: en);
    FavoriteBase favoriteBase = FavoriteBase.fromJson(successData?.data);
    return favoriteBase.favoriteData.favoriteList;
  }
}
