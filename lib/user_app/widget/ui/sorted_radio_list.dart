import 'package:eGrocer/user_app/widget/ui/sort_by.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/blocs/products_bloc/products_bloc.dart';
import '../../domain/blocs/products_bloc/products_bloc_event.dart';
import '../../domain/blocs/sort_bloc/sort_bloc.dart';
import '../../domain/blocs/sort_bloc/sort_bloc_event.dart';
import '../../domain/blocs/sort_bloc/sort_bloc_state.dart';

class SortedRadioList extends StatelessWidget {
  SortedRadioList({
    super.key,
    required this.scrollController,
    required this.sortedPageName,
  });

  String? sortedPageName = '';
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SortBloc, SortBlocState>(
        builder: (BuildContext context, state) {
      return ListView.builder(
        // controller: scrollController,

        shrinkWrap: true,
        itemCount: SortBy.listOfSorts.length,
        itemBuilder: (context, index) {
          final sortBy = SortBy.listOfSorts[index];
          return RadioListTile<SortState?>(
            // activeColor: Colors.green,
            title: Text(
              sortBy.title ?? '',
            ),
            value: sortBy.sortState,
            groupValue: sortedPageName == 'search'
                ? state.sortAndListCubitModel.sortStateBySearch
                : state.sortAndListCubitModel.sortStateByAllProduct,
            onChanged: (value) {
              if (sortedPageName == 'search') {
                context.read<SortBloc>().add(SortBySearchBlocEvent(
                      sortName: value,
                    ));
                context.read<ProductsBloc>().add(SortingProductsBySearchEvent(
                    sortName: sortBy.sortName,
                    sortMethod: sortBy.sortMethod,
                    scrollController: scrollController));
              } else if (sortedPageName == 'product') {
                context
                    .read<SortBloc>()
                    .add(SortByAllProductBlocEvent(sortName: value));
                context.read<ProductsBloc>().add(SortingProductsEvent(
                    sortName: sortBy.sortName,
                    sortMethod: sortBy.sortMethod,
                    scrollController: scrollController));
              }

              Navigator.of(context).pop();
            },
          );
        },
      );
    });
  }
}
