import 'package:bloc/bloc.dart';
import 'package:eGrocer/user_app/domain/blocs/cart_blocs/sqflite.dart';

import '../../api_client/orders_api.dart';
import '../../api_client/product_api.dart';
import '../../../../entity/check.dart';
import '../../../../entity/product.dart';
import '../../../../entity/product_cart.dart';
import 'cart_bloc_event.dart';
import 'cart_bloc_model.dart';
import 'cart_bloc_state.dart';

class CartBloc extends Bloc<CartBlocEvent, CartBlocState> {
  late CartBlocModel currentState;

  CartBloc() : super(InitCartState(cartBlocModel: CartBlocModel())) {
    currentState = state.cartBlocModel;

    on<InitCartEvent>((event, emit) async {
      try {
        await getProducts(emit);
        emit(InitCartState(cartBlocModel: currentState));
      } catch (err) {
        emit(ErrorCartState(cartBlocModel: currentState));
      }
    });
    on<AddCartEvent>((event, emit) => addToCart(event, emit));
    on<AddQuantityEvent>((event, emit) => addQuantity(emit, event.product));
    on<RemoveQuantityEvent>(
        (event, emit) => removeQuantity(emit, event.product));
    on<RemoveFromCartEvent>(
        (event, emit) async => await removeProduct(emit, event.product));
    on<GetProductsByIdEvent>(
        (event, emit) async => await getProductsById(emit));
    on<OrderByCartEvent>((event, emit) => onOrderEvent(event, emit));
    on<ChecksByOrderEvent>((event, emit) => getChecks(event, emit));
    on<CheckDetailsByOrderEvent>((event, emit) => getCheckDetails(event, emit));
  }

  void addToCart(AddCartEvent event, Emitter<CartBlocState> emit) async {
    final product = event.product;
    try {
      emit(LoadCartState(cartBlocModel: currentState));
      final isEmptyProduct = await SQLHelper.getProduct(product?.id);
      if (isEmptyProduct.isNotEmpty) {
        final count = isEmptyProduct.first['quantity'] as int;
        final quantity = count + 1;
        await SQLHelper.updateProduct(product?.id, quantity, product);
      } else {
        final data = {"quantity": 1, "productId": product?.id};
        // currentState.productInCart.add(ProductIdInCart(
        //     quantity: data['quantity'], productId: data['productId']));
        currentState.cartProductList
            .add(ProductsInCart(quantity: 1, product: product));
        await SQLHelper.createProduct(data);
      }
      // await getProductsById(emit);
      await getProducts(emit);
      emit(AddCartState(cartBlocModel: currentState));
    } catch (e) {
      emit(ErrorCartState(cartBlocModel: currentState));
    }
  }

  void addQuantity(Emitter<CartBlocState> emit, Product? product) async {
    try {
      emit(LoadCartState(cartBlocModel: currentState));
      final isEmptyProduct = currentState.cartProductList
          .where((element) => element.product?.id == product?.id);
      final index = currentState.cartProductList
          .indexWhere((element) => element.product?.id == product?.id);

      final count = isEmptyProduct.first.quantity as int;
      final quantity = count + 1;
      currentState.cartProductList[index].quantity = quantity;
      await SQLHelper.updateProduct(product?.id, quantity, product);
      await getProducts(emit);
      await getProductsById(emit);
      emit(AddQuantityState(cartBlocModel: currentState));
    } catch (e) {
      emit(ErrorCartState(cartBlocModel: currentState));
    }
  }

  void removeQuantity(Emitter<CartBlocState> emit, Product? product) async {
    try {
      emit(LoadCartState(cartBlocModel: currentState));
      final isEmptyProduct = currentState.cartProductList
          .where((element) => element.product?.id == product?.id);
      final index = currentState.cartProductList
          .indexWhere((element) => element.product?.id == product?.id);
      if (isEmptyProduct.isNotEmpty) {
        final count = isEmptyProduct.first.quantity as int;
        final quantity = count - 1;
        currentState.cartProductList[index].quantity = quantity;
        await SQLHelper.updateProduct(product?.id, quantity, product);
        await getProducts(emit);
        await getProductsById(emit);
        if (quantity <= 0) {
          currentState.cartProductList = currentState.cartProductList
              .where((element) => element.product?.id != product?.id)
              .toList();
          await removeProduct(emit, product);
        }
      }
      emit(RemoveQuantityState(cartBlocModel: currentState));
    } catch (e) {
      emit(ErrorCartState(cartBlocModel: currentState));
    }
  }

  Future<void> removeProduct(
      Emitter<CartBlocState> emit, Product? product) async {
    emit(LoadCartState(cartBlocModel: currentState));
    currentState.cartProductList = currentState.cartProductList
        .where((element) => element.product?.id != product?.id)
        .toList();
    await SQLHelper.deleteProduct(product?.id);
    await getProducts(emit);
    emit(RemoveToCartState(cartBlocModel: currentState));
  }

  Future<void> getProducts(Emitter<CartBlocState> emit) async {
    final items = await SQLHelper.getProducts();
    currentState.productInCart = items
        .map((elem) => ProductIdInCart(
            quantity: elem['quantity'], productId: elem['productId']))
        .toList();
    emit(AddedToCartState(cartBlocModel: currentState));
  }

  Future<void> getProductsById(Emitter emit) async {
    final productApiClient = ProductApiClient();
    int page = 1;
    final response = await productApiClient.getAllProducts(null, page, "id", "asc");
    final products = (response['data'] as List).map((e) => Product.fromJson(e));
    currentState.cartProductList = [];
    for (var element in products) {
      for (var item in currentState.productInCart) {
        if (element.id == item.productId) {
          ProductsInCart data =
              ProductsInCart(quantity: item.quantity, product: element);
          currentState.cartProductList.add(data);
        }
      }
    }
    emit(GetProductByIdState(cartBlocModel: currentState));
  }

  void onOrderEvent(event, Emitter emit) async {
    emit(LoadCartState(cartBlocModel: currentState));
    await OrderNetwork.createCheckDetails(
        listOfCart: currentState.cartProductList, userId: event.userId);
    await SQLHelper.deleteProducts();
    // currentState.orderState = data["success"];
    currentState.cartProductList = [];
    emit(InitCartState(cartBlocModel: currentState));
  }

  void getChecks(event, Emitter emit) async {
    emit(LoadCartState(cartBlocModel: currentState));
    final checks = await OrderNetwork.getChecks(userId: event.userId);
    currentState.checks = [];
    for (var element in checks) {
      currentState.checks.add(Check.fromJson(element));
    }

    emit(ChecksByOrderState(cartBlocModel: currentState));
  }

  void getCheckDetails(event, Emitter emit) async {
    emit(LoadCartState(cartBlocModel: currentState));
    currentState.checkDetail = event.details;
    emit(CheckDetailsByOrderState(cartBlocModel: currentState));
  }
}
