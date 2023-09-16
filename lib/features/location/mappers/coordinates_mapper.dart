import '../exceptions/location_feature_exception.dart';
import '../models/coordinates.dart';

const _latMapKey = 'lat';
const _lonMapKey = 'lon';

/// A [Coordinates] Mapper.
sealed class CoordinatesMapper {
  /// Create [Coordinates] from [Map]
  ///
  /// Can throws a [MapperException].
  static Coordinates fromMap(Map<String, dynamic> map) {
    _checkIfMapContainsKeys(map);

    final (lat, lon) = _getAndCheckIfValuesIsRightType(map);

    return Coordinates(latitude: lat, longitude: lon);
  }

  static void _checkIfMapContainsKeys(Map<String, dynamic> map) {
    if (!map.containsKey(_latMapKey)) {
      throw NoKeyException(mapKey: _latMapKey);
    } else if (!map.containsKey(_lonMapKey)) {
      throw NoKeyException(mapKey: _lonMapKey);
    }
  }

  static (double, double) _getAndCheckIfValuesIsRightType(
    Map<String, dynamic> map,
  ) {
    final lat = map[_latMapKey];
    final lon = map[_lonMapKey];

    if (lat is! double) {
      throw WrongMapTypeException(mapKey: _latMapKey, valueType: double);
    } else if (lon is! double) {
      throw WrongMapTypeException(mapKey: _lonMapKey, valueType: double);
    }

    return (lat, lon);
  }

  /// Serialize [Coordinates] in a [Map] object.
  static Map<String, dynamic> toMap(Coordinates coordinates) => {
        _latMapKey: coordinates.latitude,
        _lonMapKey: coordinates.longitude,
      };
}
