import '../../domain/blocs/sort_bloc/sort_bloc.dart';

class SortBy {
  String? sortName;
  String? sortMethod;
  String? title;
  SortState? sortState;

  SortBy({
    required this.sortState,
    required this.title,
    required this.sortName,
    required this.sortMethod,
  });

  static List<SortBy> listOfSorts = [
    SortBy(
      sortName: "id",
      sortMethod: "asc",
      sortState: SortState.defaultSort,
      title: 'Default',
    ),
    SortBy(
      sortName: "name",
      sortMethod: "asc",
      sortState: SortState.newestFirs,
      title: 'Newest Firs',
    ),
    SortBy(
        sortName: "name",
        sortMethod: "desc",
        sortState: SortState.oldestFirst,
        title: 'Oldest First'),
    SortBy(
        sortName: "price",
        sortMethod: "asc",
        sortState: SortState.lowToHigh,
        title: 'Price - High to Low'),
    SortBy(
        sortName: "price",
        sortMethod: "desc",
        sortState: SortState.highToLow,
        title: 'Price - Low to High'),
  ];
}
