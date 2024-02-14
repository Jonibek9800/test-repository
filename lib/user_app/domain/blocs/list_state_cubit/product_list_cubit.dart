import 'package:bloc/bloc.dart';

enum ProductListCubitState {listView, gridView}

class ProductListCubit extends Cubit<ProductListCubitState> {
  ProductListCubit() : super(ProductListCubitState.listView);

  void toggleGridOrListView() {
    if(state == ProductListCubitState.listView) {
      emit(ProductListCubitState.gridView);
    } else {
      emit(ProductListCubitState.listView);
    }
  }
}