import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../../entity/slider.dart';

class SliderBlocModel {
  List<Slider> posterList = [];

  String? errorMessage;

  File? file;
  ImagePicker image = ImagePicker();
}