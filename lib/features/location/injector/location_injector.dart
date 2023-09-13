import 'package:get_it/get_it.dart';

import '../../../core/adapters/http/http_adapter.dart';
import '../../../core/adapters/local_storage/local_storage_adapter.dart';
import '../../../core/adapters/location/location_adapter.dart';
import '../../../core/adapters/network/network_adapter.dart';
import '../../../core/services/location_service.dart';
import '../atomic_state/location_reducer.dart';
import '../repository/location_repository.dart';

/// GetIt Instance.
final getIt = GetIt.I;

/// Setup Dependency Injection for Location Feature.
void setupLocationInjector() {
  getIt
    ..registerSingleton<LocationService>(
      LocationService(locationAdapter: getIt<LocationAdapter>()),
    )
    ..registerSingleton<LocationRepository>(
      LocationRepository(
        httpAdapter: getIt<HttpAdapter>(),
        networkAdapter: getIt<NetworkAdapter>(),
        localStorageAdapter: getIt<LocalStorageAdapter>(),
      ),
    )
    ..registerSingleton<LocationReducer>(
      LocationReducer(
        locationService: getIt<LocationService>(),
        locationRepository: getIt<LocationRepository>(),
      ),
    );
}
