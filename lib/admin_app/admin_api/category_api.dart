import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../user_app/domain/api_client/network_client.dart';

class CategoryApi {
  static Future<Map<String, dynamic>> getAllCategories() async {
    Map<String, dynamic> result = {};
    try {
      final response = await NetworkClient.dio.get("/get/categories");
      if (response.statusCode != 200) {
        return result = {"serverError": response.data};
      }
      result = response.data;
    } catch (err) {
      result = {"error": err};
    }
    return result;
  }

  static Future<Map<String, dynamic>> addCategory({
    required File? poster,
    required String name,
  }) async {
    Map<String, dynamic> result = {};
    // try {
      final posterPath = poster != null
          ? await MultipartFile.fromFile(poster.path, filename: poster.path)
          : null;
      final dataMap = FormData.fromMap({"title": name, "poster": posterPath});
      final response =
          await NetworkClient.dio.post("/add/category", data: dataMap);
      debugPrint("${response.data}");
      if (response.statusCode != 200) {
        return result = {"error bad": response.data['message']};
      }
      result = response.data;
    // } catch (err) {
    //   debugPrint("bad request : $err");
    //   result = {"error": err};
    // }
    return result;
  }

  static Future<Map<String, dynamic>> updateCategory({
    required int? id,
    File? poster,
    String? name,
  }) async {
    Map<String, dynamic> result = {};
    try {
      final posterPath = poster != null
          ? await MultipartFile.fromFile(poster.path, filename: poster.path)
          : null;
      final dataMap = FormData.fromMap({"title": name, "poster": posterPath});
      final response =
          await NetworkClient.dio.post("/update/category/$id", data: dataMap);
      if (response.statusCode != 200) {
        return result = {"error": response.data['message']};
      }
      result = response.data;
    } catch (err) {
      result = {"error": err};
    }
    return result;
  }

  static Future<Map<String, dynamic>> deleteCategory({required int? id}) async {
    Map<String, dynamic> result = {};
    try {
      final response = await NetworkClient.dio.delete("/delete/category/$id");
      if (response.statusCode != 200) {
        return result = {"error": response.data['message']};
      }
      result = response.data;
    } catch (err) {
      result = {"error": err};
    }
    return result;
  }
}
