import 'dart:developer';
import 'package:eGrocer/user_app/domain/blocs/products_bloc/products_bloc_event.dart';
import 'package:eGrocer/user_app/domain/blocs/products_bloc/products_bloc_model.dart';
import 'package:eGrocer/user_app/domain/blocs/products_bloc/products_bloc_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api_client/product_api.dart';
import '../../../../entity/product.dart';

class ProductsBloc extends Bloc<ProductsBlocEvent, ProductsBlocState> {
  late ProductsBlocModel currentState;
  final productsApiClient = ProductApiClient();

  ProductsBloc() : super(InitProductsState(productsBlocModel: ProductsBlocModel())) {
    currentState = state.productsBlocModel;
    on<GetAllProductsEvent>((event, emit) => onAllProductEvent(event, emit));
    on<GetLimitProductEvent>((event, emit) => onLimitProductEvent(event, emit));
    on<GetSearchProductEvent>((event, emit) => onSearchProductEvent(event, emit));
    on<GetProductByCategoryEvent>((event, emit) => onProductByCategoryEvent(event, emit));
    on<GetNextProductPageEvent>((event, emit) => onNextProductPageEvent(event, emit));
    on<SpeechToTextControllerEvent>((event, emit) => onSpeechToTextEvent(event, emit));
    on<SortingProductsEvent>((event, emit) => onSortingProductEvent(event, emit));
    on<SortingProductsBySearchEvent>((event, emit) => onSortingSearchProductEvent(event, emit));
  }

  void onAllProductEvent(event, Emitter emit) async {
    try {
      currentState.allProducts.clear();
      currentState.currentPage = 1;
      emit(GetAllProductsState(productsBlocModel: currentState));
      final response =
          await productsApiClient.getAllProducts(null, currentState.currentPage, 'id', 'asc');
      var productList = (response['data'] as List).map((e) => Product.fromJson(e)).toList();
      log("$productList");
      currentState.addAndPagination(list: productList);
      currentState.totalCount = response['total'];
      emit(GetAllProductsState(productsBlocModel: currentState));
    } catch (e) {
      emit(ErrorProductsState(productsBlocModel: currentState));
    }
  }

  void onLimitProductEvent(event, Emitter emit) async {
    try {
      currentState.limitProducts = [];
      currentState.limitProducts = await productsApiClient.getLimitProducts(8, 'id', 'asc');
      emit(GetLimitProductsState(productsBlocModel: currentState));
    } catch (e) {
      emit(ErrorProductsState(productsBlocModel: currentState));
    }
  }

  void onSearchProductEvent(event, Emitter emit) async {
    try {
      final response = await productsApiClient.getAllProducts(
        currentState.searchController.text,
        null,
        event.sortName,
        event.sortMethod,
      );
      currentState.filteredProducts =
          (response['data'] as List).map((e) => Product.fromJson(e)).toList();
      emit(GetSearchProductsState(productsBlocModel: currentState));
    } catch (e) {
      emit(ErrorProductsState(productsBlocModel: currentState));
    }
  }

  void onProductByCategoryEvent(event, Emitter emit) async {
    try {
      currentState.allProducts = [];
      currentState.allProducts = await productsApiClient.getProductByCategory(event.categoryId);
      emit(GetProductsByCategoryState(productsBlocModel: currentState));
    } catch (e) {
      emit(ErrorProductsState(productsBlocModel: currentState));
    }
  }

  void onNextProductPageEvent(event, Emitter emit) async {
    if (currentState.allProducts.length >= (currentState.totalCount ?? 0)) return;

    final response = await productsApiClient.getAllProducts(
      null,
      currentState.currentPage,
      event.sortName,
      event.sortMethod,
    );
    final allProducts = (response['data'] as List).map((e) => Product.fromJson(e)).toList();

    currentState.addAndPagination(list: allProducts, pagination: true);
    emit(GetNextProductPageState(productsBlocModel: currentState));
  }

  void onSpeechToTextEvent(event, Emitter emit) async {
    currentState.searchController.text = event.text ?? "";
    final response = await productsApiClient.getAllProducts(
      currentState.searchController.text,
      null,
      event.sortName,
      event.sortMethod,
    );
    currentState.filteredProducts = (response['data'] as List).map((e) => Product.fromJson(e)).toList();
    emit(InitProductsState(productsBlocModel: currentState));
  }

  void onSortingProductEvent(event, Emitter emit) async {
    currentState.currentPage = 1;
    final response = await productsApiClient.getAllProducts(
      null,
      currentState.currentPage,
      event.sortName,
      event.sortMethod,
    );
    event.scrollController
        ?.animateTo(0.0, duration: const Duration(seconds: 3), curve: Curves.easeIn);

    currentState.allProducts = (response['data'] as List).map((e) => Product.fromJson(e)).toList();
    emit(GetAllProductsState(productsBlocModel: currentState));
  }

  void onSortingSearchProductEvent(event, Emitter emit) async {
    currentState.currentPage = 1;
    final response = await productsApiClient.getAllProducts(
      null,
      currentState.currentPage,
      event.sortName,
      event.sortMethod,
    );

    currentState.filteredProducts =
        (response['data'] as List).map((e) => Product.fromJson(e)).toList();
    event.scrollController
        ?.animateTo(0.0, duration: const Duration(seconds: 3), curve: Curves.easeIn);
    emit(GetAllProductsState(productsBlocModel: currentState));
  }
}
