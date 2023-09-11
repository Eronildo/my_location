import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/extensions/result_extension.dart';
import '../../../core/services/location_service.dart';
import '../../../core/utils/atomic_state/reducer.dart';
import '../models/coordinates.dart';
import '../repository/location_repository.dart';
import 'location_atoms.dart';

const _googleMapCameraPositionZoom = 19.0;

/// Location Reducer is a business logic class
///
/// Subscribe all atoms/actions and update the atoms state.
class LocationReducer extends Reducer {
  /// [LocationReducer] constructor.
  LocationReducer({
    required LocationService locationService,
    required LocationRepository locationRepository,
  })  : _locationRepository = locationRepository,
        _locationService = locationService {
    on(getMyLocationAction, _getMyLocation);
  }

  /// Location Service to retrive [Coordinates] via GPS.
  final LocationService _locationService;

  /// Location Repository to retrive [Coordinates] via API.
  final LocationRepository _locationRepository;

  FutureOr<void> _getMyLocation(_) async {
    final result = await _locationService.getCoordinatesByGPS();
    await result.fold(
      (failure) async {
        final result = await _locationRepository.getCoordinatesByHttp();
        result.fold(
          locationExceptionState.setValue,
          (coordinates) {
            locationExceptionState.setValue(failure);
            _updateGoogleMap(coordinates);
          },
        );
      },
      _updateGoogleMap,
    );
  }

  Future<void> _updateGoogleMap(Coordinates coordinates) async {
    if (!coordinates.isEmpty) {
      final latLng = LatLng(
        coordinates.latitude,
        coordinates.longitude,
      );

      googleMapMarkersState.setValue({
        Marker(
          markerId: const MarkerId('user'),
          position: latLng,
        ),
      });

      final googleMapController = await googleMapCompleterState.value.future;
      await googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: latLng,
            zoom: _googleMapCameraPositionZoom,
          ),
        ),
      );
    }
  }
}
