part of 'categories_cubit.dart';

@immutable
abstract class CategoriesState {}

class CategoriesInitialState extends CategoriesState {}
class CategoriesLoadingState extends CategoriesState {}

class CategoriesSuccessState extends CategoriesState {
  final CategoriesModel categoriesModel;

  CategoriesSuccessState(this.categoriesModel);
}
class CategoriesErrorState extends CategoriesState {
  final String message;

  CategoriesErrorState(this.message);
}
