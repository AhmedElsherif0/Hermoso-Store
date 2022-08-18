
import 'package:hermoso_store/model/cart_model/cart_item_model.dart';

class CartDataModel{

  List<CartItemModel>? cartItemModel ;
  num? subTotal;
  num? total;

  CartDataModel.fromJson(Map<String,dynamic>? json){
    cartItemModel = json?['cart_items'];
    subTotal = json?['sub_total'];
    total = json?['total'];
  }
}