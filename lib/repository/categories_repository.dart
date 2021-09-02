import 'package:dio/dio.dart';
import 'package:firstdesign/data/service/dio_service.dart';

abstract class CategoriesRepository {
  Future getCategories();
}

class MockCategoriesRepo implements CategoriesRepository {
  @override
  Future<Response> getCategories() async {
    return await DioService.postResponse(url:'categories');
  }
}
