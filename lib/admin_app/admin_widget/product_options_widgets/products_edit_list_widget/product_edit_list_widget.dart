import 'package:cached_network_image/cached_network_image.dart';
import 'package:eGrocer/admin_app/admin_bloc/product_options_bloc/product_bloc.dart';
import 'package:eGrocer/admin_app/admin_bloc/product_options_bloc/product_bloc_event.dart';
import 'package:eGrocer/admin_app/admin_bloc/product_options_bloc/product_bloc_state.dart';
import 'package:eGrocer/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../user_app/domain/blocs/themes/themes_model.dart';

class ProductEditListWidget extends StatefulWidget {
  const ProductEditListWidget({super.key});

  @override
  State<ProductEditListWidget> createState() => _ProductEditListWidgetState();
}

class _ProductEditListWidgetState extends State<ProductEditListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        context.read<ProductBloc>().add(GetProductBlocEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductBlocState>(builder: (BuildContext context, listState) {
      final productModel = listState.productBlocModel;
      return Scaffold(
          appBar: AppBar(
            title: const Text("Edit Products"),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 70),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        controller: _scrollController,
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: productModel.productList.length,
                              itemBuilder: (BuildContext context, int index) {
                                final product = productModel.productList[index];
                                return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    child: Card(
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              imageUrl: product.getImage(),
                                              height: 250,
                                              width: 200,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text("${product.name}"),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [const Text("Price:"), Text("\$${product.price}.00")],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Text(
                                              "${product.description}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                OutlinedButton(
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          context, MainNavigationRouteNames.productUpdatePage);
                                                      context.read<ProductBloc>().add(MoveUpdatePageEvent(product: product));
                                                    },
                                                    child: const Row(
                                                      children: [
                                                        Text("Edit"),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Icon(Icons.edit)
                                                      ],
                                                    )),
                                                OutlinedButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (_) {
                                                            return AlertDialog(
                                                              title: const Text("Remove Product"),
                                                              content: const Text(
                                                                  "Are you sure you want to delete this product?"),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: const Text("Cancel"),
                                                                ),
                                                                TextButton(
                                                                  onPressed: () {
                                                                    context.read<ProductBloc>().add(
                                                                        RemoveProductBlocEvent(id: product.id));
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: const Text("Yes"),
                                                                )
                                                              ],
                                                            );
                                                          });
                                                    },
                                                    child: const Row(
                                                      children: [
                                                        Text("Delete"),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Icon(Icons.delete)
                                                      ],
                                                    ))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ));
                              }),
                          if (productModel.productList.length < (productModel.totalCount ?? 0))
                            Center(
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: ThemeColor.greenColor,
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(bottom: 0, left: 0, right: 0,
                  child: Card(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(onPressed: () {
                      productModel.reset();
                      Navigator.pushNamed(context, MainNavigationRouteNames.productAddPage);
                    }, child: const Text("Add Product"),),
                  )))
            ]
          ));
    });
  }
}
