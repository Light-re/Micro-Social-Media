import 'dart:convert';

/// Translates HTTP failures and transport errors into user-friendly messages.
class ApiException implements Exception {
  const ApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  /// Raised when the request never reached the server (no connectivity).
  const ApiException.network()
      : message = 'No connection. Check your network and try again.',
        statusCode = null;

  factory ApiException.fromResponse(int statusCode, String body) {
    return ApiException(
      _messageFor(statusCode, body),
      statusCode: statusCode,
    );
  }

  static String _messageFor(int statusCode, String body) {
    return switch (statusCode) {
      400 || 409 => _extractMessage(body) ?? 'That request could not be processed.',
      401 => _extractMessage(body) ??
          'Your session has expired. Please sign in again.',
      403 => 'You do not have permission to do that.',
      404 => 'We could not find what you were looking for.',
      >= 500 => 'Something went wrong on our end. Please try again.',
      _ => _extractMessage(body) ?? 'Unexpected error. Please try again.',
    };
  }

  static String? _extractMessage(String body) {
    if (body.isEmpty) {
      return null;
    }
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) {
        // Accept either a plain `message` or Spring's problem-detail fields.
        for (final key in const ['message', 'detail', 'title']) {
          final value = decoded[key];
          if (value is String && value.isNotEmpty) {
            return value;
          }
        }
      }
    } on FormatException {
      return null;
    }
    return null;
  }

  @override
  String toString() => message;
}
