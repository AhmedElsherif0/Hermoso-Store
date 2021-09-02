import 'home_data.dart';

class ProductsModel {
  bool? _status;
  bool? _message;
  HomeData? _data;

  HomeData? get data => _data;

  set data(HomeData? value) {
    _data = value;
  }

  bool? get status => _status;

  set status(bool? value) {
    _status = value;
  }

  bool? get message => _message;

  set message(bool? value) {
    _message = value;
  }

  ProductsModel.fromJson(Map<String, dynamic>? json) {
    _status = json?["status"];
    _message = json?["message"];
    _data = json?['data'] != null ? HomeData.fromJson(json?['data']) : null;
  }

}
