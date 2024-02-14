import 'auth_model.dart';

abstract class AuthBlocState {
  AuthModel authModel;

  AuthBlocState({required this.authModel});
}

class AuthInitState extends AuthBlocState {
  AuthInitState({required AuthModel authModel}) : super(authModel: authModel);
}

class AuthLoadState extends AuthBlocState {
  AuthLoadState({required AuthModel authModel}) : super(authModel: authModel);
}

class AuthAuthorizedState extends AuthBlocState {
  AuthAuthorizedState({required AuthModel authModel})
      : super(authModel: authModel);
}

class AuthUnAuthorizedState extends AuthBlocState {
  AuthUnAuthorizedState({required AuthModel authModel})
      : super(authModel: authModel);
}

class AuthFailureState extends AuthBlocState {
  AuthFailureState({required AuthModel authModel}) : super(authModel: authModel);
}


class UpdateUserState extends AuthBlocState {
  UpdateUserState({required AuthModel authModel}) : super(authModel: authModel);
}

class EditUserState extends AuthBlocState {
  EditUserState({required AuthModel authModel}) : super(authModel: authModel);
}

class CreateUserState extends AuthBlocState {
  CreateUserState({required AuthModel authModel}) : super(authModel: authModel);
}