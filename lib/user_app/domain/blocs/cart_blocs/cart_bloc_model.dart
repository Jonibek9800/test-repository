import '../../../../entity/check.dart';
import '../../../../entity/product_cart.dart';
import 'cart_bloc_state.dart';

class CartBlocModel {
  List<ProductIdInCart> productInCart = [];
  List<ProductsInCart> cartProductList = [];
  var productQuantity = 0;
  List<Check> checks = [];
  Check? checkDetail;
  // bool? orderState;


  int cartQty() {
    return productInCart.fold(
        0, (previousValue, element) => previousValue + (element.quantity ?? 0));
  }

  int totalCost() {
    return cartProductList.fold(
        0,
        (prev, element) =>
            prev + (element.quantity! * (element.product?.price ?? 0)).toInt());
  }

  bool isEmptyProduct(product) {
    return productInCart.any((element) => element.productId == product.id);
  }

  bool isAddToCart(product) {
    productsQuantity(product);
    return productInCart.any((element) => element.productId == product.id);
  }

  bool loadState(CartBlocState state) {
    if (state is LoadCartState) {
      return true;
    } else {
      return false;
    }
  }

  void productsQuantity(product) {
    for (int i = 0; i < productInCart.length; i++) {
      if (productInCart[i].productId == product.id) {
        productQuantity = productInCart[i].quantity!;
      }
    }
  }
}
