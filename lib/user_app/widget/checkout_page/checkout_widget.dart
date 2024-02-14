import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../routes/routes.dart';
import '../../domain/blocs/auth_bloc/auth_bloc.dart';
import '../../domain/blocs/cart_blocs/cart_bloc.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_event.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_state.dart';
import '../../domain/blocs/location_cubit/location_cubit.dart';
import '../../domain/blocs/themes/themes_model.dart';
import '../loader_page/loader_view_cubit.dart';

class CheckoutWidget extends StatelessWidget {
  const CheckoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final address =
        context.read<LocationCubit>().state.locationCubitModel.address;
    return Scaffold(
      // backgroundColor: const Color(0xFF151A20),
      appBar: AppBar(
        // backgroundColor: const Color(0xFF212934),
        // iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          "Checkout",
          // style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(bottom: 165),
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Address Details",
                            // style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Jony",
                            // style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            address ?? "$address",
                            // style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            "001777786",
                            // style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            "Preferred Delivery Time",
                            // style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.circular(8),
                              // color: const Color(0xFF151A20)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Column(
                                children: [
                                  Text(
                                    DateFormat.E().format(DateTime.now()),
                                    // style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    DateFormat.d().format(DateTime.now()),
                                    // style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    DateFormat.MMMM().format(DateTime.now()),
                                    // style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Afternoon 3 PM to 9 PM",
                            // style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: const Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Payment Method",
                            // style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          _PaymentWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // color: const Color(0xFF212934)
                ),
                child: BlocBuilder<CartBloc, CartBlocState>(
                    builder: (BuildContext context, state) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Order Summary",
                            // style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Subtotal",
                                // style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "\$${state.cartBlocModel.totalCost()}.00",
                                // style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Delivery Charge",
                                // style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "\$0.00",
                                // style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total",
                                // style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "\$${state.cartBlocModel.totalCost()}.00",
                                // style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0xFF56AE7C))),
                                onPressed: () {
                                  // if (state is! LoadCartState) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text("Order access"),
                                            content: Text(
                                              "Your order has been successfully completed",
                                              style: TextStyle(
                                                  color: ThemeColor.greenColor),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    final user = context
                                                        .read<AuthBloc>()
                                                        .state
                                                        .authModel
                                                        .user;
                                                    if (user != null) {
                                                      context
                                                          .read<CartBloc>()
                                                          .add(OrderByCartEvent(
                                                              userId:
                                                                  user.id));
                                                      Navigator.pushReplacementNamed(
                                                          context,
                                                          MainNavigationRouteNames
                                                              .loaderWidget);
                                                      context
                                                          .read<
                                                              LoaderViewCubit>()
                                                          .onUnknown();
                                                    }
                                                  },
                                                  child: const Text("Ok"))
                                            ],
                                          );
                                        });
                                  // } else {
                                  //   showDialog(
                                  //       context: context,
                                  //       builder: (context) {
                                  //         return AlertDialog(
                                  //           content: Center(
                                  //             child:
                                  //                 CircularProgressIndicator(),
                                  //           ),
                                  //         );
                                  //       });
                                  // }
                                },
                                child: state is LoadCartState
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : const Text(
                                        "Place Order",
                                        // style: TextStyle(color: Colors.white),
                                      )),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum SingingCharacter { cashOnDelivery, paypal, dushanbeCity }

class _PaymentWidget extends StatefulWidget {
  const _PaymentWidget();

  @override
  State<_PaymentWidget> createState() => _PaymentWidgetState();
}

SingingCharacter? character = SingingCharacter.cashOnDelivery;

class _PaymentWidgetState extends State<_PaymentWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              character = SingingCharacter.cashOnDelivery;
            });
          },
          focusColor: const Color(0xFF56AE7C),
          borderRadius: BorderRadius.circular(10.0),
          child: Material(
            // color: const Color(0xFF151A20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: character == SingingCharacter.cashOnDelivery
                    ? const Color(0xFF56AE7C)
                    : Colors.transparent,
                width: 2.0,
              ),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.money,
                color: Color(0xFF56AE7C),
              ),
              title: const Text(
                'Cash on Delivery',
                // style: TextStyle(color: Colors.white),
              ),
              trailing: Radio<SingingCharacter>(
                activeColor: const Color(0xFF56AE7C),
                value: SingingCharacter.cashOnDelivery,
                groupValue: character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    character = value;
                  });
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            setState(() {
              character = SingingCharacter.dushanbeCity;
            });
          },
          focusColor: const Color(0xFF56AE7C),
          borderRadius: BorderRadius.circular(10.0),
          child: Material(
            // color: const Color(0xFF151A20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: character == SingingCharacter.dushanbeCity
                    ? const Color(0xFF56AE7C)
                    : Colors.transparent,
                width: 2.0,
              ),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.payment,
                color: Colors.orangeAccent,
              ),
              title: const Text(
                'DC Wallet',
                // style: TextStyle(color: Colors.white),
              ),
              // tileColor: const Color(0xFF151A20),
              trailing: Radio<SingingCharacter>(
                activeColor: const Color(0xFF56AE7C),
                value: SingingCharacter.dushanbeCity,
                groupValue: character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    character = value;
                  });
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            setState(() {
              character = SingingCharacter.paypal;
            });
          },
          focusColor: const Color(0xFF56AE7C),
          borderRadius: BorderRadius.circular(10.0),
          child: Material(
            // color: const Color(0xFF151A20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: character == SingingCharacter.paypal
                    ? const Color(0xFF56AE7C)
                    : Colors.transparent,
                width: 2.0,
              ),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.paypal,
                color: Colors.blue,
              ),
              title: const Text(
                'PayPal',
              ),
              // tileColor: const Color(0xFF151A20),
              trailing: Radio<SingingCharacter>(
                activeColor: const Color(0xFF56AE7C),
                value: SingingCharacter.paypal,
                groupValue: character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    character = value;
                  });
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
