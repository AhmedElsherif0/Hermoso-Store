import 'home_data.dart';

class ProductsModel {
  bool? status;
  bool? message;
  HomeData? data;

  ProductsModel.fromJson(Map<String, dynamic>? json) {
    status = json?["status"];
    message = json?["message"];
    data = json?['data'] != null ? HomeData.fromJson(json?['data']) : null;
  }

}
