import 'package:cached_network_image/cached_network_image.dart';
import 'package:eGrocer/admin_app/admin_bloc/category_options_bloc/category_bloc_event.dart';
import 'package:eGrocer/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../admin_bloc/category_options_bloc/category_bloc.dart';
import '../../../admin_bloc/category_options_bloc/category_bloc_state.dart';

class CategoriesEditListWidget extends StatelessWidget {
  const CategoriesEditListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories Edit List"),
        centerTitle: true,
      ),
      body: BlocBuilder<CategoryBloc, CategoryBlocState>(
          builder: (BuildContext context, state) {
        final categoryModel = state.categoryBlocModel;
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 65),
              child: GridView.builder(
                itemCount: categoryModel.categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 0.7),
                itemBuilder: (context, int index) {
                  final category = categoryModel.categories[index];
                  return Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              height: 100,
                              errorWidget: (fn, str, obj) =>
                                  const Icon(Icons.error_outline_sharp),
                              imageUrl: category.getCategoryImage()),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("${category.title}"),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FloatingActionButton.small(
                              backgroundColor: Colors.black54,
                              heroTag: category.id,
                              onPressed: () {
                                context.read<CategoryBloc>().add(
                                    MoveUpdateBlocEvent(category: category));
                                Navigator.pushNamed(
                                    context,
                                    MainNavigationRouteNames
                                        .updateCategoryPage);
                              },
                              child: const Icon(Icons.create),
                            ),
                            FloatingActionButton.small(
                              backgroundColor: Colors.black54,
                              heroTag: category.title,
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        title: const Text("Remove Category"),
                                        content: const Text(
                                            "Are you sure you want to delete this category?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              context.read<CategoryBloc>().add(
                                                  RemoveCategoryBlocEvent(
                                                      id: category.id));
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Yes"),
                                          )
                                        ],
                                      );
                                    });
                              },
                              child: const Icon(Icons.delete),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Card(
                  child: FloatingActionButton(
                    backgroundColor: Colors.transparent,
                    onPressed: () {
                      Navigator.pushNamed(
                          context, MainNavigationRouteNames.addCategoryPage);
                      context
                          .read<CategoryBloc>()
                          .state
                          .categoryBlocModel
                          .title
                          .text = '';
                    },
                    child: const Text("Add category"),
                  ),
                ))
          ]),
        );
      }),
    );
  }
}
