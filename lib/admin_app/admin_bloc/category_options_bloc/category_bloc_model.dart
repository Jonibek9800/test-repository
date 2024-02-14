import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../../entity/category.dart';

class CategoryBlocModel {
  List<Category> categories = [];

  final globalFormKey = GlobalKey<FormState>();
  String? errorMessage;

  File? file;
  ImagePicker image = ImagePicker();


  Category? category;
  TextEditingController title = TextEditingController();
}