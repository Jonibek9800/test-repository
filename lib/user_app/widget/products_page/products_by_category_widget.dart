import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/routes.dart';
import '../../domain/blocs/products_bloc/products_bloc.dart';
import '../../domain/blocs/products_bloc/products_bloc_state.dart';
import '../ui/appbar.dart';
import '../ui/product_page_widget.dart';

class ProductsByCategoryWidget extends StatelessWidget {
  const ProductsByCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight * 2),
            child: AppBarWidget(
              readOnly: true,
              onTap: () {
                Navigator.of(context).pushNamed("/search_page");
              },
              autofocus: false,
              appbarLeading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_outlined),
              ),
              appbarTitle: const Text(
                "Product By Category",
                style: TextStyle(color: Color(0xFF56AE7C)),
              ),
              implyLeading: true,
              voiceCallback: () {
                Navigator.of(context).pushNamed(MainNavigationRouteNames.searchPage);
              },
            )),
        body: BlocBuilder<ProductsBloc, ProductsBlocState>(
          builder: (BuildContext contexts, state) {
            final products = state.productsBlocModel.allProducts;
            return Container(
              // color: const Color(0xFF151A20),
              child: ListView.builder(
                  itemExtent: 160,
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = products[index];
                    return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:    ProductPageWidget(
                          product: product,
                        ));
                  }),
            );
          },
        ));
  }
}
