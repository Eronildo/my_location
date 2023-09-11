import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../atomic_state/location_atoms.dart';

/// Wrapper of [GoogleMap] Widget.
class GoogleMapWidget extends StatelessWidget {
  /// [GoogleMapWidget] constructor.
  const GoogleMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<Marker>>(
      valueListenable: googleMapMarkersState,
      builder: (context, markers, child) => GoogleMap(
        initialCameraPosition: const CameraPosition(target: LatLng(0, 0)),
        onMapCreated: googleMapCompleterState.value.complete,
        markers: markers,
      ),
    );
  }
}
