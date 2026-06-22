import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pulse/core/network/api_client.dart';
import 'package:pulse/core/network/api_exception.dart';
import 'package:pulse/features/feed/data/post_repository.dart';

ApiClient clientFor(MockClientHandler handler) => ApiClient(
      httpClient: MockClient(handler),
      baseUrl: 'http://test.local',
      tokenProvider: () async => 'token',
    );

const _postJson = '''
{
  "id": "post-1",
  "authorId": "user-1",
  "authorUsername": "devuser",
  "content": "Hello",
  "createdAt": "2026-06-15T10:00:00.000Z",
  "likeCount": 1,
  "commentCount": 0,
  "likedByMe": false
}
''';

void main() {
  test('fetchFeed hits /api/posts/feed and parses posts', () async {
    late Uri requested;
    final repo = PostRepository(clientFor((request) async {
      requested = request.url;
      return http.Response('{"posts":[$_postJson]}', 200);
    }));

    final posts = await repo.fetchFeed();

    expect(requested.path, '/api/posts/feed');
    expect(posts, hasLength(1));
    expect(posts.first.id, 'post-1');
  });

  test('createPost posts content and returns created post', () async {
    late String body;
    final repo = PostRepository(clientFor((request) async {
      body = request.body;
      return http.Response(_postJson, 201);
    }));

    final post = await repo.createPost('Hello');

    expect(body, contains('"content":"Hello"'));
    expect(post.id, 'post-1');
  });

  test('deletePost issues DELETE for the post id', () async {
    late String method;
    late Uri uri;
    final repo = PostRepository(clientFor((request) async {
      method = request.method;
      uri = request.url;
      return http.Response('', 204);
    }));

    await repo.deletePost('post-1');

    expect(method, 'DELETE');
    expect(uri.path, '/api/posts/post-1');
  });

  test('throws ApiException when the feed request fails', () async {
    final repo = PostRepository(clientFor((_) async => http.Response('', 500)));

    await expectLater(repo.fetchFeed(), throwsA(isA<ApiException>()));
  });
}
