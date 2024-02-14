import 'package:flutter/cupertino.dart';

import '../../../entity/user.dart';

class UserBlocEvent {}

class InitUserBlocEvent extends UserBlocEvent {}

class GetUserBlocEvent extends UserBlocEvent {}

class CheckedUserBlocEvent extends UserBlocEvent {
  var value;

  CheckedUserBlocEvent({this.value});
}

class CreateUserBlocEvent extends UserBlocEvent {
  BuildContext context;

  CreateUserBlocEvent({required this.context});
}

class GetUpdateUserBlocEvent extends UserBlocEvent {
  User? user;

  GetUpdateUserBlocEvent({required this.user});
}

class UpdateUserBlocEvent extends UserBlocEvent {
  User? user;

  UpdateUserBlocEvent({required this.user});
}

class RemoveUserBlocEvent extends UserBlocEvent {
  int? userId;

  RemoveUserBlocEvent({required this.userId});
}

class GetImagePickBlocEvent extends UserBlocEvent {}
