import 'package:flutter/material.dart';

import '../../../entity/category.dart';

class CategoryBlocEvent {}

class GetCategoryBlocEvent extends CategoryBlocEvent {}

class AddCategoryBlocEvent extends CategoryBlocEvent {
  BuildContext context;

  AddCategoryBlocEvent({required this.context});
}

class MoveUpdateBlocEvent extends CategoryBlocEvent {
  Category category;

  MoveUpdateBlocEvent({required this.category});
}

class UpdateCategoryBlocEvent extends CategoryBlocEvent {
  BuildContext context;

  UpdateCategoryBlocEvent({required this.context});
}

class RemoveCategoryBlocEvent extends CategoryBlocEvent {
  int? id;

  RemoveCategoryBlocEvent({required this.id});
}

class GetCategoryImageBlocEvent extends CategoryBlocEvent {}
