import 'home_data.dart';

class HomeModel {
  bool? status;
  String? message;
  HomeData data = HomeData();

  HomeModel();

  HomeModel.fromJson(Map<String, dynamic>? json) {
    status = json?["status"];
    message = json?["message"];
    data = (json?['data'] != null ? HomeData.fromJson(json?['data']) : null)!;
  }

}
