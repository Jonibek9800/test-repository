import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/routes.dart';
import '../../domain/blocs/auth_bloc/auth_bloc.dart';
import '../../domain/blocs/cart_blocs/cart_bloc.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_event.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_state.dart';
import '../../domain/blocs/favorite_cubit/favorite_cubit.dart';
import '../../domain/blocs/favorite_cubit/favorite_cubit_state.dart';
import '../../domain/blocs/list_state_cubit/product_list_cubit.dart';
import '../../domain/blocs/products_bloc/products_bloc.dart';
import '../../domain/blocs/products_bloc/products_bloc_event.dart';
import '../../domain/blocs/products_bloc/products_bloc_state.dart';
import '../../domain/blocs/themes/themes_model.dart';
import '../ui/appbar.dart';
import '../ui/product_page_widget.dart';
import '../ui/sorted_radio_list.dart';

class ProductsWidget extends StatefulWidget {
  const ProductsWidget({super.key});

  @override
  State<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        context
            .read<ProductsBloc>()
            .add(GetNextProductPageEvent(sortMethod: 'asc', sortName: 'id'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartBlocState>(builder: (context, cartState) {
      return BlocBuilder<ProductsBloc, ProductsBlocState>(
        builder: (BuildContext contexts, state) {
          final productModel = state.productsBlocModel;
          return BlocBuilder<ProductListCubit, ProductListCubitState>(builder: (BuildContext context, listState) {
            return Scaffold(
                appBar: PreferredSize(
                    preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight * 2),
                    child: AppBarWidget(
                      readOnly: true,
                      onTap: () {
                        Navigator.of(context).pushNamed("/search_page");
                      },
                      autofocus: false,
                      appbarLeading: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back_outlined),
                      ),
                      appbarTitle: const Text(
                        "Products",
                        style: TextStyle(color: Color(0xFF56AE7C)),
                      ),
                      implyLeading: true,
                      voiceCallback: () {
                        Navigator.of(context).pushNamed(MainNavigationRouteNames.searchPage);
                      },
                    )),
                body: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: TextButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      // isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.vertical(top: Radius.circular(10))),
                                      context: context,
                                      // backgroundColor: Colors.transparent,
                                      builder: (context) {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                icon: const Icon(Icons.arrow_back)),
                                            SortedRadioList(
                                              scrollController: _scrollController,
                                              sortedPageName: 'product',
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.sort),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text("Sort By"),
                                  ],
                                )),
                          ),
                        ),
                        Card(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: TextButton(
                                onPressed: () {
                                  context.read<ProductListCubit>().toggleGridOrListView();
                                },
                                child: listState == ProductListCubitState.gridView
                                    ? const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.list),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text("ListView"),
                                        ],
                                      )
                                    : const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.grid_on),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text("GridView"),
                                        ],
                                      )),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView(
                        controller: _scrollController,
                        children: [
                          listState == ProductListCubitState.listView
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemExtent: 160,
                                  itemCount: productModel.allProducts.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final product = productModel.allProducts[index];
                                    return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 5),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                              MainNavigationRouteNames.productCard,
                                              arguments: product,
                                            );
                                          },
                                          child: ProductPageWidget(
                                            product: product,
                                          ),
                                        ));
                                  })
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GridView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: productModel.allProducts.length,
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 0.65,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                        crossAxisCount: 2,
                                      ),
                                      itemBuilder: (BuildContext context, int index) {
                                        final product = productModel.allProducts[index];
                                        return InkWell(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                MainNavigationRouteNames.productCard,
                                                arguments: product);
                                          },
                                          child: Card(
                                            child: Container(
                                                // width: 170,
                                                // margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                                decoration: BoxDecoration(
                                                    // color: const Color(0xFF212934),
                                                    borderRadius: BorderRadius.circular(10)),
                                                // padding: EdgeInsets.all(10),
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius: BorderRadius.circular(10),
                                                            child: CachedNetworkImage(
                                                              imageUrl: product.getImage(),
                                                              placeholder: (context, url) =>
                                                                  const Center(
                                                                      child:
                                                                          CircularProgressIndicator()),
                                                              errorWidget: (context, url, error) =>
                                                                  const Icon(Icons.error),
                                                              height: 160,
                                                              width: 200,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                          BlocBuilder<FavoriteCubit,
                                                                  FavoriteCubitState>(
                                                              builder:
                                                                  (BuildContext context, state) {
                                                            return Positioned(
                                                                right: 0,
                                                                top: 5,
                                                                child: IconButton(
                                                                  onPressed: () {
                                                                    final user = context
                                                                        .read<AuthBloc>()
                                                                        .state
                                                                        .authModel
                                                                        .user;
                                                                    context
                                                                        .read<FavoriteCubit>()
                                                                        .toggleFavorite(
                                                                            user?.id, product);
                                                                  },
                                                                  icon: Icon(
                                                                    product.isInFavorite
                                                                        ? Icons.favorite
                                                                        : Icons.favorite_border,
                                                                    color: ThemeColor.greenColor,
                                                                  ),
                                                                ));
                                                          })
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(5.0),
                                                        child: Text(
                                                          "${product.name}",
                                                          // style: const TextStyle(color: Colors.white),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 5.0, vertical: 7),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                "\$${product.price}",
                                                                // style: const TextStyle(color: Colors.white),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        height: 1,
                                                        color: const Color(0xFF151A20),
                                                      ),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: BlocBuilder<CartBloc, CartBlocState>(
                                                            builder: (BuildContext context, state) {
                                                          if (state.cartBlocModel
                                                              .isAddToCart(product)) {
                                                            return Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment.spaceAround,
                                                              children: [
                                                                state.cartBlocModel
                                                                            .productQuantity ==
                                                                        1
                                                                    ? TextButton(
                                                                        onPressed: () {
                                                                          context
                                                                              .read<CartBloc>()
                                                                              .add(
                                                                                  RemoveFromCartEvent(
                                                                                      product:
                                                                                          product));
                                                                        },
                                                                        child: const Icon(
                                                                          Icons.delete,
                                                                          // color: Colors.green,
                                                                        ))
                                                                    : TextButton(
                                                                        onPressed: () => context
                                                                            .read<CartBloc>()
                                                                            .add(
                                                                                RemoveQuantityEvent(
                                                                                    product:
                                                                                        product)),
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
                                                                      .add(AddQuantityEvent(
                                                                          product: product)),
                                                                  child: const Icon(
                                                                    Icons.add,
                                                                    // color: Colors.green,
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          } else {
                                                            return TextButton(
                                                                onPressed: () {
                                                                  context.read<CartBloc>().add(
                                                                      AddCartEvent(
                                                                          product: product));
                                                                },
                                                                child: const Text(
                                                                  "Add to Cart",
                                                                  // style: TextStyle(color: Colors.white),
                                                                ));
                                                          }
                                                        }),
                                                      )
                                                    ])),
                                          ),
                                        );
                                      }),
                                ),
                          if (productModel.allProducts.length < (productModel.totalCount ?? 0))
                            Center(
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: ThemeColor.greenColor,
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ));
          });
        },
      );
    });
  }
}
