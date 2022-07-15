import 'dart:io';
import 'package:hermoso_store/model/favorite_model/favorite_datum.dart';
import 'package:hermoso_store/repository/favorite_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteStates> {
  final FavoriteRepository _favoriteRepository = MockFavoriteRepo();

  FavoriteCubit() : super(FavoriteInitialState());

  static FavoriteCubit get(context) => BlocProvider.of(context);

  List<FavoriteList> _favoriteList = [];
  List<FavoriteList>? searchedList =[];

 List<FavoriteList> get favoriteList => _favoriteList;

 void removeFavoriteItem(item){
   favoriteList.remove(item);
   emit(FavoriteRemoveState());
 }

  void getFavorites() async {
    if(_favoriteList.isEmpty){
      emit(FavoriteLoadingState());
    }
    emit(FavoriteChangeState());
    try {
      _favoriteList = await _favoriteRepository.getFavoriteResponse();
      print('get Favorite cubit success is : ${_favoriteList.length}');
      emit(FavoriteSuccessState(_favoriteList));
    } on SocketException catch (error){
      emit(FavoriteNetworkErrorState(error.toString()));
    }on HttpException catch (error){
      emit(FavoriteNetworkErrorState(error.toString()));
    }
    catch (error) {
      print('Favorite cubit error is : ${error.toString()}');
      emit(FavoriteErrorState(error.toString()));
    }
  }
}
