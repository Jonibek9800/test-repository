import 'package:flutter/cupertino.dart';

abstract class ProductsBlocEvent {}

class GetAllProductsEvent extends ProductsBlocEvent {}

class GetLimitProductEvent extends ProductsBlocEvent {}

class GetProductByCategoryEvent extends ProductsBlocEvent {
  final int? categoryId;

  GetProductByCategoryEvent({required this.categoryId});
}

class GetSearchProductEvent extends ProductsBlocEvent {
  String? sortName;
  String? sortMethod;

  GetSearchProductEvent({
    required this.sortMethod,
    required this.sortName,
  });
}

class GetNextProductPageEvent extends ProductsBlocEvent {
  String? sortName;
  String? sortMethod;

  GetNextProductPageEvent({
    required this.sortMethod,
    required this.sortName,
  });
}

class SpeechToTextControllerEvent extends ProductsBlocEvent {
  String? text;
  String? sortName;
  String? sortMethod;

  SpeechToTextControllerEvent({
    required this.text,
    required this.sortName,
    required this.sortMethod,
  });
}

class SortingProductsEvent extends ProductsBlocEvent {
  ScrollController? scrollController;
  String? sortName;
  String? sortMethod;

  SortingProductsEvent({
    this.scrollController,
    required this.sortName,
    required this.sortMethod,
  });
}

class SortingProductsBySearchEvent extends ProductsBlocEvent {
  ScrollController? scrollController;
  String? sortName;
  String? sortMethod;

  SortingProductsBySearchEvent({
    this.scrollController,
    required this.sortName,
    required this.sortMethod,
  });
}
