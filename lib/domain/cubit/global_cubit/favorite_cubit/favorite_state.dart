part of 'favorite_cubit.dart';

abstract class FavoriteStates {}

class FavoriteInitialState extends FavoriteStates {}

class FavoriteLoadingState extends FavoriteStates {}

class FavoriteSuccessState extends FavoriteStates {
  final List<FavoriteList>? favoriteBase;
  FavoriteSuccessState(this.favoriteBase);
}

class FavoriteErrorState extends FavoriteStates {
  final String? error;
  FavoriteErrorState(this.error);
}
class FavoriteNetworkErrorState extends FavoriteStates {
  final String? error;
  FavoriteNetworkErrorState(this.error);
}
class FavoriteChangeState extends FavoriteStates {}
