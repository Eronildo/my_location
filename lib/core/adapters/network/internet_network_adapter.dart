import 'dart:async';
import 'dart:io';

import 'network_adapter.dart';
import 'network_status.dart';

const _defaultHost = 'google.com';
const _defaultInterval = Duration(seconds: 10);
const _defaultTimeoutDuration = Duration(seconds: 5);

/// A implementation of [NetworkAdapter].
class InternetNetworkAdapter implements NetworkAdapter {
  /// Create a [InternetNetworkAdapter]
  /// Default [timeout] is 5 seconds.
  InternetNetworkAdapter({
    this.host = _defaultHost,
    this.timeout = _defaultTimeoutDuration,
    this.checkInterval = _defaultInterval,
  }) {
    // Start sending status updates to onStatusChange when there are listeners
    // (emits only if there's any change since the last status update).
    _statusController
      ..onListen = _maybeEmitStatusUpdate

      // Stop sending status updates when no one is listening.
      ..onCancel = () {
        _timerHandle?.cancel();
        _lastStatus = null; // Reset last status.
      };
  }

  final _statusController = StreamController<NetworkStatus>.broadcast();

  NetworkStatus? _lastStatus = NetworkStatus.connected;
  Timer? _timerHandle;

  /// Host Url for lookup.
  final String host;

  /// Request Timeout Duration.
  final Duration timeout;

  /// The interval between periodic checks. Periodic checks are
  /// only made if there's an attached listener to [onStatusChange].
  /// If that's the case [onStatusChange] emits an update only if
  /// there's change from the previous status.
  ///
  /// Defaults to [_defaultInterval] (10 seconds).
  final Duration checkInterval;

  @override
  Future<bool> get isConnected async {
    try {
      final response = await InternetAddress.lookup(host).timeout(timeout);

      return response.isNotEmpty && response.first.rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    } on TimeoutException catch (_) {
      return false;
    }
  }

  FutureOr<void> _maybeEmitStatusUpdate([
    Timer? timer,
  ]) async {
    _timerHandle?.cancel();
    timer?.cancel();

    final currentStatus = await _connectionStatus;

    // Only send status update if last status differs from current
    // and if someone is actually listening.
    if (_lastStatus != currentStatus && _statusController.hasListener) {
      _statusController.add(currentStatus);
    }

    // Start new timer only if there are listeners.
    if (!_statusController.hasListener) return;
    _timerHandle = Timer(checkInterval, _maybeEmitStatusUpdate);

    // Update last status.
    _lastStatus = currentStatus;
  }

  Future<NetworkStatus> get _connectionStatus async {
    return await isConnected
        ? NetworkStatus.connected
        : NetworkStatus.disconnected;
  }

  @override
  Stream<NetworkStatus> get onStatusChange => _statusController.stream;
}
