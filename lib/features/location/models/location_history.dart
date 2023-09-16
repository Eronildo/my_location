import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'coordinates.dart';

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

  /// [DateTime] of [LocationHistory].
  final DateTime historyDate;

  /// [Coordinates] model.
  final Coordinates coordinates;

  @override
  List<Object?> get props => [coordinates];
}
