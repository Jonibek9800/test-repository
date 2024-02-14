import '../../../../entity/user.dart';

abstract class AuthBlocEvent {}

class AuthLoadEvent extends AuthBlocEvent {}

class AuthLogoutEvent extends AuthBlocEvent {}

class AuthLoginEvent extends AuthBlocEvent {}

class AuthAuthorizedEvent extends AuthBlocEvent {
  final String? login;
  final String? password;

  AuthAuthorizedEvent({required this.login, required this.password});
}

class UpdateUserEvent extends AuthBlocEvent {
  final int? userId;
  final String? name;
  final String? email;
  final String? phoneNumber;

  UpdateUserEvent({
    required this.userId,
    this.name,
    this.email,
    this.phoneNumber,
  });
}

class EditUserEvent extends AuthBlocEvent {
  final User? user;

  EditUserEvent({required this.user});
}

class CreateUserEvent extends AuthBlocEvent {
  String? name;
  String? email;
  String? phoneNumber;
  String? password;
  String? confirmPassword;

  CreateUserEvent({
    required this.name,
    required this.email,
    this.phoneNumber,
    required this.password,
    required this.confirmPassword,
  });
}


class GetImageEvent extends AuthBlocEvent {

}

