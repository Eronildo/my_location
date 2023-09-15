import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/utils/atomic_state/atom.dart';
import '../models/coordinates.dart';
import '../models/location_history_list.dart';

// Atoms:
/// [GoogleMapController] Completer State.
final googleMapCompleterState =
    Atom<Completer<GoogleMapController>>(Completer<GoogleMapController>());

/// Google Map [Marker] Collection State.
final googleMapMarkersState = Atom<Set<Marker>>({});

/// Location Exception State.
final locationExceptionState = Atom<Exception?>(null);

/// [LocationHistoryList] state.
final locationHistoryListState =
    Atom<LocationHistoryList>(LocationHistoryList.empty());

// Actions:
/// Action to retrieve user Location and show in Google Map.
final getMyLocationAction = Atom.action();

/// Action to load all location histories from local storage.
final loadLocationHistoryListAction = Atom.action();

/// Action for go to location and that pin on map.
final goToLocationAction = Atom<Coordinates>(Coordinates.empty());
