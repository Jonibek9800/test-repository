import 'categories_bloc_model.dart';

abstract class CategoriesState {
  CategoriesBlocModel categoriesBlocModel;

  CategoriesState({required this.categoriesBlocModel});
}


class InitCategoriesState extends CategoriesState {
  InitCategoriesState({required CategoriesBlocModel categoriesBlocModel}) : super(
      categoriesBlocModel: categoriesBlocModel);

}

class LoadingCategoriesState extends CategoriesState {
  LoadingCategoriesState({required CategoriesBlocModel categoriesBlocModel}) : super(
      categoriesBlocModel: categoriesBlocModel);
}

class ErrorCategoriesState extends CategoriesState {
  ErrorCategoriesState({required CategoriesBlocModel categoriesBlocModel}) : super(
      categoriesBlocModel: categoriesBlocModel);
}