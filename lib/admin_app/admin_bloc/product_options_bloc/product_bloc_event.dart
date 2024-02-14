import 'package:eGrocer/entity/category.dart';
import 'package:eGrocer/entity/product.dart';

class ProductBlocEvent {}

class InitProductBlocEvent extends ProductBlocEvent {}

class GetProductBlocEvent extends ProductBlocEvent {}

class PicImageBlocEvent extends ProductBlocEvent {}

class MoveUpdatePageEvent extends ProductBlocEvent {
  Product? product;

  MoveUpdatePageEvent({required this.product});
}

class ChangeCategoryEvent extends ProductBlocEvent {
  Category? category;

  ChangeCategoryEvent({required this.category});
}

class AddProductBlocEvent extends ProductBlocEvent {}

class UpdateProductBlocEvent extends ProductBlocEvent {
}

class RemoveProductBlocEvent extends ProductBlocEvent {
  int? id;

  RemoveProductBlocEvent({required this.id});
}
