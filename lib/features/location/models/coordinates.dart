import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

const _emptyCoordinates = Coordinates(latitude: 0, longitude: 0);

/// [Coordinates] model
///
/// Composed by [latitude] and [longitude] attributes.
@immutable
class Coordinates extends Equatable {
  /// [Coordinates] main constructor.
  const Coordinates({
    required this.latitude,
    required this.longitude,
  });

  /// Create empty [Coordinates].
  factory Coordinates.empty() => _emptyCoordinates;

  /// Is [Coordinates] empty?
  bool get isEmpty => this == _emptyCoordinates;

  /// The latitude of [Coordinates].
  final double latitude;

  /// The longitude of [Coordinates].
  final double longitude;

  @override
  List<Object?> get props => [latitude, longitude];
}
