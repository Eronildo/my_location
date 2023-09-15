import 'package:flutter/material.dart';

import '../../../../../../core/extensions/build_context_extension.dart';

/// Title of the Modal.
class ModalTitleWidget extends StatelessWidget {
  /// Create a [ModalTitleWidget].
  const ModalTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          context.i18n.lastLocations,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
