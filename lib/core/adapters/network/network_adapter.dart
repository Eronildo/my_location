import 'network_status.dart';

/// A [NetworkAdapter] interface.
abstract interface class NetworkAdapter {
  /// Verify if has internet connection.
  Future<bool> get isConnected;

  /// [NetworkStatus] Stream to listen changes.
  Stream<NetworkStatus> get onStatusChange;
}
