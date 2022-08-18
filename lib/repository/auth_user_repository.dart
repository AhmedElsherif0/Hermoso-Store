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
  AuthModel _authModel = AuthModel();

  @override
  Future<AuthModel> userLogin(String email, String password) async {
    Response? _loginResponse = await DioService.postResponse(
        url: 'login', data: {'email': email, 'password': password}, lang: en);
    await _sharedMethod(_loginResponse);
    print('Login User save Prefs  is: ${_authModel.data.token}');
    return _authModel;
  }

  @override
  Future<AuthModel> userRegister(
      String email, String password, String name, String phone) async {
    Response? _registerRequest =
        await DioService.postResponse(url: 'register', lang: en, data: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
    });
    await _sharedMethod(_registerRequest);
    print('SignUP save Prefs  is: ${token.toString()}');
    return _authModel;
  }

  Future<void> _sharedMethod(Response? response) async {
    _authModel = AuthModel.fromJson(response!.data);
    await SharedPref.saveStringData(key: 'token', value: _authModel.data.token);
    token = await SharedPref.getData(key: 'token');
  }
}
