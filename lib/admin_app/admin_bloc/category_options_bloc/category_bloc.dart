import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:eGrocer/user_app/domain/blocs/categories_bloc/categories_bloc.dart';
import 'package:eGrocer/user_app/domain/blocs/categories_bloc/categories_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../entity/category.dart';
import '../../admin_api/category_api.dart';
import 'category_bloc_event.dart';
import 'category_bloc_model.dart';
import 'category_bloc_state.dart';

class CategoryBloc extends Bloc<CategoryBlocEvent, CategoryBlocState> {
  CategoryBloc()
      : super(CategoryInitBlocState(categoryBlocModel: CategoryBlocModel())) {
    on<GetCategoryBlocEvent>((event, emit) => onGetCategoryEvent(event, emit));
    on<AddCategoryBlocEvent>((event, emit) => onAddCategoryEvent(event, emit));
    on<GetCategoryImageBlocEvent>(
        (event, emit) => onGetImageEvent(event, emit));
    on<RemoveCategoryBlocEvent>(
        (event, emit) => onRemoveCategoryEvent(event, emit));
    on<MoveUpdateBlocEvent>((event, emit) => onMoveUpdatePage(event, emit));
    on<UpdateCategoryBlocEvent>((event, emit) => onUpdateCategoryEvent(event, emit));
  }

  void onGetCategoryEvent(GetCategoryBlocEvent event, Emitter emit) async {
    final current = state.categoryBlocModel;
    try {
      final data = await CategoryApi.getAllCategories();
      if (data.containsKey("categories")) {
        current.categories = (data['categories'] as List)
            .map((e) => Category.fromJson(e))
            .toList();
      }
      emit(GetCategoryBlocState(categoryBlocModel: current));
    } catch (err) {
      debugPrint("Error in the get categories from admin");
    }
  }

  void onAddCategoryEvent(AddCategoryBlocEvent event, Emitter emit) async {
    final current = state.categoryBlocModel;

    var context = event.context;
    if (!current.globalFormKey.currentState!.validate()) return;
    try {
      // debugPrint("${current.file?.path.split(".").last}");
      // return;
      current.errorMessage = null;
      final data = await CategoryApi.addCategory(
        poster: current.file,
        name: current.title.text,
      );
      if (data['success'] == false) {
        current.errorMessage = data['message'];
        emit(ErrorCategoryBlocState(categoryBlocModel: current));
        return;
      }
      current.categories.add(Category.fromJson(data['category']));
      current.title.text = '';
      current.file = null;

      emit(AddCategoryBlocState(categoryBlocModel: current));
      if (context.mounted) {
        context.read<CategoriesBloc>().add(LoadFromServerEvent());
        Navigator.pop(context);
      }
    } catch (err) {
      debugPrint("exception create category: $err");
    }
  }

  void onMoveUpdatePage(MoveUpdateBlocEvent event, Emitter emit) {
    final current = state.categoryBlocModel;

    current.title.text = event.category.title ?? "";
    current.category = event.category;

    emit(MoveUpdatePageBlocState(categoryBlocModel: current));
  }

  void onUpdateCategoryEvent(
      UpdateCategoryBlocEvent event, Emitter emit) async {
    final current = state.categoryBlocModel;
    final categoryIndex = current.categories
        .indexWhere((element) => element.id == current.category?.id);
    var context = event.context;

    final data = await CategoryApi.updateCategory(
      id: current.category?.id,
      poster: current.file,
      name: current.title.text,
    );
    debugPrint("$data");
    if (data['success'] == true) {
      current.categories[categoryIndex] = Category.fromJson(data['category']);
      current.file = null;
      current.title.text = '';
    }
    emit(UpdateCategoryBlocState(categoryBlocModel: current));
    if (context.mounted) {
      context.read<CategoriesBloc>().add(LoadFromServerEvent());
      Navigator.pop(context);
    }
  }

  void onRemoveCategoryEvent(
      RemoveCategoryBlocEvent event, Emitter emit) async {
    final current = state.categoryBlocModel;
    current.categories =
        current.categories.where((element) => element.id != event.id).toList();
    final data = await CategoryApi.deleteCategory(id: event.id);
    debugPrint("${data['message']}");
    emit(RemoveCategoryBlocState(categoryBlocModel: current));
  }

  void onGetImageEvent(event, Emitter emit) async {
    final currentState = state.categoryBlocModel;
    var img = await currentState.image.pickImage(source: ImageSource.gallery);
    if (img != null) currentState.file = File(img.path);
    emit(GetCategoryBlocState(categoryBlocModel: currentState));
  }
}
