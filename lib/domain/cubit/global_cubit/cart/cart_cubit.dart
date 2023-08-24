import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermoso_store/domain/cubit/global_cubit/products/products_cubit.dart';
import 'package:meta/meta.dart';

import '../../../../data/model/cart_model/cart_item_model.dart';
import '../../../../data/model/products/product_model.dart';
import '../../../repository/cart_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialState());

  final CartRepository _cartRepository = MockCartRepo();
  CartItemModel cartItemModel = CartItemModel.custom();

  Future<void> toggleCartIcon(ProductModel productModel) async {
    final isExist = cartItemModel.cartMap.entries.any((element) =>
    element.value.id == productModel.id);
    try {
      if (isExist) {
        await removeCartItem(productModel.id);
        print('cart cubit remove by id toggle item');
      } else {
        cartItemModel.cartMap =
        await _cartRepository.addToCartRepo(productModel: productModel);
        print('cart cubit add toggle ${cartItemModel.cartMap.values.length}');
      }
      cartItemModel.cartMap = await readCart();
      emit(CartItemAddedToCartScreenState());
    } catch (error) {
      emit(CartErrorState(error.toString()));
      print('cart cubit error ${error.toString()} item');
    }
  }

  Future<Map<int, CartItemModel>> readCart() async {
    try {
      emit(CartLoadingState());
      cartItemModel.cartMap = await _cartRepository.readDataBaseRepo();
      emit(CartReadDataBaseState());
    } catch (error) {
      emit(CartErrorState(error.toString()));
      print('cart cubit read error ${error.toString()} item');
    }
    return cartItemModel.cartMap;
  }

  Future<Map<int, CartItemModel>> updateQuantity(int cartId, bool isUpdated) async {
    try {
      cartItemModel.cartMap =
      await _cartRepository.updateCartRepo(cartId: cartId, isUpdated: isUpdated);
      emit(CartItemUpdateState());
    } catch (error) {
      emit(CartErrorState(error.toString()));
      print(error.toString());
    }
    return cartItemModel.cartMap;
  }

  Future<void> clearCartMap() async {
    cartItemModel.cartMap = await _cartRepository.clearCartMapRepo();
    emit(CartItemClearState());
  }

  Future<void> removeCartItem(int cartId) async {
    try {
      await _cartRepository.removeItemRepo(cartId);
      emit(CartItemRemoveState());
    } catch (error) {
      emit(CartErrorState(error.toString()));
      print('cart cubit removeCartItem ${error.toString()} item');
    }
  }

  double totalAmountBeforeTaxes() {
    cartItemModel.total = 0.0;
    cartItemModel.cartMap.forEach((key, value) {
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
