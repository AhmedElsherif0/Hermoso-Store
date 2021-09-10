import 'package:bloc/bloc.dart';
import 'package:hermoso_store/model/home_model/home_model.dart';
import 'package:hermoso_store/ui/screens/home/categories_screen.dart';
import 'package:hermoso_store/ui/screens/home/favorites_screen.dart';
import 'package:hermoso_store/ui/screens/home/products_screen.dart';
import 'package:hermoso_store/ui/screens/home/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {

  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int _currentIndex = 0;

  final List<Widget> _navigationBottomScreens = [
    const ProductsScreen(),
    const FavoritesScreen(),
    const CategoriesScreen(),
    const SettingsScreen(),
  ];

  int get currentIndex => _currentIndex;

  List<Widget> get navigationBottomScreens => _navigationBottomScreens;

  void changeIndex(value) {
    _currentIndex = value;
    emit(HomeNaviBottomBarChange());
  }
}
