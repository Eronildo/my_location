/// Response describes the http Response info.
final class HttpResponse<T> {
  /// Create a instance of [HttpResponse].
  HttpResponse({required this.data, this.statusCode});

  /// Response body.
  final T data;

  /// Http status code.
  final int? statusCode;
}
