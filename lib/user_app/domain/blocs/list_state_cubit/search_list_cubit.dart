import 'package:bloc/bloc.dart';

enum SearchListCubitState {listView, gridView}

class SearchListCubit extends Cubit<SearchListCubitState> {
  SearchListCubit() : super(SearchListCubitState.listView);

  void toggleGridOrListView() {
    if(state == SearchListCubitState.listView) {
    emit(SearchListCubitState.gridView);
    } else {
      emit(SearchListCubitState.listView);
    }
  }
}