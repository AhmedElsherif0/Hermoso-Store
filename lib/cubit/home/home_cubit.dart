import 'package:bloc/bloc.dart';
import 'package:firstdesign/data/service/dio_service.dart';
import 'package:firstdesign/model/home_model/home_model.dart';
import 'package:firstdesign/repository/home_repository.dart';
import 'package:firstdesign/ui/screens/home/categories_screen.dart';
import 'package:firstdesign/ui/screens/home/favorites_screen.dart';
import 'package:firstdesign/ui/screens/home/products_screen.dart';
import 'package:firstdesign/ui/screens/home/settings_screen.dart';
import 'package:firstdesign/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepository _homeRepository = MockHomeRepository();

  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int _currentIndex = 0;

  List<Widget> _navigationBottomScreens = [
    ProductsScreen(),
    FavoritesScreen(),
    CategoriesScreen(),
    SettingsScreen(),
  ];

  int get currentIndex => _currentIndex;

  List<Widget> get navigationBottomScreens => _navigationBottomScreens;

  void changeIndex(value) {
    _currentIndex = value;
    emit(HomeNaviBottomBarChange());
  }

  Future<void> getData() async {
    emit(HomeLoadingState());
    try {
      final successData = await _homeRepository.getHomeData();
      HomeModel _homeModel = HomeModel.fromJson(successData.data);

      emit(HomeSuccessState(_homeModel));
    } catch (error) {
      print(' cubit error is : ${error.toString()}');
      emit(HomeErrorState(error.toString()));
    }
  }
}
