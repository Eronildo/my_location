import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_location/core/exceptions/app_exception.dart';
import 'package:my_location/core/exceptions/location_exception.dart';
import 'package:my_location/core/services/location_service.dart';
import 'package:my_location/core/utils/result.dart';
import 'package:my_location/features/location/atomic_state/location_atoms.dart';
import 'package:my_location/features/location/atomic_state/location_reducer.dart';
import 'package:my_location/features/location/models/coordinates.dart';
import 'package:my_location/features/location/models/location_history.dart';
import 'package:my_location/features/location/models/location_history_list.dart';
import 'package:my_location/features/location/repository/location_repository.dart';

class MockLocationService extends Mock implements LocationService {}

class MockLocationRepository extends Mock implements LocationRepository {}

class MockGoogleMapController extends Mock implements GoogleMapController {}

class FakeCameraUpdate extends Fake implements CameraUpdate {}

void main() {
  late final MockLocationService mockLocationService;
  late final MockLocationRepository mockLocationRepository;
  late final MockGoogleMapController mockGoogleMapController;
  late final LocationReducer locationReducer;

  const mockCoordinates = Coordinates(latitude: 1, longitude: 1);

  final mockLocationHistoryList = LocationHistoryList(
    locationHistories: [
      LocationHistory(
        historyDate: DateTime.now(),
        coordinates: mockCoordinates,
      ),
    ],
  );

  setUpAll(() {
    mockLocationService = MockLocationService();
    mockLocationRepository = MockLocationRepository();
    mockGoogleMapController = MockGoogleMapController();

    registerFallbackValue(FakeCameraUpdate());

    locationReducer = LocationReducer(
      locationService: mockLocationService,
      locationRepository: mockLocationRepository,
    );
  });

  tearDownAll(() => locationReducer.dispose());

  group('get my location', () {
    test(
      'given gps location when getMyLocationAction be called should set a pin',
      () {
        // Arrange:
        when(() => mockLocationService.getCoordinatesByGPS()).thenAnswer(
          (_) async => Success(mockCoordinates),
        );
        when(() => mockGoogleMapController.animateCamera(any()))
            .thenAnswer((_) async => {});

        // Act:
        final completer = Completer<MockGoogleMapController>();
        googleMapCompleterState.setValue(completer);
        completer.complete(mockGoogleMapController);
        getMyLocationAction();

        // Assert:
        Future.delayed(
          Duration.zero,
          () => expect(googleMapMarkersState.value, isNotEmpty),
        );
      },
    );

    test(
      'given no gps location and http success when getMyLocationAction be '
      'called should set a pin and set a location exception',
      () {
        // Arrange:
        when(() => mockLocationService.getCoordinatesByGPS()).thenAnswer(
          (_) async => Failure(LocationUnavailableException()),
        );
        when(() => mockLocationRepository.getCoordinatesByHttp()).thenAnswer(
          (_) async => Success(mockCoordinates),
        );

        // Act:
        getMyLocationAction();

        // Assert:
        Future.delayed(
          Duration.zero,
          () {
            expect(googleMapMarkersState.value, isNotEmpty);
            expect(
              locationExceptionState.value,
              LocationUnavailableException(),
            );
          },
        );
      },
    );

    test(
      'given no gps location and no connection when getMyLocationAction be '
      'called should set a location exception NoInternetException',
      () {
        // Arrange:
        when(() => mockLocationService.getCoordinatesByGPS()).thenAnswer(
          (_) async => Failure(LocationUnavailableException()),
        );
        when(() => mockLocationRepository.getCoordinatesByHttp()).thenAnswer(
          (_) async => Failure(NoInternetException()),
        );

        // Act:
        getMyLocationAction();

        // Assert:
        Future.delayed(
          Duration.zero,
          () {
            expect(locationExceptionState.value, NoInternetException());
          },
        );
      },
    );
  });

  group('location history list', () {
    test(
        'given a location history list when load location be called '
        'should update the state', () {
      // Arrange:
      when(() => mockLocationRepository.getLocationHistoryList())
          .thenReturn(mockLocationHistoryList);

      // Act:
      loadLocationHistoryListAction();

      // Assert:
      expect(locationHistoryListState.value, mockLocationHistoryList);
    });

    test(
        'given the same location aready in the list when update location be '
        'called should not save or add the data', () {
      // Arrange:
      locationHistoryListState.setValue(mockLocationHistoryList);
      when(() => mockLocationService.getCoordinatesByGPS()).thenAnswer(
        (_) async => Failure(LocationUnavailableException()),
      );
      when(() => mockLocationRepository.getCoordinatesByHttp()).thenAnswer(
        (_) async => Success(mockCoordinates),
      );

      // Act:
      getMyLocationAction();

      // Assert:
      Future.delayed(
        Duration.zero,
        () {
          expect(locationHistoryListState.value.locationHistories.length, 1);
        },
      );
    });
  });
}
