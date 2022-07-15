import 'package:dio/dio.dart';
import 'package:hermoso_store/data/local_data/shared_preferences.dart';
import 'package:hermoso_store/data/service/dio_service.dart';
import 'package:hermoso_store/model/auth_model/auth_model.dart';
import 'package:hermoso_store/utils/constants.dart';

abstract class SettingsRepository {
  Future<AuthModel> loginOut();

  Future<AuthModel> getProfile();

  Future<AuthModel> updateProfile(String name, String email, String phone);
}

class MockSettingsRepo implements SettingsRepository {
  @override
  Future<AuthModel> loginOut() async {
    token = await SharedPref.getData(key: 'token');
    Response? _response = await DioService.postResponse(
        url: 'logout', authorizationToken: token, lang: en);
    AuthModel _authModel = AuthModel();
    if (_response!.data != null) _authModel = AuthModel.fromJson(_response.data);
    return _authModel;
  }

  @override
  Future<AuthModel> getProfile() async {
    token = await SharedPref.getData(key: 'token');
    Response? response = await DioService.getResponse(
        url: 'profile', authorizationToken: token, lang: en);

    AuthModel authModel = AuthModel();
    if (response?.data != null) authModel = AuthModel.fromJson(response?.data);
    return authModel;
  }

  @override
  Future<AuthModel> updateProfile(
      String name, String email, String phone) async {
    token = await SharedPref.getData(key: 'token');
    Response? response = await DioService.putResponse(
        url: 'update-profile',
        lang: en,
        data: {
          'name': name,
          'email': email, 'phone' : phone},
        authorizationToken: token);
    AuthModel authModel = AuthModel();
    if (response?.data != null) authModel = AuthModel.fromJson(response?.data);
    return authModel;
  }
}
