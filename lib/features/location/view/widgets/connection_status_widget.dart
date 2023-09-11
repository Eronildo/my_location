import 'package:flutter/material.dart';

import '../../../../core/atomic_state/app_atom.dart';
import '../../../../core/extensions/build_context_extension.dart';

const _backgroundCardSize = 40.0;

/// Connection Status Label Widget.
///
/// Show if has no internet connection.
class ConnectionStatusWidget extends StatelessWidget {
  /// [ConnectionStatusWidget] constructor.
  const ConnectionStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isInternetConnectedState,
      builder: (_, value, __) => !value
          ? SafeArea(
              child: Container(
                height: _backgroundCardSize,
                width: double.maxFinite,
                color: Colors.white38,
                child: Center(
                  child: Text(
                    context.i18n.noConnection,
                    style: const TextStyle(color: Colors.red, fontSize: 28),
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
