import 'package:geolocator/geolocator.dart';

import '../../exceptions/location_exception.dart';
import 'location_adapter.dart';

/// Implementation of [LocationAdapter] with [Geolocator] plugin
///
/// See https://pub.dev/packages/geolocator.
class GeolocatorAdapter implements LocationAdapter {
  @override
  Future<bool> get isLocationEnabled async {
    return Geolocator.isLocationServiceEnabled();
  }

  @override
  Future<(double, double)> get currentLocation async {
    await _checkPermission();

    final position = await Geolocator.getCurrentPosition();

    return (position.latitude, position.longitude);
  }

  Future<void> _checkPermission() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationDeniedException();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationDeniedForeverException();
    }
  }
}
