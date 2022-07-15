part of 'products_cubit.dart';

@immutable
abstract class ProductsState {}

class ProductsInitialState extends ProductsState {}

class BannersLoadingState extends ProductsState {}

class BannersSuccessState extends ProductsState {
  final HomeModel bannersModel;

  BannersSuccessState(this.bannersModel);
}

class BannersErrorState extends ProductsState {
  final String? error;

  BannersErrorState(this.error);
}

class ProductsLoadingState extends ProductsState {}

class ProductsSuccessState extends ProductsState {
  final HomeModel productsModel;

  ProductsSuccessState(this.productsModel);
}

class ProductsErrorState extends ProductsState {
  final String? error;

  ProductsErrorState(this.error);
}

class ProductsSuccessChangeFavoriteState extends ProductsState {}
class ProductsRestartFavoriteState extends ProductsState {}

class ProductsErrorFavoriteState extends ProductsState {
  final String error;

  ProductsErrorFavoriteState(this.error);
}
class ProductsSuccessSearchState extends ProductsState {}
class ProductsLoadingSearchState extends ProductsState {}

