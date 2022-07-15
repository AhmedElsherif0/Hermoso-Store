import 'package:dio/dio.dart';
import 'package:hermoso_store/data/service/dio_service.dart';
import 'package:hermoso_store/utils/constants.dart';

abstract class CategoriesRepository {
  Future getCategories();
}

class MockCategoriesRepo implements CategoriesRepository {
  @override
  Future<Response?> getCategories() async {
    return await DioService.getResponse(url:'categories',lang: en);
  }
}
