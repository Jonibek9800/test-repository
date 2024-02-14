import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/blocs/cart_blocs/cart_bloc.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_event.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_state.dart';
import '../../domain/blocs/products_bloc/products_bloc.dart';
import '../../domain/blocs/products_bloc/products_bloc_state.dart';

class AppBarWidget extends StatelessWidget {
  final bool readOnly;
  final VoidCallback onTap;
  final ValueChanged<String>? onChange;
  final bool autofocus;
  final Widget? appbarTitle;
  final Widget? appbarLeading;
  final double? leadingWidth;
  final bool implyLeading;
  final VoidCallback voiceCallback;

  const AppBarWidget(
      {super.key,
      required this.readOnly,
      required this.onTap,
      required this.voiceCallback,
      required this.autofocus,
      this.onChange,
      this.appbarTitle,
      this.appbarLeading,
      this.leadingWidth,
      required this.implyLeading});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartBlocState>(builder: (BuildContext context, state) {
      final currentState = state.cartBlocModel;
      return BlocBuilder<ProductsBloc, ProductsBlocState>(builder: (BuildContext context, state) {
        final productModel = state.productsBlocModel;
        return AppBar(
            leading: appbarLeading,
            automaticallyImplyLeading: implyLeading,
            leadingWidth: leadingWidth,
            // backgroundColor: const Color(0xFF212934),
            // iconTheme: const IconThemeData(color: Colors.white),
            title: appbarTitle,
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    // final user = context.read<AuthBloc>().state.authModel.user;
                    // if(user != null) {
                    Navigator.of(context).pushNamed("/cart_page");
                    context.read<CartBloc>().add(GetProductsByIdEvent());
                    // } else {
                    //   showDialog(context: context, builder: (_) {
                    //     return const AlertDialogWidget();
                    //   });
                    // }
                  },
                  icon: badges.Badge(
                    badgeStyle: const badges.BadgeStyle(
                        badgeGradient: badges.BadgeGradient.linear(colors: [
                      Colors.green,
                      Colors.deepOrange,
                    ])),
                    badgeContent: Text(
                      '${currentState.cartQty()}',
                      // style: const TextStyle(color: Colors.white),
                    ),
                    showBadge: currentState.cartQty() == 0 ? false : true,
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      // color: Color(0xFF56AE7C),
                    ),
                  ),
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          // focusNode: focusNode,
                          controller: productModel.searchController,
                          autofocus: autofocus,
                          readOnly: readOnly,
                          // style: const TextStyle(color: Colors.grey),
                          onTap: onTap,
                          onChanged: onChange,
                          decoration: InputDecoration(
                            filled: true,
                            // fillColor: Colors.black45,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                // color: Colors.grey,
                                style: BorderStyle.none,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(style: BorderStyle.none),
                                borderRadius: BorderRadius.circular(15)),
                            hintText: "Search Producs",
                            // hintStyle: const TextStyle(color: Colors.grey),
                            isCollapsed: true,
                            suffixIcon: const Icon(Icons.search),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: "Listen",
                        onPressed: voiceCallback,
                        icon: const Icon(Icons.keyboard_voice_rounded),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color(0xFF56AE7C)),
                        ),
                        color: Colors.white,
                      ),
                    ],
                  )),
            ));
      });
    });
  }
}
