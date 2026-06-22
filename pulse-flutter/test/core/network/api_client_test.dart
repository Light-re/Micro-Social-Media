import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pulse/core/network/api_client.dart';
import 'package:pulse/core/network/api_exception.dart';

ApiClient buildClient(
  MockClientHandler handler, {
  String? token,
}) {
  return ApiClient(
    httpClient: MockClient(handler),
    baseUrl: 'http://test.local',
    tokenProvider: () async => token,
  );
}

void main() {
  test('attaches bearer token and decodes JSON on success', () async {
    late http.Request captured;
    final client = buildClient(
      (request) async {
        captured = request;
        return http.Response('{"value":42}', 200);
      },
      token: 'jwt-123',
    );

    final result = await client.get('/api/ping');

    expect(result, {'value': 42});
    expect(captured.headers['Authorization'], 'Bearer jwt-123');
  });

  test('omits Authorization header when no token is present', () async {
    late http.Request captured;
    final client = buildClient((request) async {
      captured = request;
      return http.Response('{}', 200);
    });

    await client.get('/api/ping');

    expect(captured.headers.containsKey('Authorization'), isFalse);
  });

  test('returns null for empty 204 responses', () async {
    final client = buildClient((_) async => http.Response('', 204));

    expect(await client.delete('/api/posts/1'), isNull);
  });

  test('maps 403 to a friendly permission message', () async {
    final client = buildClient((_) async => http.Response('', 403));

    await expectLater(
      client.delete('/api/posts/1'),
      throwsA(
        isA<ApiException>()
            .having((e) => e.statusCode, 'statusCode', 403)
            .having((e) => e.message, 'message', contains('permission')),
      ),
    );
  });

  test('uses backend detail for 403 permission messages', () async {
    final client = buildClient(
      (_) async => http.Response('{"detail":"Only the author can delete this post."}', 403),
    );

    await expectLater(
      client.delete('/api/posts/1'),
      throwsA(
        isA<ApiException>()
            .having((e) => e.statusCode, 'statusCode', 403)
            .having((e) => e.message, 'message', 'Only the author can delete this post.'),
      ),
    );
  });

  test('maps transport failures to a network message', () async {
    final client = buildClient((_) async => throw const SocketException('down'));

    await expectLater(
      client.get('/api/ping'),
      throwsA(
        isA<ApiException>().having((e) => e.message, 'message', contains('connection')),
      ),
    );
  });
}
