part of 'products_cubit.dart';

@immutable
abstract class ProductsStates {}

class ProductsInitialState extends ProductsStates {}

/// Banners States...
class BannersLoadingState extends ProductsStates {}

class BannersSuccessState extends ProductsStates {
  final HomeModel bannersModel;

  BannersSuccessState(this.bannersModel);
}

class BannersErrorState extends ProductsStates {
  final String? error;

  BannersErrorState(this.error);
}
//***********

/// Products States....
class ProductsLoadingState extends ProductsStates {}

class ProductsSuccessState extends ProductsStates {
  final HomeModel homeModel;

  ProductsSuccessState(this.homeModel);
}

class ProductsErrorState extends ProductsStates {
  final String? error;

  ProductsErrorState(this.error);
}

class ProductsSuccessChangeFavoriteState extends ProductsStates {}
class ProductsCartBadgeState extends ProductsStates {}
class ProductAddedToCartScreenState extends ProductsStates {}
class ProductRemovedFromCartScreenState extends ProductsStates {
  final String? error;

  ProductRemovedFromCartScreenState(this.error);
}

class ProductsSuccessChangeCartState extends ProductsStates {}
class ProductsRemoveAllCartState extends ProductsStates {}

class ProductsRestartFavoriteState extends ProductsStates {}

class ProductsErrorFavoriteState extends ProductsStates {
  final String error;

  ProductsErrorFavoriteState(this.error);
}

class ProductsSuccessSearchState extends ProductsStates {}

class ProductsLoadingSearchState extends ProductsStates {}
//***********


///Favorite States......
class FavoriteSuccessState extends ProductsStates {
  final List<FavoriteList>? favoriteBase;

  FavoriteSuccessState(this.favoriteBase);
}

class FavoriteLoadingState extends ProductsStates {}

class FavoriteErrorState extends ProductsStates {
  final String? error;

  FavoriteErrorState(this.error);
}

class FavoriteNetworkErrorState extends ProductsStates {
  final String? error;

  FavoriteNetworkErrorState(this.error);
}
class FavoriteAddItemState extends ProductsStates {}
class FavoriteRemoveItemState extends ProductsStates {}
class FavoritesSuccessSearchState extends ProductsStates {}
//********
///  Cart States...

class ProductCartAddedToCartScreenState extends ProductsStates {}
class ProductCartLoadingState extends ProductsStates {}