import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../../entity/user.dart';


enum SingingCharacter { user, admin }

class UserBlocModel {
  List<User> users = [];
  final globalFormKey = GlobalKey<FormState>();
  String? errorMessage;
  SingingCharacter? character = SingingCharacter.user;

  File? file;
  ImagePicker image = ImagePicker();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();


  void reset() {
    file = null;
    name.text = "";
    email.text = "";
    phone.text = "";
    password.text = "";
  }
}
