import 'package:dio/dio.dart';
import 'package:firstdesign/data/service/dio_service.dart';

abstract class RegisterRepository {
  Future userRegister(String email, String password,String name, String phone);
}

class UserRegisterRepository implements RegisterRepository {
  @override
  Future<Response> userRegister(
      String email, String password, String name, String phone) async {
    return await DioService.postResponse(
      url: 'register',
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phone' : phone
      },
    );
  }
}
