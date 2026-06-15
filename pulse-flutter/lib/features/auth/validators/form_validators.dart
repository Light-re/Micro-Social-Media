/// Minimum password length enforced on registration (US-28).
const int minPasswordLength = 8;

String? validatePassword(String? value) {
  final password = value?.trim() ?? '';
  if (password.isEmpty) {
    return 'Password is required';
  }
  if (password.length < minPasswordLength) {
    return 'Password must be at least $minPasswordLength characters';
  }
  return null;
}

String? validateEmail(String? value) {
  final email = value?.trim() ?? '';
  if (email.isEmpty) {
    return 'Email is required';
  }
  final emailPattern = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
  if (!emailPattern.hasMatch(email)) {
    return 'Enter a valid email address';
  }
  return null;
}

String? validateUsername(String? value) {
  final username = value?.trim() ?? '';
  if (username.isEmpty) {
    return 'Username is required';
  }
  if (username.length < 3) {
    return 'Username must be at least 3 characters';
  }
  if (username.length > 30) {
    return 'Username must be at most 30 characters';
  }
  return null;
}

String? validateBio(String? value) {
  final bio = value ?? '';
  if (bio.length > 500) {
    return 'Bio must be at most 500 characters';
  }
  return null;
}
