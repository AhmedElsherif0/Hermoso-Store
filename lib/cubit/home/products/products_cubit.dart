import 'dart:io';

import 'package:hermoso_store/cubit/home/favorite_cubit/favorite_cubit.dart';
import 'package:hermoso_store/model/favorite_model/favorite_model.dart';
import 'package:hermoso_store/model/home_model/home_model.dart';
import 'package:hermoso_store/model/products/product_model.dart';
import 'package:hermoso_store/repository/products_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';


part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepository _productsRepository = MockProductsRepo();

  ProductsCubit() : super(ProductsInitialState());

  static ProductsCubit get(context) => BlocProvider.of(context);

  HomeModel homeModel = HomeModel();
  Map<int?, bool?> favoriteMap = {};
  List<ProductModel> searchedProductList = [];

  void searchProductByName(String name) {
    searchedProductList = homeModel.data.products
        .where((element) => element.name.toLowerCase().startsWith(name))
        .toList();
    emit(ProductsSuccessSearchState());
  }

  Future<void> getBanners() async {
    emit(BannersLoadingState());
    try {
      homeModel = await _productsRepository.getBannersData();
      print('cubit getBanners success ');
      emit(BannersSuccessState(homeModel));
    } on SocketException catch (error) {
      print('socket getProducts error : ${error.toString()}');
      emit(BannersErrorState(error.message));
    } catch (error) {
      print('cubit getBanners error : ${error.toString()}');
      emit(BannersErrorState(error.toString()));
    }
  }

  Future<void> getProducts() async {
    emit(ProductsLoadingState());
    try {
      homeModel = await _productsRepository.getProductsData();
      homeModel.data.products.forEach((element) {
        favoriteMap.addAll({element.id: element.inFavorites});
      });
      print('cubit Favorites  : ${favoriteMap.toString()}');
      emit(ProductsSuccessState(homeModel));
    } on SocketException catch (error) {
      print('cubit getProducts error : ${error.toString()}');
      emit(ProductsErrorState(error.message));
    } catch (error) {
      print('cubit getProducts error : ${error.toString()}');
      emit(ProductsErrorState(error.toString()));
    }
  }

  Future toggleFavoriteState(int? productId) async {
    favoriteMap[productId] = favoriteMap[productId] == false;
    emit(ProductsRestartFavoriteState());
    try {
      FavoriteModel _successData =
          await _productsRepository.postChangeFavorite(productId);
      if (_successData.status == false) {
        print('product cubit change 1 favorite is : ${_successData.message}');
        favoriteMap[productId] = favoriteMap[productId] == false;
        emit(ProductsRestartFavoriteState());
      } else {
        FavoriteCubit().getFavorites();
        emit(ProductsRestartFavoriteState());
      }
      print('product cubit change 2 favorite is : ${_successData.message}');
      emit(ProductsSuccessChangeFavoriteState());
    } on SocketException catch (error) {
      print('socket getProducts error : ${error.toString()}');
      emit(ProductsErrorFavoriteState(error.message));
    } catch (error) {
      favoriteMap[productId] = favoriteMap[productId] == false;
      print('product cubit change favorite error is : ${error.toString()}');
      emit(ProductsErrorFavoriteState(error.toString()));
    }
  }
}
