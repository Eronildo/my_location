import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'location_history.dart';

/// Wrapper for [locationHistories] list.
@immutable
class LocationHistoryList extends Equatable {
  /// [LocationHistoryList] constructor.
  const LocationHistoryList({
    required this.locationHistories,
  });

  /// Create a empty [LocationHistoryList].
  factory LocationHistoryList.empty() =>
      const LocationHistoryList(locationHistories: []);

  /// List of [LocationHistory] model.
  final List<LocationHistory> locationHistories;

  @override
  List<Object?> get props => [locationHistories];
}
