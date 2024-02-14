
import 'package:eGrocer/entity/product.dart';

class ProductIdInCart {
  int? quantity;
  int? productId;

  ProductIdInCart({required this.quantity, required this.productId});
}

class ProductsInCart {
  int? quantity;
  Product? product;

  ProductsInCart({required this.quantity, required this.product});

  ProductsInCart.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['product_id'] = product?.id;
    data['poster_path'] = product?.posterPath;
    data['name'] = product?.name;
    data['price'] = product?.price;
    data['quantity'] = quantity;
    data['total_cost'] = ((quantity?.toInt() ?? 0) * (product?.price?.toInt() ?? 0));
    return data;
  }
}

extension ExForListOfProdInCart on List<ProductsInCart> {
  double totalQty() =>
      fold<double>(
          0.0, (previousValue, element) =>
          previousValue + (element.quantity ?? 0.0).toDouble());

  double totalCost() => fold<double>(
      0.0, (previousValue, element) => previousValue+ ((element.product?.price ?? 0) *
      (element.quantity ?? 0.0).toDouble()));
}
