/// REST API configuration for the Pulse backend.
abstract final class ApiConfig {
  /// Android emulator loopback to the host machine running Docker/backend.
  static const String emulatorBaseUrl = 'http://10.0.2.2:8080';

  /// Local backend when running on the same machine (desktop/web dev).
  static const String localBaseUrl = 'http://localhost:8080';
}
