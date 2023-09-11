import '../../features/location/models/coordinates.dart';
import '../adapters/location/location_adapter.dart';
import '../exceptions/location_exception.dart';
import '../utils/result.dart';

/// Device Location Service class.
class LocationService {
  /// Create the [LocationService]
  ///
  /// Requires a [LocationAdapter].
  LocationService({
    required LocationAdapter locationAdapter,
  }) : _locationAdapter = locationAdapter;

  final LocationAdapter _locationAdapter;

  /// Try get [Coordinates] by device's GPS.
  Future<Result<LocationException, Coordinates>> getCoordinatesByGPS() async {
    if (await _locationAdapter.isLocationEnabled) {
      try {
        final (latitude, longitude) = await _locationAdapter.currentLocation;

        return Success(Coordinates(latitude: latitude, longitude: longitude));
      } on LocationException catch (e) {
        return Failure(e);
      }
    } else {
      return Failure(LocationUnavailableException());
    }
  }
}
