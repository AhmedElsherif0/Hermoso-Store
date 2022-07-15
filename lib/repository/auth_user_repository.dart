import 'package:dio/dio.dart';
import 'package:hermoso_store/data/service/dio_service.dart';
import 'package:hermoso_store/model/auth_model/auth_model.dart';
import 'package:hermoso_store/utils/constants.dart';

import '../data/local_data/shared_preferences.dart';

abstract class AuthUserRepository {
  Future<AuthModel> userLogin(String email, String password);
  Future<AuthModel> userRegister(
      String email, String password, String name, String phone);
}


class MockAuthUserRepo implements AuthUserRepository {

  @override
  Future<AuthModel> userLogin(String email, String password) async {
    AuthModel _authModel =AuthModel();
    Response? _loginResponse = await DioService.postResponse(
        url: 'login', data: {'email': email, 'password': password},lang: en);
    if(_loginResponse!.data != null){
      _authModel = AuthModel.fromJson(_loginResponse.data);
      await SharedPref.saveStringData(
          key: 'token', value: '${_authModel.data.token}');
    }
    return _authModel;
  }

  @override
  Future<AuthModel> userRegister(
      String email, String password, String name, String phone) async {
    Response? registerRequest = await DioService.postResponse(
        url: 'register',
        lang: en,
        data: {
          'email': email,
          'password': password,
          'name': name,
          'phone': phone
        });
    AuthModel _authModel = AuthModel.fromJson(registerRequest?.data);
    await SharedPref.saveStringData(
        key: 'token', value: '${_authModel.data.token}');
    return _authModel;
  }
}
