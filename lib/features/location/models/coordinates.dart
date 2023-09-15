import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

const _emptyCoordinates = Coordinates(latitude: 0, longitude: 0);
const _latMapKey = 'lat';
const _lonMapKey = 'lon';

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

  /// Create [Coordinates] model from [Map].
  factory Coordinates.fromMap(Map<String, dynamic> map) {
    if (!map.containsKey(_latMapKey) || !map.containsKey(_lonMapKey)) {
      return Coordinates.empty();
    }

    final lat = map[_latMapKey];
    final lon = map[_lonMapKey];

    if (lat is! double || lon is! double) {
      return Coordinates.empty();
    }

    return Coordinates(latitude: lat, longitude: lon);
  }

  /// Create empty [Coordinates].
  factory Coordinates.empty() => _emptyCoordinates;

  /// Is [Coordinates] empty?
  bool get isEmpty => this == _emptyCoordinates;

  /// The latitude of [Coordinates].
  final double latitude;

  /// The longitude of [Coordinates].
  final double longitude;

  /// Serialize [Coordinates] in a Map object.
  Map<String, dynamic> toMap() => {
        _latMapKey: latitude,
        _lonMapKey: longitude,
      };

  @override
  List<Object?> get props => [latitude, longitude];
}
