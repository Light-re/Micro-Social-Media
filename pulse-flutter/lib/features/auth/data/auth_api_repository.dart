import '../../../core/network/api_client.dart';
import '../../../core/network/api_exception.dart';
import 'auth_response.dart';

class AuthApiException implements Exception {
  AuthApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// REST access for `/api/auth` endpoints.
class AuthApiRepository {
  AuthApiRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<AuthResponse> register({
    required String email,
    required String username,
    required String password,
  }) {
    return _send('/api/auth/register', {
      'email': email,
      'username': username,
      'password': password,
    });
  }

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) {
    return _send('/api/auth/login', {
      'email': email,
      'password': password,
    });
  }

  Future<AuthResponse> _send(String path, Map<String, String> body) async {
    try {
      final json = await _apiClient.post(path, body: body);
      return AuthResponse.fromJson(json as Map<String, dynamic>);
    } on ApiException catch (error) {
      throw AuthApiException(error.message);
    }
  }
}
