import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:my_location/core/atomic_state/app_atom.dart';
import 'package:my_location/core/exceptions/app_exception.dart';
import 'package:my_location/core/exceptions/location_exception.dart';
import 'package:my_location/features/location/atomic_state/location_atoms.dart';
import 'package:my_location/features/location/models/coordinates.dart';
import 'package:my_location/features/location/models/location_history.dart';
import 'package:my_location/features/location/models/location_history_list.dart';
import 'package:my_location/features/location/view/pages/location_page.dart';
import 'package:my_location/features/location/view/widgets/location_history/location_history_modal/location_history_modal_widget.dart';
import 'package:my_location/features/location/view/widgets/location_history/location_history_widget.dart';

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
  initializeDateFormatting();

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

  group('Location History List', () {
    testWidgets(
      'given a Location Page when history list button be called '
      'should show a Location History Modal Widget in a Bottom Sheet',
      (tester) async {
        // Arrange:
        await tester.pumpLocationPage();
        final historyListButton = find.byIcon(Icons.history);

        // Act:
        await tester.tap(historyListButton);
        await tester.pump();

        // Assert:
        expect(find.byType(LocationHistoryModalWidget), findsOneWidget);
      },
    );

    testWidgets(
      'given a Location History Modal when close button be called '
      'should modal close',
      (tester) async {
        // Arrange:
        await tester.pumpLocationPage();
        final historyListButton = find.byIcon(Icons.history);

        // Act:
        await tester.tap(historyListButton);
        await tester.pump();

        // Assert:
        expect(find.byType(LocationHistoryModalWidget), findsOneWidget);

        // Act:
        final closeButton = find.text('Close');
        await tester.ensureVisible(closeButton);
        await tester.pumpAndSettle();
        await tester.tap(closeButton);
        await tester.pumpAndSettle();

        // Assert:
        expect(find.byType(LocationHistoryModalWidget), findsNothing);
      },
    );

    testWidgets(
      'given a Location History Modal when IconButton be tapped '
      'should go to location action be called and modal close',
      (tester) async {
        // Arrange:
        final mockLocationHistory = LocationHistory(
          historyDate: DateTime.now(),
          coordinates: Coordinates.empty(),
        );
        final mockLocationHistoryList =
            LocationHistoryList(locationHistories: [mockLocationHistory]);
        locationHistoryListState.setValue(mockLocationHistoryList);
        await tester.pumpLocationPage();
        final historyListButton = find.byIcon(Icons.history);

        // Act:
        await tester.tap(historyListButton);
        await tester.pump();

        // Assert:
        expect(find.byType(LocationHistoryModalWidget), findsOneWidget);
        expect(find.byType(LocationHistoryWidget), findsOneWidget);

        // Act:
        final historyButton = find.byIcon(Icons.location_pin);
        expect(historyButton, findsOneWidget);
        await tester.ensureVisible(historyButton);
        await tester.pumpAndSettle();
        await tester.tap(historyButton);
        await tester.pumpAndSettle();

        // Assert:
        expect(goToLocationAction.value, mockLocationHistory.coordinates);
        expect(find.byType(LocationHistoryModalWidget), findsNothing);
      },
    );
  });
}
