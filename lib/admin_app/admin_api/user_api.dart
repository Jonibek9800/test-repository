import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../user_app/domain/api_client/network_client.dart';

class UserApi {
  static Future<Map<String, dynamic>?> getAllUser() async {
    Map<String, dynamic>? result;
    try {
      final response = await NetworkClient.dio.get("/get/users");
      if (response.statusCode != 200) {
        return result = {"error": "Server error from get all users will check getAllUser Method"};
      }
      result = response.data;
    } catch (err) {
      result = {"error": err};
    }
    return result;
  }

  static Future<Map<String, dynamic>> getRoleOfUser() async {
    Map<String, dynamic> result;
    try {
      final response = await NetworkClient.dio.get("/get/user/role");
      if (response.statusCode != 200) {
        return result = {"message": "Error from get role"};
      }
      result = response.data;
    } catch (err) {
      result = {"error": err};
    }
    return result;
  }

  static Future<Map<String, dynamic>> createUser({
    String? name,
    String? phoneNumber,
    required String email,
    required String password,
    File? poster,
    int? roleId,
  }) async {
    Map<String, dynamic> result;
    try {
      final posterPath =
          poster == null ? null : await MultipartFile.fromFile(poster.path, filename: poster.path);
      final dataMap = FormData.fromMap({
        "poster": posterPath,
        "phone_number": phoneNumber,
        "email": email,
        "password": password,
        "name": name,
        "role_id": roleId,
      });
      final response = await NetworkClient.dio.post(
        "/create/user",
        data: dataMap,
      );
      result = response.data;
    } catch (err) {
      debugPrint("error create user $err");
      result = {"error": err};
    }
    return result;
  }

  static Future<Map<String, dynamic>> updateUser({
    required int? userId,
    String? name,
    String? email,
    String? phoneNumber,
    String? password,
    int? roleId,
    required File? file,
  }) async {
    Map<String, dynamic> result = {};
    try {
      final posterPath =
          file == null ? null : await MultipartFile.fromFile(file.path, filename: file.path);
      final params = FormData.fromMap({
        "poster": posterPath,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "password": password,
        "role_id": roleId,
      });
      final response = await NetworkClient.dio.post("/update/$userId", data: params,
          onSendProgress: (int sent, int total) {
        debugPrint("$sent $total");
      });
      debugPrint("result: $response");
      if (response.statusCode != 200) return {"serverError": true};

      result = response.data;
    } catch (err) {
      debugPrint("update error: $err");
      result = {"error": err};
    }
    return result;
  }

  static Future<void> removeUser({required int? id}) async {
    final response = await NetworkClient.dio.delete("/delete/user/$id");
    debugPrint("${response.data}");
    if (response.statusCode != 200) {
      debugPrint("dropped user exception");
    }

    if (response.statusCode == 200) {
      debugPrint("${response.data}");
    }
  }
}
