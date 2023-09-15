import 'package:flutter/material.dart';

import '../../../../../../core/extensions/build_context_extension.dart';
import '../../../../../../core/widgets/buttons/custom_text_button.dart';
import '../location_history_list_widget.dart';
import 'modal_drag_handle_widget.dart';
import 'modal_title_widget.dart';

/// The [LocationHistoryListWidget] Modal.
class LocationHistoryModalWidget extends StatelessWidget {
  /// Create a [LocationHistoryModalWidget].
  const LocationHistoryModalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            const Column(
              children: [
                ModalDragHandleWidget(),
                ModalTitleWidget(),
                LocationHistoryListWidget(),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: CustomTextButton(
                onPressed: () => Navigator.pop(context),
                label: context.i18n.close,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
