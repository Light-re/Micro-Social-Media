import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pulse/core/network/api_client.dart';
import 'package:pulse/core/network/api_exception.dart';
import 'package:pulse/features/comment/data/comment_repository.dart';

ApiClient clientFor(MockClientHandler handler) => ApiClient(
      httpClient: MockClient(handler),
      baseUrl: 'http://test.local',
      tokenProvider: () async => 'token',
    );

const _commentJson = '''
{
  "id": "comment-1",
  "postId": "post-1",
  "authorId": "user-1",
  "authorUsername": "devuser",
  "content": "Nice",
  "createdAt": "2026-06-15T10:00:00.000Z"
}
''';

void main() {
  test('fetchComments parses the comment list', () async {
    late Uri uri;
    final repo = CommentRepository(clientFor((request) async {
      uri = request.url;
      return http.Response('[$_commentJson]', 200);
    }));

    final comments = await repo.fetchComments('post-1');

    expect(uri.path, '/api/posts/post-1/comments');
    expect(comments, hasLength(1));
    expect(comments.first.content, 'Nice');
  });

  test('createComment posts content and returns created comment', () async {
    late String body;
    final repo = CommentRepository(clientFor((request) async {
      body = request.body;
      return http.Response(_commentJson, 201);
    }));

    final comment = await repo.createComment('post-1', 'Nice');

    expect(body, contains('"content":"Nice"'));
    expect(comment.id, 'comment-1');
  });

  test('throws ApiException when loading comments fails', () async {
    final repo =
        CommentRepository(clientFor((_) async => http.Response('', 500)));

    await expectLater(repo.fetchComments('post-1'), throwsA(isA<ApiException>()));
  });
}
