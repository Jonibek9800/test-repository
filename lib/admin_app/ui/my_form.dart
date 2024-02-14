import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../entity/user.dart';
import '../../resources/resources.dart';
import '../../user_app/domain/blocs/themes/themes_model.dart';
import '../admin_bloc/user_options_bloc/user_bloc.dart';
import '../admin_bloc/user_options_bloc/user_bloc_event.dart';
import '../admin_bloc/user_options_bloc/user_bloc_model.dart';
import '../admin_bloc/user_options_bloc/user_bloc_state.dart';

class MyFormWidget extends StatelessWidget {
  Function onPressedFormButton;
  UserBlocModel userBlocModel;
  UserBlocState state;
  String btnName;
  User? user;

  MyFormWidget({
    super.key,
    this.user,
    required this.btnName,
    required this.onPressedFormButton,
    required this.userBlocModel,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: userBlocModel.globalFormKey,
      child: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                    onTap: () {
                      context.read<UserBloc>().add(GetImagePickBlocEvent());
                    },
                    child: userBlocModel.file != null
                        ? Image.file(
                            userBlocModel.file as File,
                            height: 150,
                            width: 250,
                          )
                        : user?.getUserImage() != null
                            ? Image.network(
                                user?.getUserImage() ?? "",
                                height: 150,
                                width: 250,
                                fit: BoxFit.fitHeight,
                              )
                            : Image.asset(
                                AppImages.person,
                                height: 150,
                                width: 250,
                                fit: BoxFit.fitHeight,
                              )),
              ),
              userBlocModel.errorMessage != null
                  ? Column(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${userBlocModel.errorMessage}",
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  : const Text(""),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: userBlocModel.name,
                  decoration: const InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (text) {
                    if ((text ?? '').isEmpty) {
                      return "Email cannot be empty";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  controller: userBlocModel.email,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: userBlocModel.phone,
                  decoration: const InputDecoration(
                    labelText: "Phone",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (text) {
                    if ((text ?? '').isEmpty) {
                      return "Password cannot be empty";
                    }
                    return null;
                  },
                  controller: userBlocModel.password,
                  decoration: const InputDecoration(
                    labelText: "password",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      child: RadioListTile<SingingCharacter>(
                        activeColor: ThemeColor.greenColor,
                        title: const Text('user'),
                        value: SingingCharacter.user,
                        groupValue: userBlocModel.character,
                        onChanged: (value) {
                          context
                              .read<UserBloc>()
                              .add(CheckedUserBlocEvent(value: value));
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      child: RadioListTile<SingingCharacter>(
                        activeColor: ThemeColor.greenColor,
                        title: const Text('admin'),
                        value: SingingCharacter.admin,
                        groupValue: userBlocModel.character,
                        onChanged: (value) {
                          context
                              .read<UserBloc>()
                              .add(CheckedUserBlocEvent(value: value));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () => onPressedFormButton(),
                    child: state is LoadUserBlocState
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            btnName,
                            style: TextStyle(color: ThemeColor.greenColor),
                          ))),
          )
        ],
      ),
    );
  }
}
