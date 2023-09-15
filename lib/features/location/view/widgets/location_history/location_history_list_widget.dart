import 'package:flutter/material.dart';

import '../../../atomic_state/location_atoms.dart';
import 'location_history_widget.dart';

/// LocationHistoryList [Widget].
class LocationHistoryListWidget extends StatelessWidget {
  /// Create a [LocationHistoryListWidget].
  const LocationHistoryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: locationHistoryListState,
        builder: (context, localHistoryList, child) {
          final histories = localHistoryList.locationHistories;
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: histories.length,
            itemBuilder: (context, index) => LocationHistoryWidget(
              locationHistory: histories[index],
            ),
          );
        },
      ),
    );
  }
}
