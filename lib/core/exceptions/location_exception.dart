import 'package:equatable/equatable.dart';

/// Location base exception.
sealed class LocationException extends Equatable implements Exception {
  @override
  List<Object?> get props => [];
}

/// [LocationUnavailableException]
///
/// Throws when location service is not available.
class LocationUnavailableException extends LocationException {}

/// [LocationDeniedException]
///
/// Throws when user denies location permission.
class LocationDeniedException extends LocationException {}

/// [LocationDeniedForeverException]
///
/// Throws when user denies location permission multiple times.
class LocationDeniedForeverException extends LocationException {}
