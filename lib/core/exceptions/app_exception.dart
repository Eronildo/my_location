import 'package:equatable/equatable.dart';

/// App base exception.
sealed class AppException extends Equatable implements Exception {
  @override
  List<Object?> get props => [];
}

/// [HttpException], throw when some server error happens.
class HttpException extends AppException {
  /// Create a Http Exception.
  HttpException({
    this.statusCode,
    this.message,
    this.stackTrace,
  });

  /// Exception StatusCode.
  final int? statusCode;

  /// Exception Message.
  final String? message;

  /// Stack Trace of [Exception].
  final StackTrace? stackTrace;

  @override
  List<Object?> get props => [statusCode, message];
}

/// [NoInternetException], throws when device is not connected.
class NoInternetException extends AppException {}
