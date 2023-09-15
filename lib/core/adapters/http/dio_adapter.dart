import 'dart:io';

import 'package:dio/dio.dart';

import '../../config/env/environment.dart';
import '../../exceptions/app_exception.dart';
import '../../models/http_response.dart';
import 'http_adapter.dart';
import 'interceptors/logging_interceptor.dart';

/// A HTTP adpter implementation using the Dio plugin
///
/// See https://pub.dev/packages/dio.
class DioAdapter implements HttpAdapter {
  /// Creates new instance of [DioAdapter]
  ///
  /// Can override a [Dio] instance in [dioOverride] if needed.
  DioAdapter({Dio? dioOverride}) {
    dio = dioOverride ?? Dio(baseOptions);
    dio.interceptors.add(LoggingInterceptor());
  }

  /// The Dio Http client.
  late final Dio dio;

  /// The Dio base options.
  BaseOptions get baseOptions => BaseOptions(
        headers: baseHeaders,
        baseUrl: baseUrl,
      );

  @override
  String get baseUrl => Environment.apiUrl;

  @override
  Map<String, String> baseHeaders = {
    HttpHeaders.acceptHeader: Headers.jsonContentType,
    HttpHeaders.contentTypeHeader: Headers.jsonContentType,
  };

  @override
  Future<HttpResponse<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final response = await dio.get<T>(
      endpoint,
      queryParameters: queryParameters,
      options: Options(
        headers: headers ?? baseHeaders,
      ),
    );

    final data = response.data;

    if (data == null || response.statusCode != HttpStatus.ok) {
      throw HttpException(
        statusCode: response.statusCode,
        message: response.statusMessage,
      );
    }

    return HttpResponse<T>(
      data: data,
      statusCode: response.statusCode,
    );
  }

  @override
  Future<HttpResponse<T>> post<T>(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    final response = await dio.post<T>(
      endpoint,
      data: data,
      options: Options(
        headers: headers ?? baseHeaders,
      ),
    );

    final responseData = response.data;

    if (responseData == null || response.statusCode != HttpStatus.ok) {
      throw HttpException(
        statusCode: response.statusCode,
        message: response.statusMessage,
      );
    }

    return HttpResponse<T>(
      data: responseData,
      statusCode: response.statusCode,
    );
  }

  @override
  Future<HttpResponse<T>> delete<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final response = await dio.delete<T>(
      endpoint,
      queryParameters: queryParameters,
      options: Options(
        headers: headers ?? baseHeaders,
      ),
    );

    final data = response.data;

    if (data == null || response.statusCode != HttpStatus.ok) {
      throw HttpException(
        statusCode: response.statusCode,
        message: response.statusMessage,
      );
    }

    return HttpResponse<T>(
      data: data,
      statusCode: response.statusCode,
    );
  }

  @override
  Future<HttpResponse<T>> put<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final response = await dio.put<T>(
      endpoint,
      queryParameters: queryParameters,
      options: Options(
        headers: headers ?? baseHeaders,
      ),
    );

    final data = response.data;

    if (data == null || response.statusCode != HttpStatus.ok) {
      throw HttpException(
        statusCode: response.statusCode,
        message: response.statusMessage,
      );
    }

    return HttpResponse<T>(
      data: data,
      statusCode: response.statusCode,
    );
  }
}
