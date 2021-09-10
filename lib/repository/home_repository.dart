import 'package:hermoso_store/data/service/dio_service.dart';
import 'package:hermoso_store/utils/constants.dart';

abstract class ProductsRepository {
  Future getProductsData();
}

class MockProductsRepo extends ProductsRepository {

  @override
  Future getProductsData() async {
    return   await DioService.getResponse(url:'home',token: token);
  }
}
