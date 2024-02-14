import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../routes/routes.dart';
import '../../domain/blocs/cart_blocs/cart_bloc.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_event.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_state.dart';
import '../../domain/blocs/themes/themes_model.dart';

class OrdersWidget extends StatelessWidget {
  const OrdersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartBlocState>(
        builder: (BuildContext context, state) {
      final checks = state.cartBlocModel.checks;
      return Scaffold(
        appBar: AppBar(
          title: const Text("Orders"),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: checks.length,
            itemBuilder: (BuildContext context, int index) {
              final check = checks[index];
              final formatDate = DateTime.parse(check.createdAt ?? "");
              final data = DateFormat.yMd().format(formatDate);
              // final data = (check.createdAt as String).substring(0, 10);
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Order #${check.id}"),
                            TextButton(
                                onPressed: () {
                                  context.read<CartBloc>().add(
                                      CheckDetailsByOrderEvent(
                                          details: check));
                                  Navigator.of(context).pushNamed(
                                      MainNavigationRouteNames.orderDetails);
                                },
                                child: const Row(
                                  children: [
                                    Text("View details"),
                                    Icon(Icons.arrow_right)
                                  ],
                                ))
                          ],
                        ),
                      ),
                      const Divider(
                        indent: 10,
                        height: 1,
                        endIndent: 10,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Placed order on $data",
                          style: TextStyle(color: ThemeColor.greyColor),
                        ),
                      ),
                      // const Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 10.0),
                      //   child: Text("products name"),
                      // ),
                      const SizedBox(
                        height: 3,
                      ),
                      const Divider(
                        indent: 10,
                        height: 1,
                        endIndent: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Total"),
                            Text("\$${check.totalCost}.00"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      );
    });
  }
}
