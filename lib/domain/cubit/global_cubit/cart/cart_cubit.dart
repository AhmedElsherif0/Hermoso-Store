import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/model/cart_model/cart_item_model.dart';
import '../../../../data/model/products/product_model.dart';
import '../../../repository/cart_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartStates> {
  final CartRepository _cartRepository = MockCartRepo();

  CartCubit() : super(CartInitialState());

  CartItemModel cartItemModel = CartItemModel.custom();
  Map<int, CartItemModel> _cartMap = {};

  Map<int, CartItemModel> get cartMap => _cartMap;

  set cartMap(Map<int, CartItemModel> value) {
    _cartMap = value;
  }


  String cartTable = 'cartTable';

  Future<void> toggleCartIcon(ProductModel productModel, index) async {
    print("remove by product id ${productModel.id}");
    try {
      emit(CartLoadingState());
      if (_cartMap.containsKey(productModel.id)) {
        await removeItem(productModel.id, _cartMap.keys.toList()[index]);
      } else {
        await addToCart(productModel: productModel);
      }
      emit(CartSuccessState());
    } catch (error) {
      emit(CartErrorState(error.toString()));
    }
  }

  Future<Map<int, CartItemModel>> readCart() async {
    try {
      emit(CartLoadingState());
      cartMap = await _cartRepository.readDataBaseRepo();
      emit(CartReadDataBaseState());
    } catch (error) {
      emit(CartErrorState(error.toString()));
    }
    return cartMap;
  }

  Future<Map<int, CartItemModel>> updateQuantity(
      int index, int cartId, bool isUpdated) async {
    try {
      _cartMap = await _cartRepository.updateCartRepo(
          cartId: cartId, isUpdated: isUpdated, index: index);
      emit(CartItemUpdateState());
    } catch (error) {
      emit(CartErrorState(error.toString()));
      print(error.toString());
    }
    return _cartMap;
  }

  Future<void> addToCart({required ProductModel productModel}) async {
    emit(CartLoadingState());
    try {
      _cartMap = await _cartRepository.addToCart(productModel: productModel);
      emit(CartItemAddedToCartScreenState());
    } catch (error) {
      emit(CartErrorState(error.toString()));
    }
  }

  Future<void> clearCartMap() async {
    _cartMap = await _cartRepository.clearCartMapRepo();
    emit(CartItemClearState());
  }

  Future<void> removeItem(int cartId, int index) async {
    try {
      _cartMap = await _cartRepository.removeItemRepo(cartId, index);
      emit(CartItemRemoveState());
    } catch (error) {
      emit(CartErrorState(error.toString()));
    }
  }

  double totalAmountBeforeTaxes() {
    cartItemModel.total = 0.0;
    _cartMap.forEach((key, value) {
      cartItemModel.total += value.price * value.quantity;
    });
    return cartItemModel.total;
  }

  double taxesAmount() {
    cartItemModel.taxes = 0.0;
    cartItemModel.taxes = totalAmountBeforeTaxes() * 14 / 100;
    return cartItemModel.taxes;
  }

  num totalAmount() {
    cartItemModel.total = 0.0;
    cartItemModel.total = totalAmountBeforeTaxes() + taxesAmount();
    return cartItemModel.total;
  }
}
