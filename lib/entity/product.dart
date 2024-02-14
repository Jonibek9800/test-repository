
import '../user_app/domain/api_client/favorite_api.dart';
import '../user_app/domain/api_client/product_api.dart';

class Product {
  int? id;
  String? posterPath;
  String? name;
  int? price;
  String? description;
  int? categoryId;
  String? createdAt;
  String? updatedAt;
  bool isInFavorite = false, checkFavoriteInServer = false;

  Product(
      {required this.id,
      this.posterPath,
      this.name,
      required this.price,
      this.description,
      required this.categoryId,
      this.createdAt,
      this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    posterPath = json['poster_path'];
    name = json['name'];
    price = int.tryParse("${json['price']}");
    description = json['description'];
    categoryId = int.tryParse("${json['category_id']}");
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['poster_path'] = posterPath;
    data['name'] = name;
    data['price'] = price;
    data['description'] = description;
    data['category_id'] = categoryId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  String getImage() {
    return ProductApiClient().getImage(posterPath);
  }

  Future<void> getIsFavorite(int userId) async {
    checkFavoriteInServer = true;
    var data =
        await FavoriteApi.setFavoriteProduct(userId: userId, productId: id, deleting: isInFavorite);
    if (data.containsKey('error')) isInFavorite = !isInFavorite;
    checkFavoriteInServer = false;
  }
}
