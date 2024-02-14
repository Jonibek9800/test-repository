import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../routes/routes.dart';
import '../../domain/blocs/auth_bloc/auth_bloc.dart';
import '../../domain/blocs/cart_blocs/cart_bloc.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_event.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_state.dart';
import '../../domain/blocs/categories_bloc/categories_bloc.dart';
import '../../domain/blocs/categories_bloc/categories_state.dart';
import '../../domain/blocs/favorite_cubit/favorite_cubit.dart';
import '../../domain/blocs/favorite_cubit/favorite_cubit_state.dart';
import '../../domain/blocs/location_cubit/location_cubit.dart';
import '../../domain/blocs/products_bloc/products_bloc.dart';
import '../../domain/blocs/products_bloc/products_bloc_event.dart';
import '../../domain/blocs/products_bloc/products_bloc_state.dart';
import '../../domain/blocs/slider_cubit/slider_cubit.dart';
import '../../domain/blocs/slider_cubit/slider_cubit_state.dart';
import '../../domain/blocs/themes/themes_model.dart';
import '../../../../entity/product.dart';
import '../main_page/main_page_bloc.dart';
import '../ui/appbar.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final address =
        context.read<LocationCubit>().state.locationCubitModel.address;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size(MediaQuery.of(context).size.width, kToolbarHeight * 2),
            child: AppBarWidget(
              readOnly: true,
              onTap: () {
                Navigator.of(context).pushNamed("/search_page");
              },
              autofocus: false,
              appbarTitle: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(MainNavigationRouteNames.location);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_pin,
                      color: Color(0xFF56AE7C),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Delivery to",
                          // style: TextStyle(),
                        ),
                        Text(
                          address ?? "",
                        ),
                      ],
                    )
                  ],
                ),
              ),
              leadingWidth: 150.0,
              implyLeading: true,
              voiceCallback: () {
                Navigator.of(context)
                    .pushNamed(MainNavigationRouteNames.searchPage);
              },
            )),
        body: BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (BuildContext context, state) {
          return ListView(
            children: [
              const SizedBox(
                height: 15,
              ),
              BlocBuilder<SliderCubit, SliderCubitState>(
                  builder: (BuildContext context, state) {
                final sliderModel = state.sliderCubitModel;
                return CarouselSlider.builder(
                  options: CarouselOptions(
                    viewportFraction: 0.96,
                    aspectRatio: 16 / 9,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 1000),
                    autoPlayCurve: Curves.easeIn,
                  ),
                  itemCount: sliderModel.sliders.length,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    final slider = sliderModel.sliders[index];
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              errorWidget: (widget, str, obj) =>
                                  const Icon(Icons.error_outline_sharp),
                              imageUrl: slider.getPoster(),
                              fit: BoxFit.fill,
                            )));
                  },
                );
              }),
              const SizedBox(
                height: 15,
              ),
              BlocBuilder<MainBloc, MainViewBlocState>(
                builder: (BuildContext context, state) {
                  var index = 1;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      child: _SectionNameWidget(
                          sectionName: "Categories",
                          shopBy: "Shop by categories",
                          delegateClick: () {
                            context
                                .read<MainBloc>()
                                .add(NextPageBlocEvent(index: index));
                          }),
                    ),
                  );
                },
              ),
              const _CategoriesWidget(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  child: _SectionNameWidget(
                      sectionName: "Brands",
                      shopBy: "Shop by brands",
                      delegateClick: () {}),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Container(
                    decoration: BoxDecoration(
                        // color: const Color(0xFF212934),
                        borderRadius: BorderRadius.circular(10)),
                    child: GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 3,
                      ),
                      itemCount: 9,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              "Brands",
                              // style: TextStyle(color: Colors.white),
                            ));
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  child: _SectionNameWidget(
                      sectionName: "All Products",
                      shopBy: "All Available Products In App",
                      delegateClick: () {
                        context.read<ProductsBloc>().add(GetAllProductsEvent());
                        Navigator.of(context)
                            .pushNamed(MainNavigationRouteNames.products);
                      }),
                ),
              ),
              BlocBuilder<ProductsBloc, ProductsBlocState>(
                builder: (BuildContext context, state) {
                  final products = state.productsBlocModel.limitProducts;
                  return _ScrollBarListProductWidget(productList: products);
                },
              ),
              // _SectionNameWidget(
              //     sectionName: "All Vegetables",
              //     shopBy: "All Vegetables Available In App",
              //     delegateClick: () {
              //       final category = state.categoriesBlocModel
              //           .returnCategoryByName(categories, "Vegetables");
              //       context.read<ProductsBloc>().add(
              //           GetProductByCategoryEvent(
              //               categoryId: category.first.id));
              //       Navigator.of(context)
              //           .pushNamed('/categories/product_by_category');
              //       // print(category.id);
              //     }),
              // BlocBuilder<ProductsBloc, ProductsBlocState>(
              //   builder: (BuildContext context, state) {
              //     final product = state.productsBlocModel.productByCategory;
              //     return _ScrollBarListProductWidget(
              //       productList: product,
              //     );
              //   },
              // )
              // _SectionNameWidget(
              //     sectionName: "All Fruits",
              //     shopBy: "All Fruits Available In App",
              //     deligateClick: () {}),
              // // const _ScrollBarListProductWidget(
              // //     productList: HomePageData.productList),
              // _SectionNameWidget(
              //   sectionName: "Deal of the Day",
              //   shopBy: "All Spices Products In App",
              //   deligateClick: () {},
              // ),
              // // const _ScrollBarListProductWidget(
              // //     productList: HomePageData.productList),
              // _SectionNameWidget(
              //   sectionName: "All Beverages",
              //   shopBy: "All Beverages Available In App",
              //   deligateClick: () {},
              // ),
              // const _ScrollBarListProductWidget(
              //     productList: HomePageData.productList)
            ],
          );
        }));
  }
}

class _CategoriesWidget extends StatelessWidget {
  const _CategoriesWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (BuildContext context, state) {
        final categories = state.categoriesBlocModel.categories;
        if (state is LoadingCategoriesState) {
          return Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.black12,
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color(0xFF212934),
                  borderRadius: BorderRadius.circular(10)),
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: 6,
                  physics: const NeverScrollableScrollPhysics(),
                  // primary: false,
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Text("$index"),
                    );
                  }),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Container(
                // margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    // color: const Color(0xFF212934),
                    borderRadius: BorderRadius.circular(10)),
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: categories.length,
                    physics: const NeverScrollableScrollPhysics(),
                    // primary: false,
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final category = categories[index];
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(5)),
                        child: InkWell(
                          onTap: () {
                            context.read<ProductsBloc>().add(
                                GetProductByCategoryEvent(
                                    categoryId: category.id));
                            Navigator.of(context)
                                .pushNamed('/categories/product_by_category');
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // color: Colors.black26
                            ),
                            child: Column(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: category.posterPath != null
                                    ? CachedNetworkImage(
                                        imageUrl: category.getCategoryImage(),
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        height: 80,
                                      )
                                    : const Text(""),
                              ),
                              Center(
                                child: Text(
                                  category.title ?? '',
                                  // style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          );
        }
      },
    );
  }
}

//==================================================================================

class _ScrollBarListProductWidget extends StatelessWidget {
  const _ScrollBarListProductWidget({
    required this.productList,
  });

  final List<Product> productList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 290,
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          scrollDirection: Axis.horizontal,
          itemCount: productList.length,
          itemBuilder: (BuildContext context, int index) {
            final product = productList[index];
            final isFavorite = context
                .read<FavoriteCubit>()
                .state
                .favoriteModel
                .isFavorite(product);
            if (isFavorite) product.isInFavorite = true;
            return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                    MainNavigationRouteNames.productCard,
                    arguments: product);
              },
              child: Card(
                child: Container(
                    width: 170,
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
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  height: 160,
                                  width: 200,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              BlocBuilder<FavoriteCubit, FavoriteCubitState>(
                                  builder: (BuildContext context, state) {
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
                                            .toggleFavorite(user?.id, product);
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
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${product.name}",
                              // style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 7),
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
                          )
                        ])),
              ),
            );
          }),
    );
  }
}

//==================================================================================

class _SectionNameWidget extends StatelessWidget {
  final String sectionName;
  final String shopBy;
  final Function delegateClick;

  const _SectionNameWidget(
      {required this.sectionName,
      required this.shopBy,
      required this.delegateClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          // color: const Color(0xFF212934),
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                sectionName,
                style: const TextStyle(color: Color(0xFF56AE7C)),
              ),
              Text(shopBy, style: const TextStyle(color: Color(0xFF7D838A)))
            ]),
          ),
          OutlinedButton(
            onPressed: () {
              delegateClick();
            },
            style: ButtonStyle(
                shadowColor: MaterialStateProperty.all(const Color(0xFF56AE7C)),
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(86, 174, 124, 0.3))),
            child: const Text(
              "View All",
              // style: TextStyle(color: Colors.white),
            ),
          )
          //shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
        ],
      ),
    );
  }
}
