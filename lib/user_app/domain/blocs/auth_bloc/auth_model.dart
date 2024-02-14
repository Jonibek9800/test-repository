import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../entity/user.dart';

class AuthModel {
  String? name;
  String? email;
  String? phoneNumber;
  String? password;
  String? confirmPassword;

  User? user;

  File? file;
  ImagePicker image = ImagePicker();

  final editName = TextEditingController(text: "");
  final editEmail = TextEditingController(text: "");
  final editPhoneNumber = TextEditingController(text: "");

  String? errorMessage;
}
