import 'package:bloc/bloc.dart';

import 'categories_bloc_model.dart';
import 'categories_event.dart';
import 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc()
      : super(LoadingCategoriesState(
            categoriesBlocModel: CategoriesBlocModel())) {
    on<LoadFromServerEvent>((event, emit) async {
      var currentState = state.categoriesBlocModel;

      try {
        emit(LoadingCategoriesState(categoriesBlocModel: currentState));

        await currentState.getCategories();
        await currentState.getAllCategories();
        emit(InitCategoriesState(categoriesBlocModel: currentState));
      } catch (e) {
        emit(ErrorCategoriesState(categoriesBlocModel: currentState));
      }
    });
  }
}
