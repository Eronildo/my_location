import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_location/core/adapters/http/http_adapter.dart';
import 'package:my_location/core/adapters/local_storage/local_storage_adapter.dart';
import 'package:my_location/core/adapters/network/network_adapter.dart';
import 'package:my_location/core/exceptions/app_exception.dart';
import 'package:my_location/core/extensions/result_extension.dart';
import 'package:my_location/core/models/http_response.dart';
import 'package:my_location/features/location/models/coordinates.dart';
import 'package:my_location/features/location/models/location_history.dart';
import 'package:my_location/features/location/models/location_history_list.dart';
import 'package:my_location/features/location/repository/location_repository.dart';

class MockHttpApdater extends Mock implements HttpAdapter {}

class MockNetworkAdapter extends Mock implements NetworkAdapter {}

class MockLocalStorageAdapter extends Mock implements LocalStorageAdapter {}

void main() {
  final mockHttpAdapter = MockHttpApdater();
  final mockNetworkAdapter = MockNetworkAdapter();
  final mockLocalStorageAdapter = MockLocalStorageAdapter();
  final mockLocationHistoryList = LocationHistoryList(
    locationHistories: [
      LocationHistory(
        historyDate: DateTime.now(),
        coordinates: const Coordinates(latitude: 1, longitude: 1),
      ),
    ],
  );

  final locationRepository = LocationRepository(
    httpAdapter: mockHttpAdapter,
    networkAdapter: mockNetworkAdapter,
    localStorageAdapter: mockLocalStorageAdapter,
  );

  setUp(
    () => when(() => mockNetworkAdapter.isConnected)
        .thenAnswer((_) async => true),
  );

  group('getCoordinatesByHttp', () {
    group('success', () {
      test(
        'given connectivity and success response when getCoordinatesByHttp '
        'be called should return a success result with Coordinates',
        () async {
          // Arrange:
          when(
            () => mockHttpAdapter.get<ResponseMapType>(
              any(),
              queryParameters: any(
                named: 'queryParameters',
              ),
            ),
          ).thenAnswer(
            (_) async => HttpResponse(data: {'lat': 1.0, 'lon': 1.0}),
          );

          // Act:
          final result = await locationRepository.getCoordinatesByHttp();

          // Assert:
          expect(result.isSuccess(), isTrue);
          result.foldSuccess(
            (success) => expect(
              success,
              const Coordinates(latitude: 1, longitude: 1),
            ),
          );
        },
      );
    });

    group('failure', () {
      test(
        'given no connectivity when getCoordinatesByHttp '
        'be called should return a failure result with NoInternetException',
        () async {
          // Arrange:
          when(() => mockNetworkAdapter.isConnected)
              .thenAnswer((_) async => false);

          // Act:
          final result = await locationRepository.getCoordinatesByHttp();

          // Assert:
          expect(result.isFailure(), isTrue);
          result.foldFailure(
            (failure) => expect(
              failure,
              NoInternetException(),
            ),
          );
        },
      );

      test(
        'given connectivity but http throws exception when get coordinates '
        'be called should return a failure result with HttpException',
        () async {
          // Arrange:
          when(
            () => mockHttpAdapter.get<ResponseMapType>(
              any(),
              queryParameters: any(
                named: 'queryParameters',
              ),
            ),
          ).thenThrow(HttpException());

          // Act:
          final result = await locationRepository.getCoordinatesByHttp();

          // Assert:
          expect(result.isFailure(), isTrue);
          expect(
            result.tryGetFailure(),
            HttpException(),
          );
        },
      );

      test(
        'given connectivity but http throws exception when get coordinates '
        'be called should return a failure result with DioException',
        () async {
          // Arrange:
          when(
            () => mockHttpAdapter.get<ResponseMapType>(
              any(),
              queryParameters: any(
                named: 'queryParameters',
              ),
            ),
          ).thenThrow(DioException(requestOptions: RequestOptions()));

          // Act:
          final result = await locationRepository.getCoordinatesByHttp();

          // Assert:
          expect(result.isFailure(), isTrue);
          expect(
            result.tryGetFailure(),
            HttpException(),
          );
        },
      );
    });
  });

  group('LocationHistoryList', () {
    test(
        'given a location history list when save location be called should '
        'save the data in the local storage', () {
      when(() => mockLocalStorageAdapter.save(any(), any()))
          .thenAnswer((_) async => true);
      locationRepository.saveLocationHistoryList(mockLocationHistoryList);
      verify(
        () => mockLocalStorageAdapter.save(
          locationHistoriesKey,
          mockLocationHistoryList.toMap(),
        ),
      );
    });

    test(
        'given a location history key when location be called should return a '
        'location history list', () {
      when(() => mockLocalStorageAdapter.get(any()))
          .thenAnswer((invocation) => mockLocationHistoryList.toMap());

      final locationHistoryList = locationRepository.getLocationHistoryList();
      verify(
        () => mockLocalStorageAdapter.get(
          locationHistoriesKey,
        ),
      );
      expect(locationHistoryList, mockLocationHistoryList);
    });

    test(
        'given null from local storage when location be called should return '
        'a empty location history list', () {
      when(() => mockLocalStorageAdapter.get(any()))
          .thenAnswer((invocation) => null);

      final locationHistoryList = locationRepository.getLocationHistoryList();
      verify(
        () => mockLocalStorageAdapter.get(
          locationHistoriesKey,
        ),
      );
      expect(locationHistoryList, LocationHistoryList.empty());
    });
  });
}
