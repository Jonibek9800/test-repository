import 'package:eGrocer/admin_app/admin_bloc/user_options_bloc/user_bloc_model.dart';

class UserBlocState {
  UserBlocModel userBlocModel;

  UserBlocState({required this.userBlocModel});
}

class InitUserBlocState extends UserBlocState {
  InitUserBlocState({required UserBlocModel userBlocModel})
      : super(
          userBlocModel: userBlocModel,
        );
}

class ErrorUserBlocState extends UserBlocState {
  ErrorUserBlocState({required UserBlocModel userBlocModel})
      : super(
    userBlocModel: userBlocModel,
  );
}

class LoadUserBlocState extends UserBlocState {
  LoadUserBlocState({required UserBlocModel userBlocModel})
      : super(
          userBlocModel: userBlocModel,
        );
}

class GetUserBlocState extends UserBlocState {
  GetUserBlocState({required UserBlocModel userBlocModel})
      : super(
          userBlocModel: userBlocModel,
        );
}

class CheckedUserRoleBlocState extends UserBlocState {
  CheckedUserRoleBlocState({required UserBlocModel userBlocModel})
      : super(
          userBlocModel: userBlocModel,
        );
}

class CreateUserBlocState extends UserBlocState {
  CreateUserBlocState({required UserBlocModel userBlocModel})
      : super(
          userBlocModel: userBlocModel,
        );
}

class GetUpdateUserBlocState extends UserBlocState {
  GetUpdateUserBlocState({required UserBlocModel userBlocModel})
      : super(
    userBlocModel: userBlocModel,
  );
}

class UpdateUserBlocState extends UserBlocState {
  UpdateUserBlocState({required UserBlocModel userBlocModel})
      : super(
    userBlocModel: userBlocModel,
  );
}

class RemoveUserBlocState extends UserBlocState {
  RemoveUserBlocState({required UserBlocModel userBlocModel})
      : super(
          userBlocModel: userBlocModel,
        );
}
