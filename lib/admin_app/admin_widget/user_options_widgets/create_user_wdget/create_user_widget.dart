import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../admin_bloc/user_options_bloc/user_bloc.dart';
import '../../../admin_bloc/user_options_bloc/user_bloc_event.dart';
import '../../../admin_bloc/user_options_bloc/user_bloc_state.dart';
import '../../../ui/my_form.dart';

class CreateUserWidget extends StatelessWidget {
  const CreateUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserBlocState>(
      builder: (BuildContext context, state) {
        final userModel = state.userBlocModel;
        return Scaffold(
            appBar: AppBar(
              title: const Text("Create User"),
              centerTitle: true,
            ),
            body: MyFormWidget(
              onPressedFormButton: () {
                context
                    .read<UserBloc>()
                    .add(CreateUserBlocEvent(context: context));
              },
              userBlocModel: userModel,
              state: state, btnName: 'Create',
            ));
      },
    );
  }
}
