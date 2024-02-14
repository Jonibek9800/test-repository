import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/routes.dart';
import '../../domain/blocs/auth_bloc/auth_bloc.dart';
import '../../domain/blocs/auth_bloc/auth_state.dart';
import '../../domain/blocs/cart_blocs/cart_bloc.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_event.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_state.dart';
import '../../domain/blocs/favorite_cubit/favorite_cubit.dart';
import '../../domain/blocs/favorite_cubit/favorite_cubit_state.dart';
import '../../domain/blocs/themes/themes_model.dart';
import '../ui/alert_dialog.dart';

class CartPageWidget extends StatelessWidget {
  const CartPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Cart",
            // style: TextStyle(color: Colors.white),
          ),
          // iconTheme: const IconThemeData(color: Colors.white),
          // backgroundColor: const Color(0xFF212934),
        ),
        body: BlocBuilder<CartBloc, CartBlocState>(
            builder: (BuildContext context, CartBlocState cartState) {
          final products = cartState.cartBlocModel.cartProductList;

          if (cartState.cartBlocModel.cartQty() == 0) {
            return DecoratedBox(
              decoration: const BoxDecoration(
                  // color: Color(0xFF151A20),
                  ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.remove_shopping_cart,
                    color: Color(0xFF56AE7C),
                    size: 100,
                  ),
                  const Text(
                    "Cart is Empty",
                    style: TextStyle(color: Color(0xFF56AE7C), fontSize: 28),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "It seems like you haven't added anything to your cart yet!",
                      // maxLines: 2,
                      style: TextStyle(
                        // color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Show Now",
                        style: TextStyle(
                          color: Color(0xFF56AE7C),
                          fontSize: 16,
                        ),
                      ))
                ],
              ),
            );
          } else {
            return Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  // color: const Color(0xFF151A20),
                  child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 105),
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        final cartProduct = products[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                MainNavigationRouteNames.productCard,
                                arguments: cartProduct.product,
                              );
                            },
                            child: Card(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    // color: const Color(0xFF212934),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: cartProduct.product!.getImage(),
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        height: 150,
                                        width: 130,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            cartProduct.product?.name ?? "",
                                            // style: const TextStyle(
                                            //     color: Colors.white),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "\$${cartProduct.product?.price}",
                                            style: const TextStyle(
                                                color: Color(0xFF56AE7C)),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            cartProduct.product?.description ??
                                                '',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            // style: const TextStyle(
                                            //     color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        BlocBuilder<FavoriteCubit, FavoriteCubitState>(
                                            builder: (BuildContext context, state) {
                                              return IconButton(
                                                onPressed: () {
                                                  final user = context
                                                      .read<AuthBloc>()
                                                      .state
                                                      .authModel
                                                      .user;
                                                  context
                                                      .read<FavoriteCubit>()
                                                      .toggleFavorite(user?.id, cartProduct.product);
                                                },
                                                icon: Icon(
                                                  cartProduct.product!.isInFavorite
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  color: ThemeColor.greenColor,
                                                ),
                                              );
                                            }),
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        BlocBuilder<CartBloc, CartBlocState>(
                                            builder:
                                                (BuildContext context, state) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              cartProduct.quantity == 1
                                                  ? TextButton(
                                                      onPressed: () {
                                                        context.read<CartBloc>().add(
                                                            RemoveFromCartEvent(
                                                                product:
                                                                    cartProduct
                                                                        .product));
                                                      },
                                                      child: const Icon(
                                                        Icons.delete,
                                                        color: Color(0xFF56AE7C),
                                                      ))
                                                  : TextButton(
                                                      onPressed: () => context
                                                          .read<CartBloc>()
                                                          .add(RemoveQuantityEvent(
                                                              product: cartProduct
                                                                  .product)),
                                                      child: const Icon(
                                                        Icons.remove,
                                                        color: Color(0xFF56AE7C),
                                                      ),
                                                    ),
                                              Text(
                                                "${cartProduct.quantity}",
                                                // style: const TextStyle(
                                                //     color: Colors.white),
                                              ),
                                              TextButton(
                                                onPressed: () => context
                                                    .read<CartBloc>()
                                                    .add(AddQuantityEvent(
                                                        product:
                                                            cartProduct.product)),
                                                child: const Icon(
                                                  Icons.add,
                                                  color: Color(0xFF56AE7C),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    // color: const Color(0xFF151A20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            // color: const Color(0xFF212934)
                          ),
                          child: BlocBuilder<AuthBloc, AuthBlocState>(
                              builder: (BuildContext context, state) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Subtotal (${products.length} Items)",
                                        // style:
                                        //     const TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        "\$${cartState.cartBlocModel.totalCost()}.00",
                                        // style:
                                        //     const TextStyle(color: Colors.white),
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
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Color(0xFF56AE7C))),
                                        onPressed: () {
                                          if (state.authModel.user != null) {
                                            Navigator.of(context).pushNamed(
                                                MainNavigationRouteNames
                                                    .checkout);
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (_) =>
                                                    const AlertDialogWidget());
                                          }
                                        },
                                        child: const Text(
                                          "Proceed to Checkout",
                                          // style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        }));
  }
}
