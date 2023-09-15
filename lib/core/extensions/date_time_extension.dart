import 'package:intl/intl.dart';

/// The [DateTime] extension.
extension DateTimeExtension on DateTime {
  /// Format a DateTime
  ///
  /// Can pass a [localeCode], ex: 'pt_BR'.
  String format({String localeCode = 'en_US'}) {
    return DateFormat.yMMMEd(localeCode).add_Hms().format(this);
  }
}
