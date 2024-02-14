import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../resources/resources.dart';
import '../../../admin_bloc/category_options_bloc/category_bloc.dart';
import '../../../admin_bloc/category_options_bloc/category_bloc_event.dart';
import '../../../admin_bloc/category_options_bloc/category_bloc_state.dart';

class UpdateCategoryWidget extends StatelessWidget {
  const UpdateCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Category"),
      ),
      body: BlocBuilder<CategoryBloc, CategoryBlocState>(
          builder: (BuildContext context, state) {
        // final category = ModalRoute.of(context)?.settings.arguments;
        final categoryModel = state.categoryBlocModel;
        return Form(
            key: categoryModel.globalFormKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    context
                        .read<CategoryBloc>()
                        .add(GetCategoryImageBlocEvent());
                  },
                  child: categoryModel.file != null
                      ? Image.file(
                          categoryModel.file as File,
                          height: 250,
                        )
                      : categoryModel.category?.posterPath != null
                          ? Image.network(
                              categoryModel.category?.getCategoryImage() ?? "",
                              height: 250,
                            )
                          : Image.asset(
                              AppImages.person,
                              height: 250,
                            ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: categoryModel.title,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      child: const Text("Update Category"),
                      onPressed: () {
                        context
                            .read<CategoryBloc>()
                            .add(UpdateCategoryBlocEvent(context: context));
                      },
                    ),
                  ),
                )
              ],
            ));
      }),
    );
    ;
  }
}
