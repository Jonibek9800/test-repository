import 'package:eGrocer/user_app/domain/blocs/products_bloc/products_bloc_model.dart';

abstract class ProductsBlocState {
  final ProductsBlocModel productsBlocModel;

  ProductsBlocState({required this.productsBlocModel});
}

class InitProductsState extends ProductsBlocState {
  InitProductsState({required ProductsBlocModel productsBlocModel})
      : super(productsBlocModel: productsBlocModel);
}

class GetAllProductsState extends ProductsBlocState {
  GetAllProductsState({required ProductsBlocModel productsBlocModel})
      : super(productsBlocModel: productsBlocModel);
}

class GetLimitProductsState extends ProductsBlocState {
  GetLimitProductsState({required ProductsBlocModel productsBlocModel})
      : super(productsBlocModel: productsBlocModel);
}

class GetSearchProductsState extends ProductsBlocState {
  GetSearchProductsState({required ProductsBlocModel productsBlocModel})
      : super(productsBlocModel: productsBlocModel);
}


class GetProductsByCategoryState extends ProductsBlocState {
  GetProductsByCategoryState({required ProductsBlocModel productsBlocModel})
      : super(productsBlocModel: productsBlocModel);
}

class ErrorProductsState extends ProductsBlocState {
  ErrorProductsState({required ProductsBlocModel productsBlocModel})
      : super(productsBlocModel: productsBlocModel);
}


class GetNextProductPageState extends ProductsBlocState {
  GetNextProductPageState({required ProductsBlocModel productsBlocModel})
      : super(productsBlocModel: productsBlocModel);
}