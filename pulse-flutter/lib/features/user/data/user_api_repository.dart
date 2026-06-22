import '../../../core/network/api_client.dart';
import '../../../core/network/api_exception.dart';
import 'user_profile.dart';

class UserApiException implements Exception {
  UserApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// REST access for `/api/users` endpoints. The bearer token is injected by the
/// shared [ApiClient], so callers do not pass it explicitly.
class UserApiRepository {
  UserApiRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<UserProfile> fetchMe() async {
    try {
      final json = await _apiClient.get('/api/users/me');
      return UserProfile.fromJson(json as Map<String, dynamic>);
    } on ApiException catch (error) {
      throw UserApiException(error.message);
    }
  }

  Future<UserProfile> updateMe({
    required String username,
    required String bio,
  }) async {
    try {
      final json = await _apiClient.put(
        '/api/users/me',
        body: {'username': username, 'bio': bio},
      );
      return UserProfile.fromJson(json as Map<String, dynamic>);
    } on ApiException catch (error) {
      throw UserApiException(error.message);
    }
  }
}
