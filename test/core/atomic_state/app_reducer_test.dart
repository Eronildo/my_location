import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_location/core/adapters/network/network_adapter.dart';
import 'package:my_location/core/adapters/network/network_status.dart';
import 'package:my_location/core/atomic_state/app_atom.dart';
import 'package:my_location/core/atomic_state/app_reducer.dart';

class MockNetworkAdapter extends Mock implements NetworkAdapter {}

void main() {
  test(
    'given a status connected when onStatusChange '
    'should set isInternetConnectedState true',
    () {
      // Arrange:
      final mockNetworkAdapter = MockNetworkAdapter();
      when(() => mockNetworkAdapter.onStatusChange)
          .thenAnswer((_) => Stream.value(NetworkStatus.connected));

      // Act:
      final appReducer = AppReducer(networkAdapter: mockNetworkAdapter);

      // Assert:
      Future.delayed(
        Duration.zero,
        () {
          expect(isInternetConnectedState.value, isTrue);
          appReducer.dispose();
        },
      );
    },
  );

  test(
    'given a status disconnected when onStatusChange '
    'should set isInternetConnectedState false',
    () {
      // Arrange:
      final mockNetworkAdapter = MockNetworkAdapter();
      when(() => mockNetworkAdapter.onStatusChange)
          .thenAnswer((_) => Stream.value(NetworkStatus.disconnected));

      // Act:
      final appReducer = AppReducer(networkAdapter: mockNetworkAdapter);

      // Assert:
      Future.delayed(
        Duration.zero,
        () {
          expect(isInternetConnectedState.value, isFalse);
          appReducer.dispose();
        },
      );
    },
  );
}
