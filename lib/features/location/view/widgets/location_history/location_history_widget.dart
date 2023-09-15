import 'package:flutter/material.dart';

import '../../../../../core/extensions/date_time_extension.dart';
import '../../../atomic_state/location_atoms.dart';
import '../../../models/location_history.dart';

/// A unit [LocationHistory] widget.
class LocationHistoryWidget extends StatelessWidget {
  /// Create a [LocationHistoryWidget].
  const LocationHistoryWidget({
    required this.locationHistory,
    super.key,
  });

  /// A [LocationHistory] model.
  final LocationHistory locationHistory;

  @override
  Widget build(BuildContext context) {
    final localeCode = Localizations.localeOf(context).languageCode;
    return ListTile(
      title: Text(
        locationHistory.historyDate.format(localeCode: localeCode),
      ),
      trailing: IconButton(
        onPressed: () {
          goToLocationAction(locationHistory.coordinates);
          Navigator.pop(context);
        },
        icon: const Icon(Icons.location_pin),
      ),
    );
  }
}
