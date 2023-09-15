import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'location_history.dart';

const _locationHistoriesMapKey = 'locationHistories';

/// Wrapper for [locationHistories] list.
@immutable
class LocationHistoryList extends Equatable {
  /// [LocationHistoryList] constructor.
  const LocationHistoryList({
    required this.locationHistories,
  });

  /// Create [LocationHistoryList] model from a [Map].
  factory LocationHistoryList.fromMap(Map<String, dynamic> map) {
    if (!map.containsKey(_locationHistoriesMapKey)) {
      return LocationHistoryList.empty();
    }

    final locationHistories = map[_locationHistoriesMapKey];

    if (locationHistories is! List<Map<String, dynamic>>) {
      return LocationHistoryList.empty();
    }

    return LocationHistoryList(
      locationHistories: List<LocationHistory>.from(
        locationHistories.map(LocationHistory.fromMap),
      ),
    );
  }

  /// Create a empty [LocationHistoryList].
  factory LocationHistoryList.empty() =>
      const LocationHistoryList(locationHistories: []);

  /// List of [LocationHistory] model.
  final List<LocationHistory> locationHistories;

  /// Serialize [LocationHistoryList] in a Map object.
  Map<String, dynamic> toMap() {
    return {
      _locationHistoriesMapKey: locationHistories
          .map((locationHistory) => locationHistory.toMap())
          .toList(),
    };
  }

  @override
  List<Object?> get props => [locationHistories];
}
