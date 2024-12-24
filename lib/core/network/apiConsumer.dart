import 'package:dio/dio.dart';

abstract class ApiConsumer {
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters});
  Future<dynamic> post(String path,
      {Map<String, dynamic>? data, Map<String, dynamic>? queryParameters , Options? options} );

  Future<dynamic> put(String path,
      {Map<String, dynamic>? data, Map<String, dynamic>? queryParameters});
  Future<dynamic> delete(String path, {Map<String, dynamic>? queryParameters});
}
