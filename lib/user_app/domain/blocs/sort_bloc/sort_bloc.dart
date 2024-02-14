import 'package:bloc/bloc.dart';
import 'package:eGrocer/user_app/domain/blocs/sort_bloc/sort_bloc_event.dart';
import 'package:eGrocer/user_app/domain/blocs/sort_bloc/sort_bloc_model.dart';
import 'package:eGrocer/user_app/domain/blocs/sort_bloc/sort_bloc_state.dart';

enum SortState { defaultSort, newestFirs, oldestFirst, highToLow, lowToHigh }

class SortBloc extends Bloc<SortBlocEvent, SortBlocState> {
  SortBloc() : super(InitSortCubitState(sortAndListCubitModel: SortCubitModel())) {
    final current = state.sortAndListCubitModel;

    on<SortBySearchBlocEvent>((event, emit) {
      current.sortStateBySearch = event.sortName ?? SortState.defaultSort;
      print(event.sortName);
      emit(SortedBySortCubitState(sortAndListCubitModel: current));
    });
    on<SortByAllProductBlocEvent>((event, emit) {
      current.sortStateByAllProduct = event.sortName ?? SortState.defaultSort;
      emit(SortByAllProductCubitState(sortAndListCubitModel: current));
    });
  }
}
