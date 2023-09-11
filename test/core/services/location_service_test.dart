import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_location/core/adapters/location/location_adapter.dart';
import 'package:my_location/core/exceptions/location_exception.dart';
import 'package:my_location/core/extensions/result_extension.dart';
import 'package:my_location/core/services/location_service.dart';
import 'package:my_location/features/location/models/coordinates.dart';

class MockLocationAdapter extends Mock implements LocationAdapter {}

void main() {
  final mockLocationAdapter = MockLocationAdapter();
  final locationService = LocationService(locationAdapter: mockLocationAdapter);

  setUp(
    () => when(() => mockLocationAdapter.isLocationEnabled)
        .thenAnswer((invocation) async => true),
  );

  test(
    'given isLocationEnabled enabled and (0.0, 0.0) when '
    'getCoordinatesByGPS be called should return a success result',
    () async {
      // Arrange:
      when(() => mockLocationAdapter.currentLocation)
          .thenAnswer((invocation) async => (0.0, 0.0));

      // Act:
      final result = await locationService.getCoordinatesByGPS();

      // Assert:
      expect(result.isSuccess(), isTrue);
      expect(result.tryGetSuccess(), Coordinates.empty());
    },
  );

  test(
    'given isLocationEnabled disabled when getCoordinatesByGPS be called '
    'should return a failure with LocationUnavailableException',
    () async {
      // Arrange:
      when(() => mockLocationAdapter.isLocationEnabled)
          .thenAnswer((invocation) async => false);

      // Act:
      final result = await locationService.getCoordinatesByGPS();

      // Assert:
      expect(result.isFailure(), isTrue);
      expect(result.tryGetFailure(), LocationUnavailableException());
    },
  );

  test(
    'given currentLocation throws exception when getCoordinatesByGPS be called '
    'should return a failure with LocationDeniedException',
    () async {
      // Arrange:
      when(() => mockLocationAdapter.currentLocation)
          .thenThrow(LocationDeniedException());

      // Act:
      final result = await locationService.getCoordinatesByGPS();

      // Assert:
      expect(result.isFailure(), isTrue);
      expect(result.tryGetFailure(), LocationDeniedException());
    },
  );
}
