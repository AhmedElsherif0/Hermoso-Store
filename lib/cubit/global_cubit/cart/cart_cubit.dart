import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermoso_store/model/cart_model/cart_item_model.dart';
import 'package:hermoso_store/model/products/product_model.dart';
import 'package:hermoso_store/repository/cart_repository.dart';
import 'package:meta/meta.dart';

import '../../../data/local_data/sqlite_database.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartStates> {
  final CartRepository _cartRepository = MockCartRepo();

  CartCubit() : super(CartInitialState());

  List<CartItemModel> cartList = [];
  CartItemModel cartItemModel = CartItemModel.custom();
  Map<int, CartItemModel> _cartMap = {};
  SqliteDatabase _sqliteDatabase = SqliteDatabase();

  Map<int, CartItemModel> get cartMap => _cartMap;

  /* void getCartList() async {
    emit(CartLoadingState());
    try {
      final response = await _cartRepository.getCart();
      print('Cart Cubit Response is ${response.cartDataModel}');
      emit(CartSuccessState());
    } catch (error) {
      print('Cart Cubit error is ${error.toString()}');
      emit(CartErrorState(error.toString()));
    }
  }*/
  void addItem(ProductModel productModel) async {
    emit(CartLoadingState());
    if (cartMap.containsKey(productModel.id)) {
      removeItem(productModel.id);
      await _sqliteDatabase.deleteProduct(
          id: productModel.id, tableName: 'cartTable');
      print('cart cubit item is not : ${productModel.id}');
      emit(CartItemAddedToCartScreenState());
      return;
    } else {
      final cartModel = cartMap.putIfAbsent(
        productModel.id,
        () => CartItemModel(
            id: productModel.id,
            name: productModel.name,
            price: productModel.price,
            oldPrice: productModel.oldPrice,
            image: productModel.image,
            quantity: 1),
      );
      await _sqliteDatabase.insertProduct(
          product: cartModel.toMap(), tableName: 'cartTable');
      print('cart cubit added is : ${productModel.id}');
      emit(CartItemAddedToCartScreenState());
    }
  }

  /// not finished yet
  num totalAmountBeforeTaxes() {
    cartItemModel.total = 0.0;
    _cartMap.forEach((key, value) {
      cartItemModel.total += value.price * value.quantity;
    });
    return cartItemModel.total;
  }

  num taxesAmount() {
    cartItemModel.taxes = 0.0;
    cartItemModel.taxes = totalAmountBeforeTaxes() * 14 / 100;
    return cartItemModel.taxes;
  }

  num totalAmount() {
    cartItemModel.total = 0.0;
    cartItemModel.total = totalAmountBeforeTaxes() + taxesAmount();
    emit(CartItemTotalAmountState());
    return cartItemModel.total;
  }

  Future<List?> readFromDataBase() async {
    final receivedData = await _sqliteDatabase.readTable(table: 'cartTable');
    emit(CartReadDataBaseState());
    return receivedData ;
  }

  void clearCartMap() async {
    _cartMap = {};
    await _sqliteDatabase.deleteAllProduct(tableName: 'cartTable');
    emit(CartItemClearState());
  }

  void removeItem(int cartId) {
    cartMap.remove(cartId);
    emit(CartItemRemoveState());
  }

  void updateQuantity(int cartId, bool isUpdated)  async{
    emit(CartLoadingState());
    _cartMap.update(
      cartId,
      (cartItem) => CartItemModel(
          id: cartItem.id,
          name: cartItem.name,
          price: cartItem.price,
          image: cartItem.image,
          oldPrice: cartItem.oldPrice,
          quantity: isUpdated
              ? (cartItem.quantity == 1 ? 1 : cartItem.quantity - 1)
              : cartItem.quantity + 1),
    );
    emit(CartItemUpdateState());
   await _sqliteDatabase.update(product: cartId, tableName: 'cartTable');
  }
}
