import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/auth_model/auth_model.dart';
import '../../../../data/model/home_model/home_model.dart';
import '../../../../presentation/screens/home/categories_screen.dart';
import '../../../../presentation/screens/home/favorites_screen.dart';
import '../../../../presentation/screens/home/products_screen.dart';
import '../../../../presentation/screens/home/settings_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  AuthModel? authModel;

  int _currentIndex = 0;

  final List _navigationBottomScreens = [
    const ProductsScreen(),
    const FavoritesScreen(),
    const CategoriesScreen(),
    const SettingsScreen(),
  ];

  int get currentIndex => _currentIndex;

  List get navigationBottomScreens => _navigationBottomScreens;

  void changeIndex(value) {
    _currentIndex = value;
    emit(HomeNaviBottomBarChange());
  }
}
