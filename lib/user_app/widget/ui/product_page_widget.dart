import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../entity/product.dart';
import '../../../routes/routes.dart';
import '../../domain/blocs/auth_bloc/auth_bloc.dart';
import '../../domain/blocs/cart_blocs/cart_bloc.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_event.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_state.dart';
import '../../domain/blocs/favorite_cubit/favorite_cubit.dart';
import '../../domain/blocs/favorite_cubit/favorite_cubit_state.dart';
import '../../domain/blocs/themes/themes_model.dart';

class ProductPageWidget extends StatelessWidget {
  final Product? product;

  const ProductPageWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.read<FavoriteCubit>().state.favoriteModel.isFavorite(product);
    if (isFavorite) product?.isInFavorite = true;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          MainNavigationRouteNames.productCard,
          arguments: product,
        );
      },
      child: Card(
        child: DecoratedBox(
          decoration: BoxDecoration(
            // color: const Color(0xFF212934),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                      imageUrl: product?.getImage() ?? '',
                      // placeholder: (context, url) =>
                      //     const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      height: 155,
                      width: 130,
                      fit: BoxFit.fill)),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      product?.name ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "\$${product?.price}",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      product?.description ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      // style: const TextStyle(color: Colors.white),
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
                        final user = context.read<AuthBloc>().state.authModel.user;
                        context.read<FavoriteCubit>().toggleFavorite(user?.id, product);
                      },
                      icon: Icon(
                        product!.isInFavorite ? Icons.favorite : Icons.favorite_border,
                        color: ThemeColor.greenColor,
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocBuilder<CartBloc, CartBlocState>(
                        builder: (BuildContext context, state) {
                      if (state.cartBlocModel.isAddToCart(product)) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            state.cartBlocModel.productQuantity == 1
                                ? TextButton(
                                    onPressed: () {
                                      context
                                          .read<CartBloc>()
                                          .add(RemoveFromCartEvent(product: product));
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Color(0xFF56AE7C),
                                    ))
                                : TextButton(
                                    onPressed: () => context
                                        .read<CartBloc>()
                                        .add(RemoveQuantityEvent(product: product)),
                                    child: const Icon(
                                      Icons.remove,
                                      // color: Color(0xFF56AE7C),
                                    ),
                                  ),
                            Text(
                              "${state.cartBlocModel.productQuantity}",
                              // style: const TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () =>
                                  context.read<CartBloc>().add(AddQuantityEvent(product: product)),
                              child: const Icon(
                                Icons.add,
                                // color: Color(0xFF56AE7C),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return OutlinedButton(
                            onPressed: () {
                              // final user =
                              //     context.read<AuthBloc>().state.authModel.user;
                              // if (user != null) {
                              context.read<CartBloc>().add(AddCartEvent(product: product));
                              // } else {
                              //   showDialog(
                              //       context: context,
                              //       builder: (_) => const AlertDialogWidget());
                              // }
                            },
                            child: const Text(
                              "Add to Cart",
                              // style: TextStyle(color: Colors.white),
                            ));
                      }
                      // }
                    }),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
