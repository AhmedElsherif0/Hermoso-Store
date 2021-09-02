part of 'products_cubit.dart';

@immutable
abstract class ProductsState {}

class ProductsInitialState extends ProductsState {}
class ProductsLoadingState extends ProductsState {}
class ProductsSuccessState extends ProductsState {
  final ProductsModel model;

  ProductsSuccessState(this.model);
}
class ProductsErrorState extends ProductsState {
  final String message;
  ProductsErrorState(this.message);
}
class ProductsChangeState extends ProductsState {}



