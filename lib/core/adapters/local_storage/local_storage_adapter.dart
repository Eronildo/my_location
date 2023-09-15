/// A [LocalStorageAdapter] interface.
abstract interface class LocalStorageAdapter {
  /// Get a map object by [key].
  Map<String, dynamic>? get(String key);

  /// Save map object in a [key].
  Future<bool> save(String key, Map<String, dynamic> value);

  /// Remove object in a [key].
  Future<bool> remove(String key);
}
