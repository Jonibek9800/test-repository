import 'dart:io';

import 'package:eGrocer/admin_app/admin_bloc/product_options_bloc/product_bloc.dart';
import 'package:eGrocer/admin_app/admin_bloc/product_options_bloc/product_bloc_event.dart';
import 'package:eGrocer/admin_app/admin_bloc/product_options_bloc/product_bloc_state.dart';
import 'package:eGrocer/entity/category.dart';
import 'package:eGrocer/user_app/domain/blocs/themes/themes_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../resources/resources.dart';

class UpdateProductWidget extends StatelessWidget {
  const UpdateProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductBlocState>(builder: (BuildContext context, state) {
      final productModel = state.productBlocModel;
      return Scaffold(
        appBar: AppBar(
          title: const Text("Update Product"),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  context.read<ProductBloc>().add(PicImageBlocEvent());
                },
                child: productModel.file != null
                    ? Image.file(
                        productModel.file as File,
                        height: 250,
                      )
                    : productModel.product?.posterPath != null
                        ? Image.network(
                            productModel.product?.getImage() ?? "",
                            height: 250,
                          )
                        : Image.asset(
                            AppImages.person,
                            height: 250,
                          ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: productModel.name,
                decoration: const InputDecoration(labelText: "name", border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: productModel.price,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "price", border: OutlineInputBorder()),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: PopupMenuButton<String>(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), border: Border.all(color: ThemeColor.greyColor)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Row(
                      children: [
                        Expanded(child: Text("${productModel.category?.title}")),
                        const SizedBox(
                          width: 8,
                        ),
                        const Icon(Icons.arrow_downward)
                      ],
                    ),
                  ),
                ),
                itemBuilder: (BuildContext context) {
                  return productModel.categories.map<PopupMenuItem<String>>((Category value) {
                    return PopupMenuItem<String>(
                      onTap: () {
                        context.read<ProductBloc>().add(ChangeCategoryEvent(category: value));
                      },
                      value: value.title,
                      child: Text(value.title ?? ""),
                    );
                  }).toList();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: productModel.description,
                maxLines: 4,
                decoration: const InputDecoration(labelText: "description", border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: OutlinedButton(
                onPressed: () {
                  context.read<ProductBloc>().add(UpdateProductBlocEvent());
                  Navigator.pop(context);
                },
                child: const Text("Update"),
              ),
            ),
          ],
        ),
      );
    });
  }
}
