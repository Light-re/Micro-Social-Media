import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pulse/core/network/api_client.dart';
import 'package:pulse/core/network/api_exception.dart';
import 'package:pulse/features/feed/data/post_response.dart';
import 'package:pulse/features/like/data/like_repository.dart';
import 'package:pulse/features/like/like_service.dart';

ApiClient clientFor(MockClientHandler handler) => ApiClient(
      httpClient: MockClient(handler),
      baseUrl: 'http://test.local',
      tokenProvider: () async => 'token',
    );

PostResponse postWith({required bool likedByMe, required int likeCount}) {
  return PostResponse(
    id: 'post-1',
    authorId: 'user-1',
    authorUsername: 'devuser',
    content: 'Hello',
    createdAt: DateTime.utc(2026, 6, 15, 10),
    likeCount: likeCount,
    commentCount: 0,
    likedByMe: likedByMe,
  );
}

String responseJson({required bool likedByMe, required int likeCount}) {
  return '''
  {
    "id": "post-1",
    "authorId": "user-1",
    "authorUsername": "devuser",
    "content": "Hello",
    "createdAt": "2026-06-15T10:00:00.000Z",
    "likeCount": $likeCount,
    "commentCount": 0,
    "likedByMe": $likedByMe
  }
  ''';
}

void main() {
  test('liking an un-liked post POSTs to the like endpoint', () async {
    late String method;
    late Uri uri;
    final service = LikeService(LikeRepository(clientFor((request) async {
      method = request.method;
      uri = request.url;
      return http.Response(responseJson(likedByMe: true, likeCount: 1), 200);
    })));

    final updated = await service.toggle(postWith(likedByMe: false, likeCount: 0));

    expect(method, 'POST');
    expect(uri.path, '/api/posts/post-1/like');
    expect(updated.likedByMe, isTrue);
    expect(updated.likeCount, 1);
  });

  test('unliking a liked post DELETEs the like endpoint', () async {
    late String method;
    final service = LikeService(LikeRepository(clientFor((request) async {
      method = request.method;
      return http.Response(responseJson(likedByMe: false, likeCount: 0), 200);
    })));

    final updated = await service.toggle(postWith(likedByMe: true, likeCount: 1));

    expect(method, 'DELETE');
    expect(updated.likedByMe, isFalse);
  });

  test('throws ApiException when the like request fails', () async {
    final service = LikeService(
      LikeRepository(clientFor((_) async => http.Response('', 500))),
    );

    await expectLater(
      service.toggle(postWith(likedByMe: false, likeCount: 0)),
      throwsA(isA<ApiException>()),
    );
  });
}
