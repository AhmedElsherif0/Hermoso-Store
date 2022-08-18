import 'package:hermoso_store/model/cart_model/cart_data_model.dart';

class CartsRequestModel {
  bool? status;
  CartDataModel? cartDataModel;

  CartsRequestModel.fromJson(Map<String, dynamic>? json) {
    status = json?['status'];
    cartDataModel =
        (json?["data"] != null ? CartDataModel.fromJson(json?["data"]) : null)!;
  }

}
