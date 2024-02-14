import 'package:eGrocer/user_app/domain/blocs/sort_bloc/sort_bloc.dart';

class SortBlocEvent {}

class InitSortCubitEvent extends SortBlocEvent{}

class SortBySearchBlocEvent extends SortBlocEvent {
  SortState? sortName;
  // String? sortMethod;

  SortBySearchBlocEvent({required this.sortName});
}

class SortByAllProductBlocEvent extends SortBlocEvent {
  SortState? sortName;

  SortByAllProductBlocEvent({required this.sortName});
}
