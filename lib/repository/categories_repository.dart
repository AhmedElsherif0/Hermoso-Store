import 'package:dio/dio.dart';
import 'package:hermoso_store/data/service/dio_service.dart';
import 'package:hermoso_store/utils/constants.dart';

import '../model/categories_model/categories_model.dart';

abstract class CategoriesRepository {
  Future<CategoriesModel> getCategories();
}

class MockCategoriesRepo implements CategoriesRepository {
  @override
  Future<CategoriesModel> getCategories() async {
    Response? response = await DioService.getResponse(url:'categories',lang: en);
    CategoriesModel categoriesModel = CategoriesModel.fromJson(response?.data);

    return categoriesModel;


  }
}
