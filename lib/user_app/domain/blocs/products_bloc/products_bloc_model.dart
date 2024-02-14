import 'package:flutter/material.dart';

import '../../../utils/constans.dart';
import '../../api_client/product_api.dart';
import '../../../../entity/product.dart';

class ProductsBlocModel {
  final productsApiClient = ProductApiClient();
  FocusNode focusNode = FocusNode();

  // List<Product> productByCategory = [];
  List<Product> allProducts = [];
  List<Product> limitProducts = [];
  List<Product> filteredProducts = [];
  int currentPage = 1;
  int? totalCount = 0;

  TextEditingController searchController = TextEditingController();

  // void getNextPage(int index) async {
  //
  // }

  void addAndPagination({required List<Product> list, bool pagination = false}) {
    if(pagination) {
      allProducts.addAll(list);
    } else {
      allProducts = list;
    }
    if(list.length >= Constants.purePage) {
      currentPage += 1;
    }
  }
}
