import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../routes/routes.dart';
import '../../domain/blocs/auth_bloc/auth_bloc.dart';
import '../../domain/blocs/cart_blocs/cart_bloc.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_event.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_state.dart';
import '../../domain/blocs/favorite_cubit/favorite_cubit.dart';
import '../../domain/blocs/favorite_cubit/favorite_cubit_state.dart';
import '../../domain/blocs/list_state_cubit/search_list_cubit.dart';
import '../../domain/blocs/products_bloc/products_bloc.dart';
import '../../domain/blocs/products_bloc/products_bloc_event.dart';
import '../../domain/blocs/products_bloc/products_bloc_state.dart';
import '../../domain/blocs/themes/themes_model.dart';
import '../ui/appbar.dart';
import '../ui/product_page_widget.dart';
import '../ui/sorted_radio_list.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final ScrollController _scrollController = ScrollController();
  final SpeechToText _speechToText = SpeechToText();
  String _lastWords = '';

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
    _initSpeech();
  }

  void _initSpeech() async {
    setState(() {});
  }

  void _startListening() async {
    _lastWords = '';
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsBlocState>(builder: (BuildContext context, state) {
      final searchProducts = state.productsBlocModel;
      return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight * 2),
              child: AppBarWidget(
                readOnly: false,
                onTap: () {},
                autofocus: true,
                appbarLeading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_outlined),
                ),
                appbarTitle: const Text(
                  "Search",
                ),
                onChange: (text) {
                  context
                      .read<ProductsBloc>()
                      .add(GetSearchProductEvent(sortMethod: 'asc', sortName: 'id'));
                },
                implyLeading: true,
                voiceCallback: () {
                  context.read<ProductsBloc>().add(
                      SpeechToTextControllerEvent(text: '', sortName: 'id', sortMethod: 'asc'));
                  showModalBottomSheet(
                      isDismissible: false,
                      elevation: 0.3,
                      context: context,
                      builder: (_) {
                        _speechToText.isNotListening ? _startListening() : _stopListening();
                        return SizedBox(
                          height: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Icon(
                                  Icons.keyboard_voice_outlined,
                                  color: ThemeColor.greenColor,
                                  size: 72,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: OutlinedButton(
                                        onPressed: () {
                                          context
                                              .read<ProductsBloc>()
                                              .add(SpeechToTextControllerEvent(
                                                text: _lastWords,
                                                sortName: 'id',
                                                sortMethod: 'asc',
                                              ));
                                          Navigator.of(context).pop();
                                          _stopListening();
                                        },
                                        child: Icon(
                                          Icons.check,
                                          color: ThemeColor.greenColor,
                                          size: 50,
                                        )),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      });
                  setState(() {});
                },
              )),
          body: BlocBuilder<SearchListCubit, SearchListCubitState>(
            builder: (BuildContext context, listState) {
              return Column(
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
                                            sortedPageName: 'search',
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
                                context.read<SearchListCubit>().toggleGridOrListView();
                              },
                              child: listState == SearchListCubitState.gridView
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
                      )
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      controller: _scrollController,
                      children: [
                        listState == SearchListCubitState.listView
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemExtent: 160,
                                itemCount: searchProducts.filteredProducts.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final product = searchProducts.filteredProducts[index];
                                  return Padding(
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
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
                                    itemCount: searchProducts.allProducts.length,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.65,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                      crossAxisCount: 2,
                                    ),
                                    itemBuilder: (BuildContext context, int index) {
                                      final product = searchProducts.allProducts[index];
                                      return InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              MainNavigationRouteNames.productCard,
                                              arguments: product);
                                        },
                                        child: Card(
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10)),
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
                                                              state.cartBlocModel.productQuantity ==
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
                                                                context.read<CartBloc>().add(
                                                                    AddCartEvent(product: product));
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
                        if (searchProducts.allProducts.length < (searchProducts.totalCount ?? 0))
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
              );
            },
          ));
    });
  }
}
