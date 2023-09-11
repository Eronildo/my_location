import 'dart:async';

import '../adapters/network/network_adapter.dart';
import '../adapters/network/network_status.dart';
import '../utils/atomic_state/reducer.dart';
import 'app_atom.dart';

/// App Reducer.
class AppReducer extends Reducer {
  /// [AppReducer] constructor.
  AppReducer({
    required NetworkAdapter networkAdapter,
  }) : _networkAdapter = networkAdapter {
    _networkStatusSubscription =
        _networkAdapter.onStatusChange.listen(_listenNetworkStatusChange);
  }

  final NetworkAdapter _networkAdapter;

  late StreamSubscription<NetworkStatus> _networkStatusSubscription;

  void _listenNetworkStatusChange(NetworkStatus event) {
    switch (event) {
      case NetworkStatus.connected:
        isInternetConnectedState.setValue(true);
      case NetworkStatus.disconnected:
        isInternetConnectedState.setValue(false);
    }
  }

  @override
  void dispose() {
    _networkStatusSubscription.cancel();
    super.dispose();
  }
}
