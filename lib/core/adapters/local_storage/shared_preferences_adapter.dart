import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage_adapter.dart';

/// A Local Storage implementation using the [SharedPreferences] plugin
///
/// See https://pub.dev/packages/shared_preferences.
class SharedPreferencesAdapter implements LocalStorageAdapter {
  /// [SharedPreferencesAdapter] constructor.
  SharedPreferencesAdapter(this.sharedPreferences);

  /// [SharedPreferences] plugin.
  final SharedPreferences sharedPreferences;

  @override
  Map<String, dynamic>? get(String key) {
    final jsonString = sharedPreferences.getString(key);

    return jsonString != null
        ? jsonDecode(jsonString) as Map<String, dynamic>
        : null;
  }

  @override
  Future<bool> save(String key, Map<String, dynamic> value) async {
    return sharedPreferences.setString(key, jsonEncode(value));
  }

  @override
  Future<bool> remove(String key) async {
    return sharedPreferences.remove(key);
  }
}
