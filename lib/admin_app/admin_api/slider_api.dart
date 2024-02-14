import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eGrocer/user_app/domain/api_client/network_client.dart';

class SliderApi {
  static Future<Map<String, dynamic>> getSliderPoster() async {
    Map<String, dynamic> result;
    try {
      final response = await NetworkClient.dio.get("/get/sliders");
      if (response.statusCode != 200) {
        return result = {"error message": "Slider get exception"};
      }

      result = response.data;
    } catch (err) {
      result = {"error message": err};
    }
    return result;
  }

  static Future<Map<String, dynamic>> addSliderPoster({
    required File? poster,
    String? startDate,
    String? expirationDate,
  }) async {
    Map<String, dynamic> result = {};
    try {
      final posterPath = poster != null ? await MultipartFile.fromFile(poster.path, filename: poster.path) : null;
      final dataMap = FormData.fromMap({
        "poster": posterPath,
        "start_date": startDate,
        "expiration_date": expirationDate,
      });
      final response = await NetworkClient.dio.post("/add/slider/poster", data: dataMap);

      if (response.statusCode != 200) {
        return result = {"error": "Server error can not get response"};
      }

      result = response.data;
    } catch (err) {
      result = {"error": err};
    }
    return result;
  }

  static Future<Map<String, dynamic>> updateSliderPoster({
    required int? id,
    File? poster,
    String? startDate,
    String? expirationDate,
  }) async {
    Map<String, dynamic> result = {};
    try {
      final posterPath = poster != null ? await MultipartFile.fromFile(poster.path, filename: poster.path) : null;
      final dataMap = FormData.fromMap({
        "poster": posterPath,
        "start_date": startDate,
        "expiration_date": expirationDate,
      });
      final response = await NetworkClient.dio.post("update/slider/poster/$id", data: dataMap);

      if (response.statusCode != 200) {
        return result = {"error": "Server error can not get response"};
      }

      result = response.data;
    } catch (err) {
      result = {"error": err};
    }
    return result;
  }

  static Future<Map<String, dynamic>> deleteSliderPoster({required int? id}) async {
    Map<String, dynamic> result = {};
    try {
      final response = await NetworkClient.dio.delete("delete/slider/poster/$id");
      if (response.statusCode != 200) {
        return result = {"error": "api exception error"};
      }

      result = response.data;
    } catch (err) {
      result = {"error": err};
    }
    return result;
  }
}
