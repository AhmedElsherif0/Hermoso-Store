import 'package:firstdesign/data/service/dio_service.dart';
import 'package:firstdesign/utils/constants.dart';

abstract class ProductsRepository {
  Future getProductsData();
}

class MockProductsRepo extends ProductsRepository {

  @override
  Future getProductsData() async {
    return   await DioService.getResponse(url:'home',token: token);
  }
}
