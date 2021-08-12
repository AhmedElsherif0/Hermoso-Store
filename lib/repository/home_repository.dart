import 'package:firstdesign/data/service/dio_service.dart';
import 'package:firstdesign/utils/constants.dart';

abstract class HomeRepository {
  Future getHomeData();
}

class MockHomeRepository extends HomeRepository {

  @override
  Future getHomeData() async {
    return   await DioService.getResponse(url:'home',token: token);
  }
}
