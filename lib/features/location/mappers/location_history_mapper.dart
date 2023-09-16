import '../exceptions/location_feature_exception.dart';
import '../models/coordinates.dart';
import '../models/location_history.dart';
import 'coordinates_mapper.dart';

const _historyDateMapKey = 'historyDate';
const _coordinatesMapKey = 'coordinates';

/// A [LocationHistory] Mapper.
sealed class LocationHistoryMapper {
  /// Create [LocationHistory] from [Map]
  ///
  /// Can throws a [MapperException].
  static LocationHistory fromMap(Map<String, dynamic> map) {
    _checkIfMapContainsKeys(map);

    final (historyDate, coordinates) = _getAndCheckIfValuesIsRightType(map);

    return LocationHistory(historyDate: historyDate, coordinates: coordinates);
  }

  static void _checkIfMapContainsKeys(Map<String, dynamic> map) {
    if (!map.containsKey(_historyDateMapKey)) {
      throw NoKeyException(mapKey: _historyDateMapKey);
    } else if (!map.containsKey(_coordinatesMapKey)) {
      throw NoKeyException(mapKey: _coordinatesMapKey);
    }
  }

  static (DateTime, Coordinates) _getAndCheckIfValuesIsRightType(
    Map<String, dynamic> map,
  ) {
    final historyDate = map[_historyDateMapKey];
    final coordinates = map[_coordinatesMapKey];

    if (historyDate is! int) {
      throw WrongMapTypeException(
        mapKey: _historyDateMapKey,
        valueType: int,
      );
    } else if (coordinates is! Map<String, dynamic>) {
      throw WrongMapTypeException(
        mapKey: _coordinatesMapKey,
        valueType: Map<String, dynamic>,
      );
    }

    return (
      DateTime.fromMillisecondsSinceEpoch(historyDate),
      CoordinatesMapper.fromMap(coordinates),
    );
  }

  /// Create [LocationHistory] from [Coordinates].
  static LocationHistory fromCoordinates(Coordinates coordinates) =>
      LocationHistory(historyDate: DateTime.now(), coordinates: coordinates);

  /// Serialize [LocationHistory] in a [Map] object.
  static Map<String, dynamic> toMap(LocationHistory locationHistory) => {
        _historyDateMapKey: locationHistory.historyDate.millisecondsSinceEpoch,
        _coordinatesMapKey:
            CoordinatesMapper.toMap(locationHistory.coordinates),
      };
}
