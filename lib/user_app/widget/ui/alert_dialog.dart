import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/routes.dart';
import '../loader_page/loader_view_cubit.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text(
        "Oops! You need to login first to add items into cart!",
        // style: TextStyle(color: Color(0xFF56AE7C)),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Cansel",
              style: TextStyle(color: Color(0xFF56AE7C)),
            )),
        TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(MainNavigationRouteNames.auth);
              context.read<LoaderViewCubit>().onUnAuthorized();
            },
            child: const Text(
              "OK",
              // style: TextStyle(color: Color(0xFF56AE7C)),
            ))
      ],
      elevation: 24,
    );
  }
}
