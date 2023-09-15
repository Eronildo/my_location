import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/location/injector/location_injector.dart';
import '../adapters/http/dio_adapter.dart';
import '../adapters/http/http_adapter.dart';
import '../adapters/local_storage/local_storage_adapter.dart';
import '../adapters/local_storage/shared_preferences_adapter.dart';
import '../adapters/location/geolocator_adapter.dart';
import '../adapters/location/location_adapter.dart';
import '../adapters/network/internet_network_adapter.dart';
import '../adapters/network/network_adapter.dart';
import '../atomic_state/app_reducer.dart';

/// Setup App Dependency Injection.
void setupAppInjector(SharedPreferences sharedPreferences) {
  GetIt.I.registerSingleton<LocalStorageAdapter>(
    SharedPreferencesAdapter(sharedPreferences),
  );
  GetIt.I.registerSingleton<HttpAdapter>(DioAdapter());
  GetIt.I.registerSingleton<LocationAdapter>(GeolocatorAdapter());
  GetIt.I.registerSingleton<NetworkAdapter>(InternetNetworkAdapter());
  GetIt.I.registerSingleton<AppReducer>(
    AppReducer(
      networkAdapter: getIt<NetworkAdapter>(),
    ),
  );
  setupLocationInjector();
}
