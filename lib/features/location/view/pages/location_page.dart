import 'package:flutter/material.dart';

import '../../controller/location_controller.dart';
import '../widgets/connection_status_widget.dart';
import '../widgets/google_map_widget.dart';

/// The location page
///
/// Show a map and a pin of the user location.
class LocationPage extends StatefulWidget {
  /// A [LocationPage] constructor.
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> with LocationController {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          GoogleMapWidget(),
          ConnectionStatusWidget(),
        ],
      ),
    );
  }
}
