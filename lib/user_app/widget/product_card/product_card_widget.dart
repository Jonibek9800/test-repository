import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/routes.dart';
import '../../domain/blocs/auth_bloc/auth_bloc.dart';
import '../../domain/blocs/cart_blocs/cart_bloc.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_event.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_state.dart';
import '../../domain/blocs/favorite_cubit/favorite_cubit.dart';
import '../../domain/blocs/favorite_cubit/favorite_cubit_state.dart';
import '../../domain/blocs/themes/themes_model.dart';
import '../../../../entity/product.dart';

class ProductCardWidget extends StatelessWidget {
  // Product product;

  const ProductCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text("${product.name}"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                child: Image.network(product.getImage(), fit: BoxFit.fill,),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Card(
                  child: BlocBuilder<FavoriteCubit, FavoriteCubitState>(
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
                                .toggleFavorite(user?.id, product);
                          },
                          icon: Row(children: [Icon(
                            product.isInFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: ThemeColor.greenColor,
                          ), const Text("Wishlist")],),
                        );
                      }),
                ),
                Card(
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(MainNavigationRouteNames.cartPage);
                    },
                    icon: Row(
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          color: ThemeColor.greenColor,
                        ),
                        const Text("Go to cart")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${product.name}"),
                    Text("\$${product.price}.00"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BlocBuilder<CartBloc, CartBlocState>(
                            builder: (BuildContext context, state) {
                              if (state.cartBlocModel.isAddToCart(product)) {
                                return Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    state.cartBlocModel.productQuantity == 1
                                        ? TextButton(
                                        onPressed: () {
                                          context.read<CartBloc>().add(
                                              RemoveFromCartEvent(
                                                  product: product));
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          // color: Colors.green,
                                        ))
                                        : TextButton(
                                      onPressed: () => context
                                          .read<CartBloc>()
                                          .add(RemoveQuantityEvent(
                                          product: product)),
                                      child: const Icon(
                                        Icons.remove,
                                        // color: Colors.green,
                                      ),
                                    ),
                                    Text(
                                      "${state.cartBlocModel.productQuantity}",
                                      // style: const TextStyle(color: Colors.white),
                                    ),
                                    TextButton(
                                      onPressed: () => context
                                          .read<CartBloc>()
                                          .add(
                                          AddQuantityEvent(product: product)),
                                      child: const Icon(
                                        Icons.add,
                                        // color: Colors.green,
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return OutlinedButton(
                                    onPressed: () {
                                      context
                                          .read<CartBloc>()
                                          .add(AddCartEvent(product: product));
                                    },
                                    child: const Text(
                                      "Add to Cart",
                                      // style: TextStyle(color: Colors.white),
                                    ));
                              }
                            }),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: [
                  const Text("Technical Details"),
                  const Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: const Text("Name"),
                    subtitle: Text("${product.name}"),
                  ),
                  ListTile(
                    title: const Text("Description"),
                    subtitle: Text("${product.description}"),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
