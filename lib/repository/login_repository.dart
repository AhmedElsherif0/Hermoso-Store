import 'package:dio/dio.dart';
import 'package:firstdesign/data/service/dio_service.dart';

abstract class LoginRepository {
  Future userLogin(String email, String password);
}

class UserLoginRepository implements LoginRepository {
  @override
  Future<Response> userLogin(String email, String password) async {

   return await DioService.postResponse(
      url: 'login',
      data: {'email': email, 'password': password},
    );
  }
}
