import 'dart:io';

import 'package:eGrocer/admin_app/admin_bloc/category_options_bloc/category_bloc.dart';
import 'package:eGrocer/admin_app/admin_bloc/category_options_bloc/category_bloc_event.dart';
import 'package:eGrocer/admin_app/admin_bloc/category_options_bloc/category_bloc_state.dart';
import 'package:eGrocer/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCategoryWidget extends StatelessWidget {
  const AddCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Category"),
      ),
      body: BlocBuilder<CategoryBloc, CategoryBlocState>(
          builder: (BuildContext context, state) {
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
                      child: const Text("Add Category"),
                      onPressed: () {
                        context
                            .read<CategoryBloc>()
                            .add(AddCategoryBlocEvent(context: context));
                      },
                    ),
                  ),
                )
              ],
            ));
      }),
    );
  }
}
