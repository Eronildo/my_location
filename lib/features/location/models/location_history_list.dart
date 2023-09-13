import 'package:dson_adapter/dson_adapter.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'coordinates.dart';
import 'location_history.dart';

/// Wrapper for [locationHistories] list.
@immutable
class LocationHistoryList extends Equatable {
  /// [LocationHistoryList] constructor.
  const LocationHistoryList({
    required this.locationHistories,
  });

  /// Create [LocationHistoryList] model with [DSON] plugin from a Json Map
  ///
  /// See https://pub.dev/packages/dson_adapter.
  factory LocationHistoryList.fromJson(Map<String, dynamic> map) {
    return const DSON().fromJson(
      map,
      LocationHistoryList.new,
      inner: {
        'locationHistories': ListParam<LocationHistory>(LocationHistory.new),
      },
      resolvers: [
        (key, value) {
          if (key == 'historyDate') {
            return DateTime.fromMillisecondsSinceEpoch(value as int);
          } else if (key == 'coordinates') {
            return Coordinates.fromJson(value as Map<String, dynamic>);
          }

          return value as Object;
        },
      ],
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
      'locationHistories': locationHistories
          .map((locationHistory) => locationHistory.toMap())
          .toList(),
    };
  }

  @override
  List<Object?> get props => [locationHistories];
}
