import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../entity/user.dart';
import '../../../admin_bloc/user_options_bloc/user_bloc.dart';
import '../../../admin_bloc/user_options_bloc/user_bloc_event.dart';
import '../../../admin_bloc/user_options_bloc/user_bloc_state.dart';
import '../../../ui/my_form.dart';

class UpdateUserWidget extends StatelessWidget {
  const UpdateUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)?.settings.arguments as User;
    return BlocBuilder<UserBloc, UserBlocState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Update User"),
            centerTitle: true,
          ),
          body: MyFormWidget(
            user: user,
            onPressedFormButton: () {
              context
                  .read<UserBloc>()
                  .add(UpdateUserBlocEvent(user: user));
              Navigator.pop(context);
            },
            userBlocModel: state.userBlocModel,
            state: state,
            btnName: 'Update',
          ),
        );
      },
    );
  }
}
