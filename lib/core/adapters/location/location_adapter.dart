/// Location Service Adapter
///
/// Abstract class to GPS Location Service.
abstract interface class LocationAdapter {
  /// Check if location service is enabled.
  Future<bool> get isLocationEnabled;

  /// Get current location
  ///
  /// Returns a [Record] with latitude and longitude.
  Future<(double latitude, double longitude)> get currentLocation;
}
