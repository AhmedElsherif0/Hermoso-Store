import 'package:dio/dio.dart';
import 'package:hermoso_store/utils/constants.dart';

import '../../data/database/api_service/dio_service.dart';
import '../../data/database/local_data/shared_preferences.dart';
import '../../data/model/auth_model/auth_model.dart';

abstract class SettingsRepository {
  Future<String?> loginOut();

  Future<AuthModel> getProfile();

  Future<AuthModel> updateProfile(String name, String email, String phone);
}

class MockSettingsRepo implements SettingsRepository {
  AuthModel _authModel = AuthModel();

  @override
  Future<String?> loginOut() async {
    AppStrings.token = SharedPref.getData(key: 'token');
    Response? _response = await DioService.postResponse(
        url: AppStrings.logout,
        authorizationToken: AppStrings.token,
        lang: AppStrings.en);
    _authModel = AuthModel.fromJsonLogout(_response?.data);
    print(' loginOut repository error : ${_authModel.data.token.toString()}');
    await SharedPref.removeData(key: 'token');
    AppStrings.token = null;
    return _authModel.message;
  }

  @override
  Future<AuthModel> getProfile() async {
    AppStrings.token = SharedPref.getData(key: 'token');
    Response? _response = await DioService.getResponse(
        url: 'profile', authorizationToken: AppStrings.token, lang: AppStrings.en);
    if (_response?.data != null) {
      _authModel = AuthModel.fromJson(_response?.data);
      print(
          'settings repository getProfile  : ${_response?.statusMessage.toString()}');
    }
    return _authModel;
  }

  @override
  Future<AuthModel> updateProfile(String name, String email, String phone) async {
    AppStrings.token = SharedPref.getData(key: 'token');
    Response? _response = await DioService.putResponse(
        url: 'update-profile',
        lang: AppStrings.en,
        data: {'name': name, 'email': email, 'phone': phone},
        authorizationToken: AppStrings.token);
    if (_response?.data != null) {
      _authModel = AuthModel.fromJson(_response?.data);
      if (_authModel.status = true) {
        _authModel.data.name = name;
        _authModel.data.email = email;
        _authModel.data.phone = phone;
      }
      print(
          ' settings repository updateProfile  error : ${_response?.statusMessage.toString()}');
    }
    return _authModel;
  }
}
