import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:eGrocer/admin_app/admin_bloc/user_options_bloc/user_bloc_event.dart';
import 'package:eGrocer/admin_app/admin_bloc/user_options_bloc/user_bloc_model.dart';
import 'package:eGrocer/admin_app/admin_bloc/user_options_bloc/user_bloc_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../../entity/user.dart';
import '../../admin_api/user_api.dart';

class UserBloc extends Bloc<UserBlocEvent, UserBlocState> {
  UserBloc()
      : super(InitUserBlocState(
          userBlocModel: UserBlocModel(),
        )) {
    on<GetUserBlocEvent>((event, emit) => onGetUsersEvent(event, emit));
    on<CheckedUserBlocEvent>((event, emit) => onCheckedEvent(event, emit));
    on<CreateUserBlocEvent>((event, emit) => onCreateUser(event, emit));
    on<RemoveUserBlocEvent>((event, emit) => onRemoveUserEvent(event, emit));
    on<GetUpdateUserBlocEvent>((event, emit) => onGetUpdateEvent(event, emit));
    on<GetImagePickBlocEvent>((event, emit) => onGetImageEvent(event, emit));
    on<UpdateUserBlocEvent>((event, emit) => onUpdateUser(event, emit));
  }

  void onGetUsersEvent(GetUserBlocEvent event, Emitter emit) async {
    final currentState = state.userBlocModel;
    try {
      emit(LoadUserBlocState(userBlocModel: currentState));
      final data = await UserApi.getAllUser();
      if (data!.containsKey("error")) {
        debugPrint("error this: ${data['error']}");
      }
      if (data.containsKey('users')) {
        currentState.users =
            (data['users'] as List).map((e) => User.fromJson(e)).toList();
      }
      emit(GetUserBlocState(userBlocModel: currentState));
    } catch (err) {
      debugPrint("error from get users: $err");
    }
  }

  void onCheckedEvent(event, Emitter emit) {
    final currentState = state.userBlocModel;
    currentState.character = event.value;
    emit(CheckedUserRoleBlocState(userBlocModel: currentState));
  }

  void onCreateUser(CreateUserBlocEvent event, Emitter emit) async {
    final current = state.userBlocModel;
    var context = event.context;
    if (!current.globalFormKey.currentState!.validate()) return;
    try {
      emit(LoadUserBlocState(userBlocModel: current));
      current.errorMessage = null;
      final data = await UserApi.createUser(
        poster: current.file,
        name: current.name.text,
        email: current.email.text,
        password: current.password.text,
        phoneNumber: current.phone.text,
        roleId: current.character == SingingCharacter.user ? 1 : 2,
      );
      debugPrint("$data");
      if (data['success'] == false) {
        current.errorMessage = data['message'];
        emit(ErrorUserBlocState(userBlocModel: current));
        return;
      }
      if (data.containsKey('user')) {
        current.users.add(User.fromJson(data['user']));
        current.phone.text = '';
        current.name.text = '';
        current.password.text = '';
        current.email.text = '';
      }
      if (context.mounted) {
        Navigator.pop(context);
      }
      emit(CreateUserBlocState(userBlocModel: current));
    } catch (err) {
      debugPrint("exception create user: $err");
    }
  }

  void onGetUpdateEvent(GetUpdateUserBlocEvent event, Emitter emit) async {
    final current = state.userBlocModel;
    try {
      current.email.text = event.user?.email ?? "";
      current.name.text = event.user?.name ?? "";
      current.phone.text = event.user?.phoneNumber ?? "";
      current.character = event.user?.roleOfUserId == 1
          ? SingingCharacter.user
          : SingingCharacter.admin;
      emit(GetUpdateUserBlocState(userBlocModel: current));
    } catch (err) {
      print(err);
    }
  }

  void onUpdateUser(UpdateUserBlocEvent event, Emitter emit) async {
    final current = state.userBlocModel;
    final userIndex = current.users.indexWhere((element) => element.id == event.user?.id);
    debugPrint("current: ${current.file}");
    final data = await UserApi.updateUser(
      userId: event.user?.id,
      file: current.file,
      email: current.email.text,
      name: current.name.text,
      phoneNumber: current.phone.text,
      password: current.password.text,
      roleId: current.character == SingingCharacter.admin ? 2 : 1,
    );
    current.users[userIndex] = User.fromJson(data['user']);
    emit(UpdateUserBlocState(userBlocModel: current));
    debugPrint("$data");
  }

  void onRemoveUserEvent(event, Emitter emit) async {
    final current = state.userBlocModel;
    await UserApi.removeUser(id: event.userId);
    current.users = current.users.where((e) => e.id != event.userId).toList();
    emit(RemoveUserBlocState(userBlocModel: current));
  }

  void onGetImageEvent(event, Emitter emit) async {
    final currentState = state.userBlocModel;
    var img = await currentState.image.pickImage(source: ImageSource.gallery);
    if (img != null) currentState.file = File(img.path);
    emit(CreateUserBlocState(userBlocModel: currentState));
  }
}
