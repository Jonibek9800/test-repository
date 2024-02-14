import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../domain/blocs/cart_blocs/cart_bloc.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_state.dart';
import '../../domain/blocs/location_cubit/location_cubit.dart';
import '../../domain/blocs/themes/themes_model.dart';

class OrderDetailsWidget extends StatelessWidget {
  const OrderDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartBlocState>(
        builder: (BuildContext context, state) {
      final details = state.cartBlocModel.checkDetail;
      final formatDate = DateTime.parse(details?.createdAt ?? "");
      final date = DateFormat.yMd().format(formatDate);
      final time = DateFormat.Hms().format(formatDate);
      final address = context.read<LocationCubit>().state.locationCubitModel.address;
      return Scaffold(
        appBar: AppBar(
          title: const Text("Order summary"),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Order"),
                          Text("#${details?.id}"),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Received"),
                          Text("$date $time"),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    Center(
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Track order",
                            style: TextStyle(color: ThemeColor.greenColor),
                          )),
                    )
                  ],
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: details?.details?.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final orderDetail = details?.details?[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                              imageUrl: orderDetail?.product?.getImage() ?? "",
                              placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                              height: 140,
                              width: 140,
                              fit: BoxFit.fill),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${orderDetail?.product?.name}"),
                                  Text("x${orderDetail?.quantity}"),
                                  Text("\$${orderDetail?.price}.00"),
                                ],
                              ),
                            ),
                            Center(
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Cancel",
                                  style:
                                      TextStyle(color: ThemeColor.greenColor),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Delivery Information"),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Delivery to"),
                          Text(
                            "${address ?? address}, Dushanbe, Tajikistan, Jony, 001777786",
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text("Billing details"),
                      const Divider(
                        height: 1,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Payment Method"),
                          Text("COD"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Subtotal"),
                          Text("\$${details?.totalCost}.00"),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Delivery Charge"),
                          Text("\$0.00"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total"),
                          Text("\$${details?.totalCost}.00"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
