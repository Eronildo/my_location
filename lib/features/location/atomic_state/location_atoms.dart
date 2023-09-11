import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/utils/atomic_state/atom.dart';

// Atoms:
/// [GoogleMapController] Completer State.
final googleMapCompleterState =
    Atom<Completer<GoogleMapController>>(Completer<GoogleMapController>());

/// Google Map [Marker] Collection State.
final googleMapMarkersState = Atom<Set<Marker>>({});

/// Location Exception State.
final locationExceptionState = Atom<Exception?>(null);

// Actions:
/// Action to retrieve user Location and show in Google Map.
final getMyLocationAction = Atom.action();
