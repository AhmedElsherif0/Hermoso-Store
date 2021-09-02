import 'package:bloc/bloc.dart';
import 'package:firstdesign/model/home_model/home_model.dart';
import 'package:firstdesign/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsRepository _productsRepository = MockProductsRepo();

  ProductsCubit() : super(ProductsInitialState());

  static ProductsCubit get(context) => BlocProvider.of(context);

  Future<void> getData() async {
    emit(ProductsLoadingState());
    try {
      final successData = await _productsRepository.getProductsData();
      ProductsModel _productsModel = ProductsModel.fromJson(successData.data);
      emit(ProductsSuccessState(_productsModel));
    } catch (error) {
      print(' cubit error is : ${error.toString()}');
      emit(ProductsErrorState(error.toString()));
    }
  }

  bool isFavorite = false;

 /* bool  changeFavorite() {
    if (isFavorite) {
      isFavorite = !isFavorite;
      emit(ProductsChangeState());
    }
    else {
      isFavorite = !isFavorite;
      emit(ProductsChangeState());
    }
    return isFavorite;
  }*/
}
