import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// The [BuildContext] extension.
extension BuildContextExtension on BuildContext {
  /// Get [AppLocalizations] of [BuildContext].
  AppLocalizations get i18n => AppLocalizations.of(this);
}
