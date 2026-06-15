import 'dart:convert';

import 'package:http/http.dart' as http;

/// Thin HTTP wrapper for Pulse REST calls.
class ApiClient {
  ApiClient({required this.baseUrl, http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final http.Client _httpClient;

  Future<http.Response> get(String path, {String? token}) {
    return _httpClient.get(
      Uri.parse('$baseUrl$path'),
      headers: _headers(token),
    );
  }

  Future<http.Response> post(String path, {String? token, Object? body}) {
    return _httpClient.post(
      Uri.parse('$baseUrl$path'),
      headers: _headers(token),
      body: body == null ? null : jsonEncode(body),
    );
  }

  Future<http.Response> put(String path, {required String token, Object? body}) {
    return _httpClient.put(
      Uri.parse('$baseUrl$path'),
      headers: _headers(token),
      body: body == null ? null : jsonEncode(body),
    );
  }

  Map<String, String> _headers(String? token) {
    final headers = <String, String>{'Content-Type': 'application/json'};
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }
}
