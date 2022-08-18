part of 'cart_cubit.dart';

@immutable
abstract class CartStates {}

class CartInitialState extends CartStates {}

class CartLoadingState extends CartStates {}

class CartSuccessState extends CartStates {}
class CartItemUpdateState extends CartStates {}
class CartItemChangeCartIConState extends CartStates {
 final bool isCart ;
  CartItemChangeCartIConState(this.isCart);
}
class CartItemTotalAmountState extends CartStates {}
 class CartItemAddedToCartScreenState extends CartStates {}
class CartItemRemoveState extends CartStates {}
class CartItemClearState extends CartStates {}
class CartReadDataBaseState extends CartStates {

}

class CartErrorState extends CartStates {
  final String error;

  CartErrorState(this.error);
}


