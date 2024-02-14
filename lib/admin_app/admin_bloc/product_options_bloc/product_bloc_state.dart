import 'package:eGrocer/admin_app/admin_bloc/product_options_bloc/product_bloc_model.dart';

class ProductBlocState {
  ProductBlocModel productBlocModel;

  ProductBlocState({required this.productBlocModel});
}

class InitProductBlocState extends ProductBlocState {
  InitProductBlocState({required ProductBlocModel productBlocModel})
      : super(productBlocModel: productBlocModel);
}

class GetProductBlocState extends ProductBlocState {
  GetProductBlocState({required ProductBlocModel productBlocModel})
      : super(productBlocModel: productBlocModel);
}

class AddProductBlocState extends ProductBlocState {
  AddProductBlocState({required ProductBlocModel productBlocModel})
      : super(productBlocModel: productBlocModel);
}

class MoveUpdatePageState extends ProductBlocState {
  MoveUpdatePageState({required ProductBlocModel productBlocModel})
      : super(productBlocModel: productBlocModel);
}

class ChangeCategoryState extends ProductBlocState {
  ChangeCategoryState({required ProductBlocModel productBlocModel})
      : super(productBlocModel: productBlocModel);
}

class UpdateProductBlocState extends ProductBlocState {
  UpdateProductBlocState({required ProductBlocModel productBlocModel})
      : super(productBlocModel: productBlocModel);
}

class RemoveProductBlocState extends ProductBlocState {
  RemoveProductBlocState({required ProductBlocModel productBlocModel})
      : super(productBlocModel: productBlocModel);
}
