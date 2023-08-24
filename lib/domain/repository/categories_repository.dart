import 'package:dio/dio.dart';
import 'package:hermoso_store/utils/constants.dart';

import '../../data/database/api_service/dio_service.dart';
import '../../data/model/categories_model/categories_model.dart';

abstract class CategoriesRepository {
  Future<CategoriesModel> getCategories();
}

class MockCategoriesRepo implements CategoriesRepository {

  @override
  Future<CategoriesModel> getCategories() async {
    Response? response = await DioService.getResponse(url: AppStrings.categories, lang: AppStrings. en);
    CategoriesModel categoriesModel = CategoriesModel.fromJson(response?.data);

    return categoriesModel;
  }
}
