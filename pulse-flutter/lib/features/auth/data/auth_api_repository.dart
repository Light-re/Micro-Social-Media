import 'dart:convert';

import '../../../core/network/api_client.dart';
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
  }) async {
    final response = await _apiClient.post(
      '/api/auth/register',
      body: {
        'email': email,
        'username': username,
        'password': password,
      },
    );

    return _parseAuthResponse(response);
  }

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.post(
      '/api/auth/login',
      body: {
        'email': email,
        'password': password,
      },
    );

    return _parseAuthResponse(response);
  }

  AuthResponse _parseAuthResponse(dynamic response) {
    if (response.statusCode == 201 || response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return AuthResponse.fromJson(json);
    }

    throw AuthApiException(_readError(response));
  }

  String _readError(dynamic response) {
    try {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final detail = json['detail'];
      if (detail is String && detail.isNotEmpty) {
        return detail;
      }
      final title = json['title'];
      if (title is String && title.isNotEmpty) {
        return title;
      }
    } catch (_) {
      // Fall through to generic message.
    }
    return 'Request failed (${response.statusCode})';
  }
}
