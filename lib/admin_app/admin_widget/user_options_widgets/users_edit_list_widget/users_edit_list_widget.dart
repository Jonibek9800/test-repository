import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../resources/resources.dart';
import '../../../../routes/routes.dart';
import '../../../../user_app/domain/blocs/themes/themes_model.dart';
import '../../../admin_bloc/user_options_bloc/user_bloc.dart';
import '../../../admin_bloc/user_options_bloc/user_bloc_event.dart';
import '../../../admin_bloc/user_options_bloc/user_bloc_state.dart';


class UserEditWidget extends StatelessWidget {
  const UserEditWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit User"),
          centerTitle: true,
        ),
        body: BlocBuilder<UserBloc, UserBlocState>(
            builder: (BuildContext context, state) {
          final userModel = state.userBlocModel;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                child: ListView.builder(
                    itemCount: userModel.users.length,
                    itemBuilder: (context, int index) {
                      final user = userModel.users[index];
                      return Card(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: user.getUserImage() == null
                                  ? Image.asset(
                                      AppImages.person,
                                      height: 150,
                                      width: 100,
                                      fit: BoxFit.fill,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: user.getUserImage() ?? "",
                                      height: 150,
                                      width: 100,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    user.name ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    user.phoneNumber ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    user.email ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                      user.roleOfUserId == 1 ? "user" : "admin")
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   width: 30,
                            // ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Card(
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context,
                                                MainNavigationRouteNames
                                                    .updateUserPage,
                                                arguments: user);
                                            context.read<UserBloc>().add(
                                                GetUpdateUserBlocEvent(
                                                    user: user));
                                            userModel.file = null;
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: ThemeColor.greenColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Card(
                                        child: IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          "Remove User"),
                                                      content: const Text(
                                                          "Are you sure you want to delete this user?"),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              "Cancel"),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            context
                                                                .read<
                                                                    UserBloc>()
                                                                .add(RemoveUserBlocEvent(
                                                                    userId: user
                                                                        .id));
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              const Text("Yes"),
                                                        )
                                                      ],
                                                    );
                                                  });
                                            },
                                            icon: Icon(
                                              Icons.delete_outline,
                                              color: ThemeColor.greenColor,
                                            )),
                                      ),
                                    ]),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
              Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(MainNavigationRouteNames.addUserPage);
                      context.read<UserBloc>().state.userBlocModel.reset();
                    },
                    child: Text(
                      "Create User",
                      style: TextStyle(color: ThemeColor.greenColor),
                    ),
                  )),
            ]),
          );
        }));
  }
}
