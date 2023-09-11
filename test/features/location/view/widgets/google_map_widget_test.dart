import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_location/features/location/atomic_state/location_atoms.dart';
import 'package:my_location/features/location/view/widgets/google_map_widget.dart';

void main() {
  testWidgets(
    'given a google map widget when set a google marker should render'
    ' a GoogleMap widget',
    (tester) async {
      // Arrange:
      await tester.pumpWidget(
        const MaterialApp(
          home: GoogleMapWidget(),
        ),
      );
      await tester.pump();

      // Act:
      googleMapMarkersState
          .setValue({const Marker(markerId: MarkerId('user'))});

      // Assert:
      expect(find.byType(GoogleMap), findsOneWidget);
    },
  );
}
