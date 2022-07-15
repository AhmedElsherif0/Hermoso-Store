import 'package:hermoso_store/model/auth_model/user_data.dart';

class AuthModel {
  bool? status;
  String? message;
  UserData data = UserData();

  AuthModel();

  AuthModel.fromJson(Map<String, dynamic>? json) {
    status = json?["status"];
    message = json?["message"];
    data = UserData.fromJson(json?["data"]);
  }
}
