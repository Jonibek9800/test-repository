

import 'package:eGrocer/entity/product.dart';

class CheckDetails {
  int? id;
  int? productId;
  int? checkId;
  int? price;
  int? totalCost;
  int? quantity;
  Product? product;
  String? createdAt;
  String? updatedAt;

  CheckDetails({
    required this.id,
    required this.checkId,
    required this.productId,
    required this.totalCost,
    required this.quantity,
    required this.price,
    required this.product,
    required this.updatedAt,
    required this.createdAt,
  });

  CheckDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    checkId = json['check_id'];
    productId = json['product_id'];
    totalCost = json['total_cost'];
    quantity = json['quantity'];
    price = json['price'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['check_id'] = checkId;
    data['product_id'] = productId;
    data['total_cost'] = totalCost;
    data['quantity'] = quantity;
    data['price'] = price;
    data['product'] = product?.toJson();
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
