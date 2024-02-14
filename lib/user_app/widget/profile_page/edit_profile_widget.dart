import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../resources/resources.dart';
import '../../domain/blocs/auth_bloc/auth_bloc.dart';
import '../../domain/blocs/auth_bloc/auth_event.dart';
import '../../domain/blocs/auth_bloc/auth_state.dart';
import '../main_page/main_page_bloc.dart';

class EditProfileWidget extends StatelessWidget {
  const EditProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthBlocState>(builder: (BuildContext context, state) {
      final authModel = state.authModel;

      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Edit Profile",
            // style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Column(
              children: [
                InkWell(
                  onTap: () {
                    context.read<AuthBloc>().add(GetImageEvent());
                  },
                  child: SizedBox(
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: authModel.file != null
                            ? Image.file(
                                authModel.file as File,
                                fit: BoxFit.fill,
                              )
                            : authModel.user?.getUserImage() == ""
                            ? Image.asset(AppImages.person)
                            :  CachedNetworkImage(
                                imageUrl: authModel.user?.getUserImage() ?? "",
                                errorWidget: (context, error, obj) => const Icon(
                                  Icons.person_outline_rounded,
                                  size: 100,
                                ),
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    // color: const Color(0xFF212934),
                    child: Column(
                      children: [
                        TextField(
                          // style: const TextStyle(color: Colors.white),
                          controller: authModel.editName,
                          // onChanged: (text) => name = text,
                          decoration: const InputDecoration(
                            labelText: "Name",
                            labelStyle: TextStyle(color: Color(0xFF56AE7C)),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          // style: const TextStyle(color: Colors.white),
                          controller: authModel.editEmail,
                          decoration: const InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(color: Color(0xFF56AE7C)),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          keyboardType: TextInputType.phone,
                          // style: const TextStyle(color: Colors.white),
                          controller: authModel.editPhoneNumber,
                          decoration: const InputDecoration(
                            labelText: "Phone Number",
                            labelStyle: TextStyle(color: Color(0xFF56AE7C)),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        authModel.errorMessage != null
                            ? Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    authModel.errorMessage ?? "",
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              )
                            : const Text(""),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: state is AuthLoadState
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : BlocBuilder<MainBloc, MainViewBlocState>(
                                      builder: (BuildContext context, state) {
                                      return OutlinedButton(
                                        onPressed: () {
                                          context.read<AuthBloc>().add(UpdateUserEvent(
                                                userId: authModel.user?.id,
                                                name: authModel.editName.text,
                                                email: authModel.editEmail.text,
                                                phoneNumber: authModel.editPhoneNumber.text,
                                              ));
                                          if (authModel.errorMessage == null) {
                                            Navigator.of(context).pop();
                                          }
                                        },
                                        style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(Color(0xFF56AE7C))),
                                        child: const Text(
                                          "Update",
                                          style: TextStyle(
                                              // color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      );
                                    })),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
