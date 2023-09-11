import 'dart:developer';

import 'package:dio/dio.dart';

/// Dio Logging Interceptor
///
/// Used to log http requests, responses and http exceptions.
class LoggingInterceptor implements Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('Dio Exception!', error: err);
    log('Url: ${err.requestOptions.uri}');
    log('${err.stackTrace}');
    log('Response Errors: ${err.response?.data}');

    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('Request: ${options.method} ${options.baseUrl}${options.path}');

    return handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    log('Response ${response.statusCode}: '
        '${response.requestOptions.method} ${response.requestOptions.path}');

    return handler.next(response);
  }
}
