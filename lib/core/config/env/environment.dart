/// The [Environment] Class
///
/// Get all keys and secrets from the .env file.
sealed class Environment {
  /// Base API URL from environment file.
  static const apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'http://google.com',
  );
}
