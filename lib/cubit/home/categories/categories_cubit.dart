import 'package:bloc/bloc.dart';
import 'package:firstdesign/model/categories_model/categories_model.dart';
import 'package:firstdesign/repository/categories_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  MockCategoriesRepo _categoriesRepo = MockCategoriesRepo();

  CategoriesCubit() : super(CategoriesInitialState());

  static CategoriesCubit get(context) => BlocProvider.of(context);

  void getCategories() async {
    emit(CategoriesLoadingState());
    try {
      final successCategories = await _categoriesRepo.getCategories();
      CategoriesModel _categories =
          CategoriesModel.fromJson(successCategories.data);
      emit(CategoriesSuccessState(_categories));
    } catch (error) {
      emit(CategoriesErrorState(error.toString()));
    }
  }
}
