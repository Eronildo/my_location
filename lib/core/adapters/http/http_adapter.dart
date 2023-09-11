import '../../models/http_response.dart';

/// Response Map Type.
typedef ResponseMapType = Map<String, dynamic>;

/// Http Adapter Interface.
abstract interface class HttpAdapter {
  /// Http base url.
  String get baseUrl;

  /// Http headers.
  Map<String, String> get baseHeaders;

  /// Http get request.
  Future<HttpResponse<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  /// Http post request.
  Future<HttpResponse<T>> post<T>(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  });

  /// Http put request.
  Future<HttpResponse<T>> put<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  /// Http delete request.
  Future<HttpResponse<T>> delete<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });
}
