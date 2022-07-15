import 'package:hermoso_store/model/categories_model/categories_model.dart';
import 'package:hermoso_store/repository/categories_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesStates> {
  final CategoriesRepository _categoriesRepo = MockCategoriesRepo();

  CategoriesCubit() : super(CategoriesInitialState());

  static CategoriesCubit get(context) => BlocProvider.of(context);

  CategoriesModel categoriesModel = CategoriesModel();

  void getCategories() async {
    emit(CategoriesLoadingState());
    try {
      final successCategories = await _categoriesRepo.getCategories();
      categoriesModel = CategoriesModel.fromJson(successCategories?.data);
      emit(CategoriesSuccessState(categoriesModel));
    } catch (error) {
      emit(CategoriesErrorState(error.toString()));
    }
  }
}
