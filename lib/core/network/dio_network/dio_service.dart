import 'package:dio/dio.dart';

import '../apiConsumer.dart';
import '../api_error.dart';

class DioService implements ApiConsumer {
  final Dio dio;

  DioService({required this.dio});

  @override
  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(path,
          queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  @override
  Future post(String path,
      {Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final res =
          await dio.post(path, data: data, queryParameters: queryParameters);
      return res.data;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }
  @override
  Future put(String path,
      {Map<String, dynamic>? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.put(path, data: data, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  @override
  Future delete(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.delete(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }
}