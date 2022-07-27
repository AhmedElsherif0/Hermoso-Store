import 'dart:io';

import 'package:hermoso_store/model/home_model/home_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/auth_model/auth_model.dart';
import '../../presentation/screens/home/categories_screen.dart';
import '../../presentation/screens/home/favorites_screen.dart';
import '../../presentation/screens/home/products_screen.dart';
import '../../presentation/screens/home/settings_screen.dart';
import '../../repository/settings_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeStates> {

  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  SettingsRepository settingsRepository = MockSettingsRepo();

  AuthModel? authModel ;

  int _currentIndex = 0;

  final List<Widget> _navigationBottomScreens = [
    const ProductsScreen(),
    const FavoritesScreen(),
    const CategoriesScreen(),
    const SettingsScreen(),
  ];

  int get currentIndex => _currentIndex;

  List<Widget> get navigationBottomScreens => _navigationBottomScreens;

  Future<AuthModel?> getUserProfile() async {
    emit(HomeUserProfileLoadingState());
    try {
      authModel = await settingsRepository.getProfile();
      print('cubit settings status ${authModel?.message}');
      emit(HomeUserProfileSuccessState(authModel!));
    } on SocketException {
      throw Exception('Response Error');
    } catch (error) {
      print('settings cubit error : ${error.toString()}');
      emit(HomeErrorState(error.toString()));
    }
    return authModel;
  }

  void changeIndex(value) {
    _currentIndex = value;
    emit(HomeNaviBottomBarChange());
  }
}
