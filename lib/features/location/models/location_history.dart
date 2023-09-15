import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'coordinates.dart';

const _historyDateMapKey = 'historyDate';
const _coordinatesMapKey = 'coordinates';

/// [LocationHistory] model
///
/// Composed by [historyDate] and [coordinates] attributes.
@immutable
class LocationHistory extends Equatable {
  /// [LocationHistory] constructor.
  const LocationHistory({
    required this.historyDate,
    required this.coordinates,
  });

  /// Create [LocationHistory] from [Coordinates].
  factory LocationHistory.fromCoordinates(Coordinates coordinates) =>
      LocationHistory(historyDate: DateTime.now(), coordinates: coordinates);

  /// Create [LocationHistory] from [Map].
  factory LocationHistory.fromMap(Map<String, dynamic> map) {
    if (!map.containsKey(_historyDateMapKey) ||
        !map.containsKey(_coordinatesMapKey)) {
      return LocationHistory.empty();
    }

    final historyDate = map[_historyDateMapKey];
    final coordinates = map[_coordinatesMapKey];

    if (historyDate is! int || coordinates is! Map<String, dynamic>) {
      return LocationHistory.empty();
    }

    return LocationHistory(
      historyDate: DateTime.fromMillisecondsSinceEpoch(historyDate),
      coordinates: Coordinates.fromMap(coordinates),
    );
  }

  /// Create empty [LocationHistory].
  factory LocationHistory.empty() => LocationHistory(
        historyDate: DateTime.now(),
        coordinates: Coordinates.empty(),
      );

  /// [DateTime] of [LocationHistory].
  final DateTime historyDate;

  /// [Coordinates] model.
  final Coordinates coordinates;

  @override
  List<Object?> get props => [coordinates];

  /// Serialize [LocationHistory] in a Map object.
  Map<String, dynamic> toMap() {
    return {
      _historyDateMapKey: historyDate.millisecondsSinceEpoch,
      _coordinatesMapKey: coordinates.toMap(),
    };
  }
}
