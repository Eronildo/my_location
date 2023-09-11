import 'package:flutter_test/flutter_test.dart';
import 'package:my_location/core/adapters/location/geolocator_adapter.dart';
import 'package:my_location/core/exceptions/location_exception.dart';

import 'mock_geolocator_plugin.dart';

void main() {
  late GeolocatorAdapter geolocatorAdapter;

  setUp(() {
    geolocatorAdapter = GeolocatorAdapter();
  });

  group('isLocationEnabled', () {
    test(
      'given location enabled when isLocationEnabled be called '
      'should expect true',
      () async {
        // Arrange:
        mockGeolocatorPlugin();

        // Act:
        final isLocationEnabled = await geolocatorAdapter.isLocationEnabled;

        // Assert:
        expect(isLocationEnabled, isTrue);
      },
    );
  });

  group('currentLocation', () {
    test(
      'given all permission granted when currentLocation be called '
      'should expect (latitude: 1.0, longitude: 1.0)',
      () async {
        // Arrange:
        mockGeolocatorPlugin();

        // Act:
        final location = await geolocatorAdapter.currentLocation;

        // Assert:
        expect(location, (1.0, 1.0));
      },
    );

    test(
      'given checkPermission and requestPermission denied when currentLocation '
      'be called should throws a LocationDeniedException',
      () {
        // Arrange:
        mockGeolocatorPlugin(
          checkPermissionResult: locationPermissionDenied,
          requestPermissionResult: locationPermissionDenied,
        );

        // Act:
        final future = geolocatorAdapter.currentLocation;

        // Assert:
        expect(
          future,
          throwsA(isA<LocationDeniedException>()),
        );
      },
    );

    test(
      'given checkPermission forever denied when currentLocation be called '
      'should throws a LocationDeniedForeverException',
      () {
        // Arrange:
        mockGeolocatorPlugin(
          checkPermissionResult: locationPermissionDeniedForever,
        );

        // Act:
        final future = geolocatorAdapter.currentLocation;

        // Assert:
        expect(
          future,
          throwsA(isA<LocationDeniedForeverException>()),
        );
      },
    );
  });
}
