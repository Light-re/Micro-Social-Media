import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'api_exception.dart';

/// Supplies the current bearer token, or null when the user is signed out.
typedef TokenProvider = Future<String?> Function();

/// Thin HTTP wrapper that handles JSON encoding, auth headers and error mapping.
///
/// Returns the decoded JSON body (`Map`/`List`) on success, `null` for empty
/// responses, and throws [ApiException] for transport or status failures.
class ApiClient {
  ApiClient({
    required http.Client httpClient,
    required this.baseUrl,
    required TokenProvider tokenProvider,
  })  : _httpClient = httpClient,
        _tokenProvider = tokenProvider;

  final http.Client _httpClient;
  final String baseUrl;
  final TokenProvider _tokenProvider;

  Future<dynamic> get(String path) async {
    return _guard(() async => _httpClient.get(_uri(path), headers: await _headers()));
  }

  Future<dynamic> post(String path, {Object? body}) async {
    return _guard(() async => _httpClient.post(
          _uri(path),
          headers: await _headers(),
          body: body == null ? null : jsonEncode(body),
        ));
  }

  Future<dynamic> delete(String path) async {
    return _guard(() async => _httpClient.delete(_uri(path), headers: await _headers()));
  }

  Uri _uri(String path) => Uri.parse('$baseUrl$path');

  Future<dynamic> _guard(Future<http.Response> Function() send) async {
    try {
      return _decode(await send());
    } on SocketException {
      throw const ApiException.network();
    } on http.ClientException {
      throw const ApiException.network();
    }
  }

  Future<Map<String, String>> _headers() async {
    final headers = {'Content-Type': 'application/json'};
    final token = await _tokenProvider();
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  dynamic _decode(http.Response response) {
    final status = response.statusCode;
    if (status < 200 || status >= 300) {
      throw ApiException.fromResponse(status, response.body);
    }
    if (response.body.isEmpty) {
      return null;
    }
    return jsonDecode(response.body);
  }
}
