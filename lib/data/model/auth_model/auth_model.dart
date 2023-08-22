
import 'package:hermoso_store/data/model/auth_model/user_data.dart';

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

  AuthModel.fromJsonLogout(Map<String, dynamic>? json) {
    status = json?["status"];
    message = json?["message"];
    data = UserData.fromJsonLogout(json?["data"]);
  }
}
