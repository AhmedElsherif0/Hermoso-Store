part of 'categories_cubit.dart';

@immutable
abstract class CategoriesStates {}

class CategoriesInitialState extends CategoriesStates {}
class CategoriesLoadingState extends CategoriesStates {}

class CategoriesSuccessState extends CategoriesStates {
  final CategoriesModel categoriesModel;

  CategoriesSuccessState(this.categoriesModel);
}
class CategoriesErrorState extends CategoriesStates {
  final String error;

  CategoriesErrorState(this.error);
}
