import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:eGrocer/admin_app/admin_api/category_api.dart';
import 'package:eGrocer/admin_app/admin_api/product_api.dart';
import 'package:eGrocer/admin_app/admin_bloc/product_options_bloc/product_bloc_event.dart';
import 'package:eGrocer/admin_app/admin_bloc/product_options_bloc/product_bloc_model.dart';
import 'package:eGrocer/admin_app/admin_bloc/product_options_bloc/product_bloc_state.dart';
import 'package:eGrocer/entity/category.dart';
import 'package:eGrocer/entity/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ProductBloc extends Bloc<ProductBlocEvent, ProductBlocState> {
  ProductBloc() : super(InitProductBlocState(productBlocModel: ProductBlocModel())) {
    on<GetProductBlocEvent>((event, emit) => onGetProductEven(event, emit));
    on<AddProductBlocEvent>((event, emit) => onAddProductEvent(event, emit));
    on<UpdateProductBlocEvent>((event, emit) => onUpdateEvent(event, emit));
    on<RemoveProductBlocEvent>((event, emit) => onRemoveProductEvent(event, emit));
    on<PicImageBlocEvent>((event, emit) => onGetImageEvent(event, emit));
    on<MoveUpdatePageEvent>((event, emit) => onMoveUpdatePage(event, emit));
    on<ChangeCategoryEvent>((event, emit) => onChangeCategoryEvent(event, emit));
  }

  void onGetProductEven(GetProductBlocEvent event, Emitter emit) async {
    final currentState = state.productBlocModel;
    try {
      final categoryData = await CategoryApi.getAllCategories();
      final productData = await ProductApi.getAllProduct(page: currentState.currentPage);
      if (productData['success'] == false) {
        currentState.errorMessage = "Bad request try again";
      }
      if (categoryData['success'] == true) {
        currentState.categories = (categoryData['categories'] as List).map((e) => Category.fromJson(e)).toList();
      }
      List<Product> listProduct = [];
      if (productData['success'] == true) {
        currentState.totalCount = productData['products']['total'];
        listProduct = (productData['products']['data'] as List).map((e) => Product.fromJson(e)).toList();
      }
      if (currentState.totalCount != currentState.productList.length) {
        currentState.addAndPagination(list: listProduct, pagination: true);
      }
    } catch (err) {
      currentState.errorMessage = "Server error try again";
    }
    emit(GetProductBlocState(productBlocModel: currentState));
  }

  void onAddProductEvent(AddProductBlocEvent event, Emitter emit) async {
    final currentState = state.productBlocModel;
    try {
      final productIndex = currentState.productList.indexWhere((element) => element.id == currentState.product?.id);
      final data = await ProductApi.addProduct(
        poster: currentState.file,
        name: currentState.name.text,
        price: int.tryParse(currentState.price.text),
        description: currentState.description.text,
        categoryId: currentState.category?.id,
      );
      debugPrint("$data");
      currentState.productList[productIndex] = Product.fromJson(data['product']);
      emit(AddProductBlocState(productBlocModel: currentState));
    } catch (err) {
      debugPrint("api error exception: don't add $err");
    }
  }

  void onUpdateEvent(UpdateProductBlocEvent event, Emitter emit) async {
    final current = state.productBlocModel;
    // try {
    final productIndex = current.productList.indexWhere((element) => element.id == current.product?.id);
    // debugPrint("${current.category}");
    final data = await ProductApi.updateProduct(
        id: current.product?.id,
        poster: current.file,
        name: current.name.text,
        price: int.tryParse(current.price.text),
        description: current.description.text,
        categoryId: current.category?.id);
    debugPrint("$data");
    if (data['success'] == true) {
      current.productList[productIndex] = Product.fromJson(data['product']);
      current.reset();
    }
    emit(UpdateProductBlocState(productBlocModel: current));
    // } catch (err) {}
  }

  void onMoveUpdatePage(MoveUpdatePageEvent event, Emitter emit) {
    final current = state.productBlocModel;
    current.product = event.product;
    current.name.text = event.product?.name ?? "";
    current.price.text = (event.product?.price).toString();
    current.description.text = event.product?.description ?? "";

    current.category = current.categories.firstWhereOrNull((element) => element.id == event.product?.categoryId);

    emit(MoveUpdatePageState(productBlocModel: current));
  }

  void onRemoveProductEvent(RemoveProductBlocEvent event, Emitter emit) async {
    final currentState = state.productBlocModel;
    final data = await ProductApi.deleteProduct(id: event.id);

    if (data['success'] == true) {
      debugPrint("${data['message']}");
    }
    currentState.productList = currentState.productList.where((e) => e.id != event.id).toList();
    emit(RemoveProductBlocState(productBlocModel: currentState));
  }

  void onChangeCategoryEvent(ChangeCategoryEvent event, Emitter emit) {
    final currentState = state.productBlocModel;
    currentState.category = event.category;
    emit(ChangeCategoryState(productBlocModel: currentState));
  }

  void onGetImageEvent(event, Emitter emit) async {
    final currentState = state.productBlocModel;
    var img = await currentState.image.pickImage(source: ImageSource.gallery);
    if (img != null) currentState.file = File(img.path);
    emit(GetProductBlocState(productBlocModel: currentState));
  }
}
