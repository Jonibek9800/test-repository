import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/routes.dart';
import '../../domain/blocs/auth_bloc/auth_bloc.dart';
import '../../domain/blocs/auth_bloc/auth_event.dart';
import '../../domain/blocs/auth_bloc/auth_state.dart';
import 'auth_cubit.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  static double getLoginHeight(BuildContext context) {
    late double phoneHeight;
    if (MediaQuery.of(context).size.width < 600) {
      phoneHeight = MediaQuery.of(context).size.height;
    } else {
      phoneHeight = MediaQuery.of(context).size.width;
    }
    return phoneHeight;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthBlocState>(
      listener: (BuildContext context, AuthBlocState state) =>
          _onAuthViewCubitStateChange(state, context),
      child: Scaffold(
          body: ListView(
              children: [
        BlocBuilder<AuthViewCubit, AuthViewCubitState>(
            builder: (BuildContext context, state) {
          return Container(
              height: getLoginHeight(context),
              color: const Color(0xFF151A20),
              child: state == AuthViewCubitState.registration
                  ? const _RegisterWidget()
                  : const _LoginWidget());
        }),
      ])),
    );
  }
}

void _onAuthViewCubitStateChange(AuthBlocState state, BuildContext context) {
  if (state is AuthAuthorizedState) {
    Routes.resetNavigation(context);
  }
}

class _RegisterWidget extends StatelessWidget {
  const _RegisterWidget();

  // final AuthModel authModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthBlocState>(
        builder: (BuildContext context, state) {
      final authModel = state.authModel;
      return Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'eGrocer',
              style: TextStyle(
                  color: Color(0xFF56AE7C),
                  fontSize: 56,
                  fontWeight: FontWeight.w600),
            ),
            Form(
                child: DecoratedBox(
              decoration: BoxDecoration(
                // color: const Color(0xFF212934),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Welcome!",
                      // style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    const Text(
                      "Enter your name phone number email and password to register",
                      maxLines: 2,
                      // style: TextStyle(color: Color(0xFF8E9093)),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    TextField(
                      // style: const TextStyle(color: Color(0xFFffffff)),
                      // key: phoneNumKey,
                      // controller: phoneNumberInput,
                      onChanged: (text) => authModel.name = text,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              // color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        labelText: "Name",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        isCollapsed: true,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      // style: const TextStyle(color: Color(0xFFffffff)),
                      // key: phoneNumKey,
                      // controller: phoneNumberInput,
                      onChanged: (text) => authModel.email = text,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              // color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        labelText: "Email",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        isCollapsed: true,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      // style: const TextStyle(color: Color(0xFFffffff)),
                      // key: phoneNumKey,
                      // controller: phoneNumberInput,
                      onChanged: (text) => authModel.phoneNumber = text,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              // color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        labelText: "Phone number",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        isCollapsed: true,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      // style: const TextStyle(color: Color(0xFFffffff)),
                      // key: phoneNumKey,
                      // controller: phoneNumberInput,
                      onChanged: (text) => authModel.password = text,
                      textAlignVertical: TextAlignVertical.center,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              // color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        labelText: "Password",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        isCollapsed: true,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      // style: const TextStyle(color: Color(0xFFffffff)),
                      // key: phoneNumKey,
                      // controller: phoneNumberInput,
                      onChanged: (text) => authModel.confirmPassword = text,
                      textAlignVertical: TextAlignVertical.center,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              // color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        labelText: "Confirm password",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        isCollapsed: true,
                      ),
                    ),
                    if (authModel.errorMessage != null) ...[
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        authModel.errorMessage ?? "",
                        style: const TextStyle(color: Colors.red, fontSize: 17),
                      ),
                    ],
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: const Color(0xFF56AE7C),
                          value: true,
                          onChanged: (value) {},
                        ),
                        const Expanded(
                            child: Text(
                          "I Agree to the Terms of Service and Privacy Police",
                          maxLines: 2,
                          style: TextStyle(
                            // color: Colors.white,
                            fontSize: 14,
                          ),
                        ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFF56AE7C))),
                            onPressed: () {
                              context.read<AuthBloc>().add(CreateUserEvent(
                                  name: authModel.name,
                                  email: authModel.email,
                                  phoneNumber: authModel.phoneNumber,
                                  password: authModel.password,
                                  confirmPassword: authModel.confirmPassword));
                            },
                            child: state is AuthLoadState
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : const Text(
                                    "Registration",
                                    // style: TextStyle(color: Colors.white),
                                  )),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed("/");
                            },
                            child: const Text(
                              "Skip Login",
                              style: TextStyle(color: Color(0xFF56AE7C)),
                            )),
                        TextButton(
                            onPressed: () {
                              context.read<AuthViewCubit>().onLoginState();
                            },
                            child: const Text(
                              "Login Page",
                              style: TextStyle(color: Color(0xFF56AE7C)),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      );
    });
  }
}

class _LoginWidget extends StatelessWidget {
  const _LoginWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthBlocState>(
        builder: (BuildContext context, state) {
      final authModel = state.authModel;
      return Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'eGrocer',
              style: TextStyle(
                  color: Color(0xFF56AE7C),
                  fontSize: 56,
                  fontWeight: FontWeight.w600),
            ),
            Form(
                child: DecoratedBox(
              decoration: BoxDecoration(
                // color: const Color(0xFF212934),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Welcome!",
                      style: TextStyle(
                        // color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    const Text(
                      "Enter your name phone number email and password to register",
                      maxLines: 2,
                      // style: TextStyle(color: Color(0xFF8E9093)),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    TextField(
                      // style: const TextStyle(color: Color(0xFFffffff)),
                      onChanged: (text) => authModel.email = text,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              // color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        labelText: "Email",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        isCollapsed: true,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      // style: const TextStyle(color: Color(0xFFffffff)),
                      onChanged: (text) => authModel.password = text,
                      textAlignVertical: TextAlignVertical.center,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              // color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        labelText: "Password",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        isCollapsed: true,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (authModel.errorMessage != null) ...[
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        authModel.errorMessage ?? "",
                        style: const TextStyle(color: Colors.red, fontSize: 17),
                      ),
                    ],
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: const Color(0xFF56AE7C),
                          value: true,
                          onChanged: (value) {},
                        ),
                        const Expanded(
                            child: Text(
                          "I Agree to the Terms of Service and Privacy Police",
                          maxLines: 2,
                          style: TextStyle(
                            // color: Colors.white,
                            fontSize: 14,
                          ),
                        ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFF56AE7C))),
                            onPressed: () {
                              context.read<AuthBloc>().add(AuthAuthorizedEvent(
                                  login: authModel.email,
                                  password: authModel.password));
                              // Navigator.of(context).pushNamed("/");
                            },
                            child: state is AuthLoadState
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : const Text(
                                    "LOGIN",
                                    // style: TextStyle(color: Colors.white),
                                  )),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed("/");
                            },
                            child: const Text(
                              "Skip Login",
                              style: TextStyle(color: Color(0xFF56AE7C)),
                            )),
                        TextButton(
                            onPressed: () {
                              context.read<AuthViewCubit>().onRegistrationState();
                            },
                            child: const Text(
                              "Registration Page",
                              style: TextStyle(color: Color(0xFF56AE7C)),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      );
    });
  }
}
