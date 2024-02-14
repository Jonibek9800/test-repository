import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../user_app/domain/api_client/network_client.dart';

class ProductApi {
  static Future<Map<String, dynamic>> getAllProduct({required int page}) async {
    Map<String, dynamic> result = {};
    try {
      final response = await NetworkClient.dio.get("/get/products",
          queryParameters: {"order_name": "id", "method": "asc", "page": page});
      if (response.statusCode != 200) {
        return result = {"serverError": response.data};
      }
      result = response.data;
    } catch (err) {
      result = {"error": err};
    }
    return result;
  }

  static Future<Map<String, dynamic>> addProduct(
      {required File? poster,
      required String name,
      required int? price,
      required String? description,
      required int? categoryId}) async {
    Map<String, dynamic> result = {};
    try {
      final posterPath = poster != null
          ? await MultipartFile.fromFile(poster.path, filename: poster.path)
          : null;
      final dataMap = FormData.fromMap({
        "name": name,
        "poster": posterPath,
        "price": price,
        "description": description,
        "category_id": categoryId,
      });
      final response =
          await NetworkClient.dio.post("/add/product", data: dataMap);
      if (response.statusCode != 200) {
        return result = {"error": response.data['message']};
      }
      result = response.data;
    } catch (err) {
      result = {"error": err};
    }
    return result;
  }

  static Future<Map<String, dynamic>> updateProduct(
      {required int? id,
      required File? poster,
      required String? name,
      required int? price,
      required String? description,
      required int? categoryId}) async {
    Map<String, dynamic> result = {};
    try {
      final posterPath = poster != null
          ? await MultipartFile.fromFile(poster.path, filename: poster.path)
          : null;
      final dataMap = FormData.fromMap({
        "name": name,
        "poster": posterPath,
        "price": price,
        "description": description,
        "category_id": categoryId,
      });
      final response =
          await NetworkClient.dio.post("/update/product/$id", data: dataMap);
      if (response.statusCode != 200) {
        return result = {"error": response.data['message']};
      }
      result = response.data;
    } catch (err) {
      result = {"error": err};
    }
    return result;
  }

  static Future<Map<String, dynamic>> deleteProduct({required int? id}) async {
    Map<String, dynamic> result = {};
    // try {
      final response = await NetworkClient.dio.delete("/delete/product/$id");
      debugPrint("${response.data}");
      if (response.statusCode != 200) {
        return result = {"error": response.data['message']};
      }
      result = response.data;
    // } catch (err) {
    //   result = {"error": err};
    // }
    return result;
  }
}
