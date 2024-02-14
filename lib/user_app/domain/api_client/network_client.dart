import 'dart:io';
import 'package:dio/dio.dart';

import '../../../configuration/configuration.dart';
import '../data_provider/session_data_provider.dart';
import 'api_client_exception.dart';

abstract class NetworkClient {
  static final sessionDataProvider = SessionDataProvider();
  static var session = '';
  static late Dio dio;

  static Future<void> initDio()async{
    dio = Dio(BaseOptions(baseUrl: Configuration.host, headers: {
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
      "Authorization": "Bearer ${await sessionDataProvider.getSessionId()}"
    }));
  }


  static Future<T> get<T>(String path,
      T Function(dynamic json) parser, [
        Map<String, dynamic>? parameters,
      ]) async {
    try {
      final response = await dio.get(path, data: parameters);
      final result = parser(response.data);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (error) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  static Future<T> post<T>(String path, T Function(dynamic json) parser,
      Map<String, dynamic>? bodyParameters,
      [Map<String, dynamic>? urlParameters]) async {
    try {
      final response = await dio.post(
          path, queryParameters: urlParameters, data: bodyParameters);
      _validateResponse(response);
      final token = parser(response.data);
      return token;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (error) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  static  void _validateResponse(response) {
    if (response.statusCode == 401) {
      throw ApiClientException(ApiClientExceptionType.auth);
    } else {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }
}
