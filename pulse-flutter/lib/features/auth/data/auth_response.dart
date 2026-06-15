/// Auth API response returned by `/api/auth/login` and `/api/auth/register`.
class AuthResponse {
  const AuthResponse({
    required this.token,
    required this.userId,
    required this.email,
    required this.username,
  });

  final String token;
  final String userId;
  final String email;
  final String username;

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'] as String,
      userId: json['userId'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
    );
  }
}
