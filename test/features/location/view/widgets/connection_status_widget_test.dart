import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_location/core/atomic_state/app_atom.dart';
import 'package:my_location/features/location/view/widgets/connection_status_widget.dart';

void main() {
  testWidgets(
    'given a ConnectionStatusWidget when set a isInternetConnectedState false '
    'should show a no connection text',
    (tester) async {
      // Arrange:
      await tester.pumpWidget(
        const MaterialApp(
          home: ConnectionStatusWidget(),
          localizationsDelegates: [
            AppLocalizations.delegate,
          ],
        ),
      );
      await tester.pump();

      // Act:
      isInternetConnectedState.setValue(false);
      await tester.pump();

      // Assert:
      expect(find.text('No connection'), findsOneWidget);
    },
  );
}
