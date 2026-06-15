import '../../../core/network/api_client.dart';
import 'auth_response.dart';

/// Persistence-only access to the backend auth endpoints.
class AuthRepository {
  AuthRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<AuthResponse> login(String email, String password) async {
    final data = await _apiClient.post(
      '/api/auth/login',
      body: {'email': email, 'password': password},
    );
    return AuthResponse.fromJson(data as Map<String, dynamic>);
  }

  Future<AuthResponse> register(
    String email,
    String username,
    String password,
  ) async {
    final data = await _apiClient.post(
      '/api/auth/register',
      body: {'email': email, 'username': username, 'password': password},
    );
    return AuthResponse.fromJson(data as Map<String, dynamic>);
  }
}
