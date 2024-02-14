
import 'package:flutter/cupertino.dart';

import '../../../configuration/configuration.dart';
import '../../../entity/product.dart';
import 'network_client.dart';

class ProductApiClient {
  String getImage(String? posterPath) {
    return "${Configuration.host}/get/product/image/$posterPath";
  }

  Future<Map<String, dynamic>> getAllProducts(
      String? search, int? page, orderName, orderMethod) async {
    Map<String, dynamic> result = {};
    try {
      Map<String, dynamic> params = {
        "search": search,
        "page": page,
        "order_name": orderName,
        "method": orderMethod,
      };
      final response = await NetworkClient.dio.get("/get/products", queryParameters: params);
      debugPrint("${response.data}");
      result = response.data['products'];
    } catch (err) {
      result = {"error": err};
    }
    return result;
  }

  Future<List<Product>> getLimitProducts(int? limit, orderName, orderMethod) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      List<dynamic> list = jsonMap['products']['data'];
      List<Product> response = list.map((e) => Product.fromJson(e)).toList();
      return response;
    }
    Map<String, dynamic> params = {
      "limit": limit,
      "order_name": orderName,
      "method": orderMethod,
    };
    final result = await NetworkClient.get("/get/products", parser, params);
    return result;
  }

  Future<List<Product>> getProductByCategory(int? categoryId) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      List<dynamic> list = jsonMap['products'];
      List<Product> response = list.map((e) => Product.fromJson(e)).toList();
      return response;
    }

    final result = await NetworkClient.get(
      "/get/products/$categoryId",
      parser,
    );
    return result;
  }
}
