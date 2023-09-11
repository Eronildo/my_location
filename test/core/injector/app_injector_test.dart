import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:my_location/core/adapters/http/dio_adapter.dart';
import 'package:my_location/core/adapters/http/http_adapter.dart';
import 'package:my_location/core/adapters/location/geolocator_adapter.dart';
import 'package:my_location/core/adapters/location/location_adapter.dart';
import 'package:my_location/core/adapters/network/internet_network_adapter.dart';
import 'package:my_location/core/adapters/network/network_adapter.dart';
import 'package:my_location/core/atomic_state/app_reducer.dart';
import 'package:my_location/core/injector/app_injector.dart';
import 'package:my_location/core/services/location_service.dart';
import 'package:my_location/features/location/atomic_state/location_reducer.dart';
import 'package:my_location/features/location/repository/location_repository.dart';

void main() {
  test(
    'given a dependency injections when setupAppInjector be called should '
    'inject all dependecies',
    () {
      // Act:
      setupAppInjector();

      // Assert:
      expect(GetIt.I.get<HttpAdapter>(), isA<DioAdapter>());
      expect(GetIt.I.get<LocationAdapter>(), isA<GeolocatorAdapter>());
      expect(GetIt.I.get<NetworkAdapter>(), isA<InternetNetworkAdapter>());
      expect(GetIt.I.get<AppReducer>(), isA<AppReducer>());
      expect(GetIt.I.get<LocationService>(), isA<LocationService>());
      expect(GetIt.I.get<LocationRepository>(), isA<LocationRepository>());
      expect(GetIt.I.get<LocationReducer>(), isA<LocationReducer>());
    },
  );
}
