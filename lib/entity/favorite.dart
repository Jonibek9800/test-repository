import 'package:eGrocer/entity/product.dart';

class Favorite {
  int? id;
  int? userId;
  int? productId;
  Product? product;
  String? createdAt;
  String? updatedAt;

  Favorite({
    this.id,
    required this.userId,
    required this.productId,
    required this.product,
    this.createdAt,
    this.updatedAt,
  });

  Favorite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson () {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['product_id'] = productId;
    data['product'] = product;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
