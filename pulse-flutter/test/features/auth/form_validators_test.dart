import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/features/auth/validators/form_validators.dart';

void main() {
  group('validatePassword', () {
    test('returns message when password is too short', () {
      expect(validatePassword('short'), 'Password must be at least 8 characters');
    });

    test('returns null for valid password', () {
      expect(validatePassword('password123'), isNull);
    });

    test('returns message when password is empty', () {
      expect(validatePassword(''), 'Password is required');
    });
  });

  group('validateUsername', () {
    test('returns message when username is too short', () {
      expect(validateUsername('ab'), 'Username must be at least 3 characters');
    });

    test('returns null for valid username', () {
      expect(validateUsername('devuser'), isNull);
    });
  });
}
