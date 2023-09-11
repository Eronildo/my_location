import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_location/core/atomic_state/app_atom.dart';
import 'package:my_location/core/exceptions/app_exception.dart';
import 'package:my_location/core/exceptions/location_exception.dart';
import 'package:my_location/features/location/atomic_state/location_atoms.dart';
import 'package:my_location/features/location/view/pages/location_page.dart';

extension PumpLocationPage on WidgetTester {
  Future<void> pumpLocationPage() async {
    await pumpWidget(
      const MaterialApp(
        home: LocationPage(),
        localizationsDelegates: [
          AppLocalizations.delegate,
        ],
      ),
    );
    await pump();
  }
}

void main() {
  group('Internet Connected State', () {
    testWidgets(
      'given a location page when isInternetConnectedState be true should show '
      'a Connection established text in a SnackBar',
      (tester) async {
        // Arrange:
        await tester.pumpLocationPage();

        // Act:
        isInternetConnectedState.setValue(true);
        await tester.pump();

        // Assert:
        expect(find.text('Connection established'), findsOneWidget);
      },
    );

    testWidgets(
      'given a location page when isInternetConnectedState be false should show'
      ' a You are offline! text in a SnackBar',
      (tester) async {
        // Arrange:
        await tester.pumpLocationPage();

        // Act:
        isInternetConnectedState.setValue(false);
        await tester.pump();

        // Assert:
        expect(find.text('You are offline!'), findsOneWidget);
      },
    );
  });

  group('Location Exception State', () {
    testWidgets(
      'given a location page when locationExceptionState be '
      'NoInternetException should show a No connection text '
      'in a SnackBar and in a ConnectionStatusWidget',
      (tester) async {
        // Arrange:
        const twoTextCount = 2;
        await tester.pumpLocationPage();

        // Act:
        locationExceptionState.setValue(NoInternetException());
        await tester.pump();

        // Assert:
        expect(find.text('No connection'), findsNWidgets(twoTextCount));
      },
    );

    testWidgets(
      'given a location page when locationExceptionState be '
      'LocationUnavailableException should show a '
      'This is your approximate location text in a SnackBar',
      (tester) async {
        // Arrange:
        await tester.pumpLocationPage();

        // Act:
        locationExceptionState.setValue(LocationUnavailableException());
        await tester.pump();

        // Assert:
        expect(find.text('This is your approximate location.'), findsOneWidget);
      },
    );
  });
}
