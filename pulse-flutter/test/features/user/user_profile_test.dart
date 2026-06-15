import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/features/user/data/user_profile.dart';

void main() {
  test('UserProfile parses bio from API response', () {
    final profile = UserProfile.fromJson({
      'id': 'user-1',
      'email': 'dev@pulse.test',
      'username': 'devuser',
      'bio': 'Hello world',
    });

    expect(profile.id, 'user-1');
    expect(profile.username, 'devuser');
    expect(profile.bio, 'Hello world');
  });

  test('UserProfile defaults missing bio to empty string', () {
    final profile = UserProfile.fromJson({
      'id': 'user-1',
      'email': 'dev@pulse.test',
      'username': 'devuser',
    });

    expect(profile.bio, '');
  });
}
