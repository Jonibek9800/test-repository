import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../resources/resources.dart';
import '../../../routes/routes.dart';
import '../../domain/api_client/auth_api_client.dart';
import '../../domain/blocs/auth_bloc/auth_bloc.dart';
import '../../domain/blocs/auth_bloc/auth_event.dart';
import '../../domain/blocs/auth_bloc/auth_state.dart';
import '../../domain/blocs/cart_blocs/cart_bloc.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_event.dart';
import '../../domain/blocs/themes/themes_bloc.dart';
import '../../domain/blocs/themes/themes_model.dart';
import '../loader_page/loader_view_cubit.dart';

class ProfilePageWidget extends StatelessWidget {
  const ProfilePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF151A20),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Profile",
          // style: TextStyle(color: Colors.white),
        ),
        // backgroundColor: const Color(0xFF212934),
      ),
      body: BlocBuilder<AuthBloc, AuthBlocState>(builder: (BuildContext context, state) {
        final authModel = state.authModel;
        return RefreshIndicator(
          onRefresh: () async => await AuthApiClient().getToken().then((value) {
            debugPrint("value: $value");
          }),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Card(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      // color: const Color(0xFF212934),
                    ),
                    child: InkWell(
                      onTap: () {
                        if (authModel.user != null) {
                          context.read<AuthBloc>().add(EditUserEvent(user: authModel.user));
                          Navigator.of(context).pushNamed(MainNavigationRouteNames.editProfile);
                        } else {
                          Navigator.of(context).pushNamed(MainNavigationRouteNames.loaderWidget);
                        }
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: authModel.file != null
                                  ? Image.file(
                                      authModel.file as File,
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.fill,
                                      // color: Colors.black38,
                                    )
                                  : authModel.user?.getUserImage() == ""
                                      ? Image.asset(AppImages.person)
                                      : CachedNetworkImage(
                                          imageUrl: authModel.user?.getUserImage() ?? "",
                                          errorWidget: (context, error, obj) => const Icon(
                                            Icons.person_outline_rounded,
                                            size: 80,
                                          ),
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.fill,
                                        ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                authModel.user != null ? authModel.user?.name ?? "" : "Welcome!",
                                // style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                authModel.user != null
                                    ? authModel.user?.phoneNumber ?? "No Number"
                                    : "Login",
                                style: const TextStyle(color: Color(0xFF56AE7C)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (authModel.user != null)
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 3,
                      ),
                      children: [
                        Card(
                          child: InkWell(
                            onTap: () {
                              context
                                  .read<CartBloc>()
                                  .add(ChecksByOrderEvent(userId: authModel.user?.id));
                              Navigator.of(context).pushNamed(MainNavigationRouteNames.allOrders);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.list_alt_sharp,
                                  color: ThemeColor.greenColor,
                                  size: 32,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  "All Orders",
                                  // style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_pin,
                                  color: ThemeColor.greenColor,
                                  size: 32,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  "Address",
                                  // style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(MainNavigationRouteNames.cartPage);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_cart,
                                  color: ThemeColor.greenColor,
                                  size: 32,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  "Cart",
                                  // style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                    // Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // children: [
                    //
                    // ],),
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                child: Card(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      // color: const Color(0xFF212934),
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            showBottomSheet(
                                context: context,
                                builder: (_) {
                                  return SizedBox(
                                    // color: const Color(0xFF212934),
                                    height: 180,
                                    child: Scaffold(
                                      appBar: AppBar(
                                        title: const Text("Themes"),
                                        centerTitle: true,
                                      ),
                                      body: const Center(
                                        child: _RadioListThemes(),
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.wallpaper,
                                  color: Color(0xFF56AE7C),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Text(
                                  "Change Theme",
                                  // style: TextStyle(color: Colors.grey),
                                )),
                                Icon(
                                  Icons.arrow_right,
                                  // color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.language,
                                  color: Color(0xFF56AE7C),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Text(
                                  "Change Language",
                                  // style: TextStyle(color: Colors.grey),
                                )),
                                Icon(
                                  Icons.arrow_right,
                                  // color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.contact_phone,
                                  color: Color(0xFF56AE7C),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Text(
                                  "Contact Us",
                                  // style: TextStyle(color: Colors.grey),
                                )),
                                Icon(
                                  Icons.arrow_right,
                                  // color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info,
                                  color: Color(0xFF56AE7C),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Text(
                                  "About Us",
                                  // style: TextStyle(color: Colors.grey),
                                )),
                                Icon(
                                  Icons.arrow_right,
                                  // color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star_border,
                                  color: Color(0xFF56AE7C),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Text(
                                  "Rate Us",
                                  // style: TextStyle(color: Colors.grey),
                                )),
                                Icon(
                                  Icons.arrow_right,
                                  // color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.share,
                                  color: Color(0xFF56AE7C),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Text(
                                  "Share App",
                                  // style: TextStyle(color: Colors.grey),
                                )),
                                Icon(
                                  Icons.arrow_right,
                                  // color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.question_mark,
                                  color: Color(0xFF56AE7C),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Text(
                                  "FAQ",
                                  // style: TextStyle(color: Colors.grey),
                                )),
                                Icon(
                                  Icons.arrow_right,
                                  // color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.list_alt_sharp,
                                  color: Color(0xFF56AE7C),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Text(
                                  "Terms & Conditions",
                                  // style: TextStyle(color: Colors.grey),
                                )),
                                Icon(
                                  Icons.arrow_right,
                                  // color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.privacy_tip_outlined,
                                  color: Color(0xFF56AE7C),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Text(
                                  "Policies",
                                  // style: TextStyle(color: Colors.grey),
                                )),
                                Icon(
                                  Icons.arrow_right,
                                  // color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                        authModel.user != null
                            ? InkWell(
                                onTap: () {
                                  authModel.file = null;
                                  Navigator.of(context)
                                      .pushReplacementNamed(MainNavigationRouteNames.auth);
                                  context.read<AuthBloc>().add(AuthLogoutEvent());
                                  context.read<LoaderViewCubit>().onUnAuthorized();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.logout_outlined,
                                        color: Color(0xFF56AE7C),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                          child: Text(
                                        "Logout",
                                        // style: TextStyle(color: Colors.grey),
                                      )),
                                      Icon(
                                        Icons.arrow_right,
                                        // color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : const Text("")
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

class _RadioListThemes extends StatelessWidget {
  const _RadioListThemes();

  // ThemesState? _character = ThemesState.light;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemesBloc, ThemesBlocState>(builder: (BuildContext context, state) {
      return Column(
        children: <Widget>[
          RadioListTile<ThemesState>(
            // activeColor: Colors.green,
            title: const Text(
              'Light',
              // style: TextStyle(color: Colors.white),
            ),
            value: ThemesState.light,
            groupValue: state.themesModel.currentState,
            onChanged: (value) {
              context.read<ThemesBloc>().add(ThemesLightEvent(value: value));
              Navigator.of(context).pop();
            },
          ),
          RadioListTile<ThemesState>(
            // activeColor: Colors.green,
            title: const Text(
              'Dark',
              // style: TextStyle(color: Colors.white),
            ),
            value: ThemesState.dark,
            groupValue: state.themesModel.currentState,
            onChanged: (ThemesState? value) {
              context.read<ThemesBloc>().add(ThemesLightEvent(value: value));
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }
}
