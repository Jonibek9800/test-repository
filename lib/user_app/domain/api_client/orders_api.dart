import 'package:flutter/cupertino.dart';

import '../../../entity/product_cart.dart';
import 'network_client.dart';

abstract class OrderNetwork {
  static Future<Map<String, dynamic>> createCheckDetails(
      {required List<ProductsInCart> listOfCart, required userId}) async {
    Map<String, dynamic> data = {
      'total_cost': listOfCart.totalCost(),
      'total_quantity': listOfCart.totalQty(),
      'products': listOfCart.map((e) => e.toJson()).toList(),
      'user_id': userId,
      'order_status': 'issued'
    };
    Map<String, dynamic> result = {};
    try {
      final response =
          await NetworkClient.dio.post("/create/check_details", data: data);
      debugPrint("response: $response");
      if (response.statusCode != 200) {
        debugPrint(
            "Error from create check_details status ${response.statusCode}");
        return {"serverError": "create check_details does not exist"};
      }
      if (response.data['success'] == true) debugPrint("successfully");
      result = response.data;
    } catch (err) {
      result = {"error": err};
      debugPrint("request error: $err");
    }
    return result;
  }

  static Future<List<dynamic>> getChecks({required userId}) async {
    List<dynamic> result = [];
    try {
      final response = await NetworkClient.dio
          .get("/get/checks", queryParameters: {"user_id": userId});

      if (response.statusCode != 200) {
        debugPrint("network error try again tomorrow");
      }
      result = response.data["checks"];
    } catch (err) {
      result = [
        {"error": err}
      ];
    }
    return result;
  }


}
