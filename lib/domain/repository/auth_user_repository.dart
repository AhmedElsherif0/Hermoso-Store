import 'package:dio/dio.dart';
import 'package:hermoso_store/utils/constants.dart';

import '../../data/database/api_service/dio_service.dart';
import '../../data/database/local_data/shared_preferences.dart';
import '../../data/model/auth_model/auth_model.dart';

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
        url: AppStrings.login,
        data: {'email': email, 'password': password},
        lang: AppStrings.en);
    await _sharedMethod(_loginResponse);
    print('Login User save Prefs  is: ${_authModel.data.token}');
    return _authModel;
  }

  @override
  Future<AuthModel> userRegister(
      String email, String password, String name, String phone) async {
    Response? _registerRequest = await DioService.postResponse(
        url: AppStrings.register,
        lang: AppStrings.en,
        data: {
          'email': email,
          'password': password,
          'name': name,
          'phone': phone,
        });
    await _sharedMethod(_registerRequest);
    print('SignUP save Prefs  is: ${AppStrings.token.toString()}');
    return _authModel;
  }

  Future<void> _sharedMethod(Response? response) async {
    _authModel = AuthModel.fromJson(response!.data);
    await SharedPref.saveStringData(key: 'token', value: _authModel.data.token);
    AppStrings.token = await SharedPref.getData(key: 'token');
  }
}
