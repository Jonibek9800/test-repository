import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../configuration/configuration.dart';
import 'network_client.dart';

class AuthApiClient {
  Future<Map<String, dynamic>> auth({
    required email,
    required String password,
  }) async {
    Map<String, dynamic> result = {};
    try {
      final params = {"email": email, 'password': password};
      final sessionId = await NetworkClient.dio.post("/auth/login", queryParameters: params);
      debugPrint("session: $sessionId");
      if (sessionId.statusCode != 200) return {"serverError": true};

      result = sessionId.data;
    } catch (err) {
      debugPrint("auth error: $err");
      result["serverError"] = true;
    }
    return result;
  }

  Future<Map<String, dynamic>> updateUser(
      {required int? userId,
      String? name,
      String? email,
      String? phoneNumber,
      int? roleId,
      required File? file}) async {
    Map<String, dynamic> result = {};
    try {
      final posterPath =
          file == null ? null : await MultipartFile.fromFile(file.path, filename: file.path);
      final params = FormData.fromMap({
        "poster": posterPath,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
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

  Future<Map<String, dynamic>> createUser(
      {required name,
      required email,
      phoneNumber,
      required password,
      required confirmPassword}) async {
    Map<String, dynamic> result = {};
    try {
      final params = {
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "password": password,
        "confirm_password": confirmPassword
      };
      final response = await NetworkClient.dio.post("/auth/register", queryParameters: params);
      if (response.statusCode != 200) return {"serverError": true};
      result = response.data;
    } catch (err) {
      result = {"error": err};
    }
    return result;
  }

  Future<String> logout() async {
    final response = await NetworkClient.dio.get("/logout");

    return response.data['message'];
  }

  Future<Map<String, dynamic>?> getToken() async {
    Map<String, dynamic>? result;
    try {
      final params = await NetworkClient.dio.get("/get/token");

      if (params.statusCode != 200) return {"serverError": true};
      Map<String, dynamic> json = params.data;
      if (json.containsKey('user')) {
        result = {"user": params.data['user']};
      }
    } catch (err) {
      result = {"error": err};
    }
    return result;
  }

  String getUserImage(String? image) {
    return "${Configuration.host}/get/user/image/$image";
  }
}
