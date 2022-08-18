import 'package:dio/dio.dart';
import 'package:hermoso_store/data/service/dio_service.dart';
import 'package:hermoso_store/model/cart_model/cart_data_model.dart';
import 'package:hermoso_store/model/cart_model/carts_request_model.dart';
import 'package:hermoso_store/utils/constants.dart';

import '../model/cart_model/cart_item_model.dart';

abstract class CartRepository {
  Future<CartsRequestModel> getCart();

}

class MockCartRepo extends CartRepository {


  @override
  Future<CartsRequestModel> getCart() async {
    Response? response =
        await DioService.getResponse(url: 'carts', authorizationToken: token);
    CartsRequestModel cartsRequestModel =
        CartsRequestModel.fromJson(response?.data);
    print('cart repo response status ${response?.statusCode}');
    return cartsRequestModel;
  }



}
