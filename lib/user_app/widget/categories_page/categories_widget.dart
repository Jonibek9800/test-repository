import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/routes.dart';
import '../../domain/blocs/categories_bloc/categories_bloc.dart';
import '../../domain/blocs/categories_bloc/categories_state.dart';
import '../../domain/blocs/products_bloc/products_bloc.dart';
import '../../domain/blocs/products_bloc/products_bloc_event.dart';
import '../ui/appbar.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF151A20),
      appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight * 2),
          child: AppBarWidget(
            readOnly: true,
            onTap: () {
              Navigator.of(context).pushNamed("/search_page");
            },
            autofocus: false,
            appbarTitle: const Text(
              "Categories",
            ),
            implyLeading: false,
            voiceCallback: () {
              Navigator.of(context).pushNamed(MainNavigationRouteNames.searchPage);
            },
          )),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (BuildContext context, state) {
          final categories = state.categoriesBlocModel.allCategories;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    // color: const Color(0xFF212934),
                    borderRadius: BorderRadius.circular(10)),
                child: GridView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                  ),

                  itemBuilder: (BuildContext context, int index) {
                    final category = categories[index];
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.black26, borderRadius: BorderRadius.circular(5)),
                      child: InkWell(
                        onTap: () {
                          context
                              .read<ProductsBloc>()
                              .add(GetProductByCategoryEvent(categoryId: category.id));
                          Navigator.of(context).pushNamed('/categories/product_by_category');
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: Colors.black26
                          ),
                          child: Column(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: category.posterPath != null
                                  ? CachedNetworkImage(
                                      imageUrl: category.getCategoryImage(),
                                      placeholder: (context, url) =>
                                          const Center(child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                      height: 80,
                                    )
                                  : const Text(""),
                            ),
                            Center(
                              child: Text(
                                category.title ?? '',
                                // style: const TextStyle(color: Colors.white),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
