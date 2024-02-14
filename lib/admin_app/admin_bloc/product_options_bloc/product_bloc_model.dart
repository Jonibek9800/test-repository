import 'dart:io';

import 'package:eGrocer/entity/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../../entity/product.dart';
import '../../../user_app/utils/constans.dart';

class ProductBlocModel {
  List<Product> productList = [];
  String? errorMessage;
  File? file;
  ImagePicker image = ImagePicker();

  Category? category;

  List<Category> categories = [];

  String? categoryName;

  Product? product;
  int? totalCount;
  int currentPage = 1;

  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();

  void addAndPagination({required List<Product> list, bool pagination = false}) {
    if (pagination) {
      productList.addAll(list);
    } else {
      productList = list;
    }
    if (list.length >= Constants.purePage) {
      currentPage += 1;
    }
  }

  void reset(){
    price.text = '';
    name.text = '';
    description.text = '';
    category = null;
    file = null;
  }
}
