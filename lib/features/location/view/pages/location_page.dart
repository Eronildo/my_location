import 'package:flutter/material.dart';

import '../../../../core/extensions/build_context_extension.dart';
import '../../../../core/widgets/buttons/custom_button.dart';
import '../../atomic_state/location_atoms.dart';
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
    return Scaffold(
      body: Stack(
        children: [
          const GoogleMapWidget(),
          const ConnectionStatusWidget(),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: CustomButton(
                  onPressed: getMyLocationAction.call,
                  iconData: Icons.gps_fixed,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: CustomButton(
        onPressed: showLocationHistoryList,
        iconData: Icons.history,
        label: context.i18n.lastLocations,
      ),
    );
  }
}
