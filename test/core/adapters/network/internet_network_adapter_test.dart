import 'package:flutter_test/flutter_test.dart';
import 'package:my_location/core/adapters/network/internet_network_adapter.dart';
import 'package:my_location/core/adapters/network/network_status.dart';

void main() {
  group('isConnected', () {
    test(
      'given a default host when isConnected be called should expect true',
      () async {
        // Arrange:
        final internetAdapter = InternetNetworkAdapter();

        // Act:
        final isConnected = await internetAdapter.isConnected;

        // Assert:
        expect(isConnected, isTrue);
      },
    );

    test(
      'given a wrong host when isConnected be called should expect false',
      () async {
        // Arrange:
        final internetAdapter = InternetNetworkAdapter(host: 'wrong_host');

        // Act:
        final isConnected = await internetAdapter.isConnected;

        // Assert:
        expect(isConnected, isFalse);
      },
    );

    test(
      'given timeout zero when isConnected be called should expect false',
      () async {
        // Arrange:
        final internetAdapter = InternetNetworkAdapter(timeout: Duration.zero);

        // Act:
        final isConnected = await internetAdapter.isConnected;

        // Assert:
        expect(isConnected, isFalse);
      },
    );
  });

  group('onStatusChange', () {
    test('given default host when onStatusChange should emits no status', () {
      // Arrange:
      final internetAdapter = InternetNetworkAdapter();

      // Act:
      // Assert:
      expectLater(
        internetAdapter.onStatusChange,
        emitsInOrder([]),
      );
    });

    test(
      'given a wrong host when onStatusChange should emits '
      'disconnected status ',
      () {
        // Arrange:
        final internetAdapter = InternetNetworkAdapter(host: 'any');

        // Act:
        // Assert:
        expectLater(
          internetAdapter.onStatusChange,
          emitsInOrder([NetworkStatus.disconnected]),
        );
      },
    );
  });
}
