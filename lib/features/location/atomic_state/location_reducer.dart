import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/extensions/result_extension.dart';
import '../../../core/services/location_service.dart';
import '../../../core/utils/atomic_state/reducer.dart';
import '../models/coordinates.dart';
import '../models/location_history.dart';
import '../models/location_history_list.dart';
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
    on(loadLocationHistoryListAction, _loadLocationHistoryList);
    on(goToLocationAction, _goToCoordinatesAndPinOnMap);
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
            _saveLocationHistoryAndUpdateLocationOnMap(coordinates);
          },
        );
      },
      _saveLocationHistoryAndUpdateLocationOnMap,
    );
  }

  FutureOr<void> _loadLocationHistoryList(_) {
    final locationHistoryList = _locationRepository.getLocationHistoryList();
    locationHistoryListState.setValue(locationHistoryList);
  }

  FutureOr<void> _goToCoordinatesAndPinOnMap(Coordinates coordinates) async {
    final latLng = _createLatLngFromCoordinates(coordinates);
    _setLocationPinOnMap(latLng);
    await _goToLocationOnMap(latLng);
  }

  Future<void> _saveLocationHistoryAndUpdateLocationOnMap(
    Coordinates coordinates,
  ) async {
    if (!coordinates.isEmpty) {
      _saveLocationHistory(coordinates);
      await _goToCoordinatesAndPinOnMap(coordinates);
    }
  }

  LatLng _createLatLngFromCoordinates(Coordinates coordinates) => LatLng(
        coordinates.latitude,
        coordinates.longitude,
      );

  void _setLocationPinOnMap(LatLng latLng) {
    googleMapMarkersState.setValue({
      Marker(
        markerId: const MarkerId('user'),
        position: latLng,
      ),
    });
  }

  Future<void> _goToLocationOnMap(LatLng latLng) async {
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

  void _saveLocationHistory(Coordinates coordinates) {
    final locationHistory = LocationHistory.fromCoordinates(coordinates);

    final (isLocationAdded, newLocationHistoryList) =
        _tryAddLocationHistory(locationHistory);

    if (isLocationAdded) {
      _locationRepository.saveLocationHistoryList(newLocationHistoryList);
      locationHistoryListState.setValue(newLocationHistoryList);
    }
  }

  (bool isLocationAdded, LocationHistoryList locationHistoryList)
      _tryAddLocationHistory(
    LocationHistory locationHistory,
  ) {
    final locationHistoryList = locationHistoryListState.value;
    final locationHistories = locationHistoryList.locationHistories;
    final containsLocationHistory = locationHistories.contains(locationHistory);
    if (!containsLocationHistory) {
      final newHistories = <LocationHistory>[
        ...locationHistories,
        locationHistory,
      ]..sort((a, b) => b.historyDate.compareTo(a.historyDate));
      return (true, LocationHistoryList(locationHistories: newHistories));
    }

    return (false, locationHistoryList);
  }
}
