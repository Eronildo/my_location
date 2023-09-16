import 'package:equatable/equatable.dart';

import '../../../core/exceptions/app_exception.dart';

/// Location Feature base exception.
sealed class LocationFeatureException extends Equatable implements Exception {
  @override
  List<Object?> get props => [];
}

/// [NoInternetException] for location feature.
class LocationNoInternetException extends NoInternetException
    implements LocationFeatureException {}

/// [HttpException] for location feature.
class LocationHttpException extends HttpException
    implements LocationFeatureException {
  /// Create a [LocationHttpException]
  ///
  /// Requires [statusCode], [message] and [stackTrace].
  LocationHttpException({
    required super.statusCode,
    required super.message,
    required super.stackTrace,
  });
}

/// [MapperException] for Mappers of location feature.
base class MapperException extends LocationFeatureException {
  /// Create a [MapperException]
  ///
  /// Required a [mapKey].
  MapperException({
    required this.mapKey,
  });

  /// A key of [Map].
  final String mapKey;

  @override
  String toString() {
    return 'MapperException: $mapKey';
  }
}

/// Throws when the [Map] no contains a [mapKey].
final class NoKeyException extends MapperException {
  /// Create a [NoKeyException]
  ///
  /// Requires a [mapKey].
  NoKeyException({required super.mapKey});

  @override
  String toString() {
    return 'Not contains $mapKey key';
  }

  @override
  List<Object?> get props => [mapKey];
}

/// Throws when the [Map]'s value has a type different of [valueType].
final class WrongMapTypeException extends MapperException {
  /// Create a [WrongMapTypeException]
  ///
  /// Requires a [mapKey] and a [valueType].
  WrongMapTypeException({required super.mapKey, required this.valueType});

  /// A value [Type] of [Map]'s [mapKey].
  final Type valueType;

  @override
  String toString() {
    return 'Key $mapKey is not $valueType';
  }

  @override
  List<Object?> get props => [mapKey, valueType];
}
