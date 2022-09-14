import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/model/categories_model/categories_model.dart';
import '../../../repository/categories_repository.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesStates> {
  final CategoriesRepository _categoriesRepo = MockCategoriesRepo();

  CategoriesCubit() : super(CategoriesInitialState());

  static CategoriesCubit get(context) => BlocProvider.of(context);

  CategoriesModel categoriesModel = CategoriesModel();

  void getCategories() async {
    emit(CategoriesLoadingState());
    try {
      categoriesModel = await _categoriesRepo.getCategories();
      emit(CategoriesSuccessState(categoriesModel));
    } catch (error) {
      emit(CategoriesErrorState(error.toString()));
    }
  }

}
