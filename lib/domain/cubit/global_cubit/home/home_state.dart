part of 'home_cubit.dart';

@immutable
abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSuccessState extends HomeStates {
  final HomeModel model;

  HomeSuccessState(this.model);
}

class HomeErrorState extends HomeStates {
  final String message;

  HomeErrorState(this.message);
}
class HomeUserProfileLoadingState extends HomeStates {}
class HomeUserProfileSuccessState extends HomeStates {
  final AuthModel authModel ;
  HomeUserProfileSuccessState(this.authModel);
}

class HomeNaviBottomBarChange extends HomeStates {}
