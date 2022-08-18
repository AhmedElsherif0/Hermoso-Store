import 'package:dio/dio.dart';
import 'package:hermoso_store/data/local_data/shared_preferences.dart';
import 'package:hermoso_store/data/service/dio_service.dart';
import 'package:hermoso_store/model/auth_model/auth_model.dart';
import 'package:hermoso_store/utils/constants.dart';

abstract class SettingsRepository {
  Future<String?> loginOut();

  Future<AuthModel> getProfile();

  Future<AuthModel> updateProfile(String name, String email, String phone);
}

class MockSettingsRepo implements SettingsRepository {
  AuthModel _authModel = AuthModel();

  @override
  Future<String?> loginOut() async {
    token = SharedPref.getData(key: 'token');
    Response? _response = await DioService.postResponse(
        url: 'logout', authorizationToken: token, lang: en);
    _authModel = AuthModel.fromJsonLogout(_response?.data);
    print(
        ' loginOut repository error : ${_authModel.data.token.toString()}');
    await SharedPref.removeData(key: 'token');
    token =null;
    return _authModel.message;
  }

  @override
  Future<AuthModel> getProfile() async {
    token = SharedPref.getData(key: 'token');
    Response? _response = await DioService.getResponse(
        url: 'profile', authorizationToken: token, lang: en);
    if (_response?.data != null) {
      _authModel = AuthModel.fromJson(_response?.data);
      print(
          'settings repository getProfile  : ${_response?.statusMessage.toString()}');
    }
    return _authModel;
  }

  @override
  Future<AuthModel> updateProfile(
      String name, String email, String phone) async {
    token = SharedPref.getData(key: 'token');
    Response? _response = await DioService.putResponse(
        url: 'update-profile',
        lang: en,
        data: {'name': name, 'email': email, 'phone': phone},
        authorizationToken: token);
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
