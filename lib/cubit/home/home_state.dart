part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final ProductsModel model;

  HomeSuccessState(this.model);
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState(this.message);
}

class HomeNaviBottomBarChange extends HomeState {}
