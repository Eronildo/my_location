import '../exceptions/location_feature_exception.dart';
import '../models/location_history.dart';
import '../models/location_history_list.dart';
import 'location_history_mapper.dart';

const _locationHistoriesMapKey = 'locationHistories';

/// A [LocationHistoryList] Mapper.
sealed class LocationHistoryListMapper {
  /// Create [LocationHistoryList] model from a [Map]
  ///
  /// Can throws a [MapperException].
  static LocationHistoryList fromMap(Map<String, dynamic> map) {
    _checkIfMapContainsKeys(map);

    final locationHistories = _getAndCheckIfValuesIsRightType(map);

    return LocationHistoryList(locationHistories: locationHistories);
  }

  static void _checkIfMapContainsKeys(Map<String, dynamic> map) {
    if (!map.containsKey(_locationHistoriesMapKey)) {
      throw NoKeyException(mapKey: _locationHistoriesMapKey);
    }
  }

  static List<LocationHistory> _getAndCheckIfValuesIsRightType(
    Map<String, dynamic> map,
  ) {
    final locationHistories = map[_locationHistoriesMapKey];

    if (locationHistories is! List) {
      throw WrongMapTypeException(
        mapKey: _locationHistoriesMapKey,
        valueType: List<Map<String, dynamic>>,
      );
    }

    return List<LocationHistory>.from(
      locationHistories.map(
        (history) =>
            LocationHistoryMapper.fromMap(history as Map<String, dynamic>),
      ),
    );
  }

  /// Serialize [LocationHistoryList] in a Map object.
  static Map<String, dynamic> toMap(LocationHistoryList locationHistoryList) =>
      {
        _locationHistoriesMapKey: locationHistoryList.locationHistories
            .map(LocationHistoryMapper.toMap)
            .toList(),
      };
}
