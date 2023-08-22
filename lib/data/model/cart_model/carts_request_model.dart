
import 'cart_data_model.dart';

class CartsRequestModel {
   bool? status;
  late final CartDataModel cartDataModel;

  CartsRequestModel();

  CartsRequestModel.fromJson(Map<String, dynamic>? json) {
    status = json?['status'];
    cartDataModel =
        (json?["data"] != null ? CartDataModel.fromJson(json?["data"]) : null)!;
  }
}
