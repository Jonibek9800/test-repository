import 'category_bloc_model.dart';

class CategoryBlocState {
  CategoryBlocModel categoryBlocModel;

  CategoryBlocState({required this.categoryBlocModel});
}

class CategoryInitBlocState extends CategoryBlocState {
  CategoryInitBlocState({required CategoryBlocModel categoryBlocModel})
      : super(categoryBlocModel: categoryBlocModel);
}
class GetCategoryBlocState extends CategoryBlocState {
  GetCategoryBlocState({required CategoryBlocModel categoryBlocModel})
      : super(categoryBlocModel: categoryBlocModel);
}

class AddCategoryBlocState extends CategoryBlocState {
  AddCategoryBlocState({required CategoryBlocModel categoryBlocModel})
      : super(categoryBlocModel: categoryBlocModel);
}

class MoveUpdatePageBlocState extends CategoryBlocState {
  MoveUpdatePageBlocState({required CategoryBlocModel categoryBlocModel})
      : super(categoryBlocModel: categoryBlocModel);
}

class UpdateCategoryBlocState extends CategoryBlocState {
  UpdateCategoryBlocState({required CategoryBlocModel categoryBlocModel})
      : super(categoryBlocModel: categoryBlocModel);
}

class RemoveCategoryBlocState extends CategoryBlocState {
  RemoveCategoryBlocState({required CategoryBlocModel categoryBlocModel})
      : super(categoryBlocModel: categoryBlocModel);
}

class ErrorCategoryBlocState extends CategoryBlocState {
  ErrorCategoryBlocState({required CategoryBlocModel categoryBlocModel})
      : super(categoryBlocModel: categoryBlocModel);
}