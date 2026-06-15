/// Profile data returned by `GET /api/users/me`.
class UserProfile {
  const UserProfile({
    required this.id,
    required this.email,
    required this.username,
    required this.bio,
  });

  final String id;
  final String email;
  final String username;
  final String bio;

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      bio: (json['bio'] as String?) ?? '',
    );
  }

  Map<String, String> toUpdateBody() {
    return {
      'username': username,
      'bio': bio,
    };
  }
}
