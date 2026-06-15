import 'dart:convert';

import '../../../core/network/api_client.dart';
import 'user_profile.dart';

class UserApiException implements Exception {
  UserApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// REST access for `/api/users` endpoints.
class UserApiRepository {
  UserApiRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<UserProfile> fetchMe(String token) async {
    final response = await _apiClient.get('/api/users/me', token: token);
    return _parseProfile(response);
  }

  Future<UserProfile> updateMe({
    required String token,
    required String username,
    required String bio,
  }) async {
    final response = await _apiClient.put(
      '/api/users/me',
      token: token,
      body: {
        'username': username,
        'bio': bio,
      },
    );
    return _parseProfile(response);
  }

  UserProfile _parseProfile(dynamic response) {
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return UserProfile.fromJson(json);
    }

    throw UserApiException(_readError(response));
  }

  String _readError(dynamic response) {
    try {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final detail = json['detail'];
      if (detail is String && detail.isNotEmpty) {
        return detail;
      }
    } catch (_) {
      // Fall through to generic message.
    }
    return 'Profile request failed (${response.statusCode})';
  }
}
