import 'package:dson_adapter/dson_adapter.dart';
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

  /// Create [Coordinates] model with [DSON] plugin from a Json Map
  ///
  /// See https://pub.dev/packages/dson_adapter.
  factory Coordinates.fromJson(Map<String, dynamic> map) {
    return const DSON().fromJson(
      map,
      Coordinates.new,
      aliases: {
        Coordinates: {
          'latitude': 'lat',
          'longitude': 'lon',
        },
      },
    );
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
        'lat': latitude,
        'lon': longitude,
      };

  @override
  List<Object?> get props => [latitude, longitude];
}
