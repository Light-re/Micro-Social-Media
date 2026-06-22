import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/di/app_scope.dart';
import 'package:pulse/features/feed/data/post_response.dart';
import 'package:pulse/features/feed/widgets/post_tile.dart';

import '../../support/test_dependencies.dart';

PostResponse buildPost() {
  return PostResponse(
    id: 'post-1',
    authorId: 'user-1',
    authorUsername: 'devuser',
    content: 'Hello',
    createdAt: DateTime.utc(2026, 6, 15, 10),
    likeCount: 0,
    commentCount: 0,
  );
}

void main() {
  Widget host(String? currentUserId) {
    final deps = buildTestDependencies((_) async => jsonResponse('{}'));
    return AppScope(
      dependencies: deps,
      child: MaterialApp(
        home: Scaffold(
          body: PostTile(
            post: buildPost(),
            likeService: deps.likeService,
            currentUserId: currentUserId,
            onDeleteRequested: (_) async {},
          ),
        ),
      ),
    );
  }

  testWidgets('shows the delete affordance on own posts (US-24)',
      (tester) async {
    await tester.pumpWidget(host('user-1'));

    expect(find.byIcon(Icons.more_horiz_rounded), findsOneWidget);
  });

  testWidgets('hides the delete affordance on foreign posts (US-25)',
      (tester) async {
    await tester.pumpWidget(host('someone-else'));

    expect(find.byIcon(Icons.more_horiz_rounded), findsNothing);
  });

  testWidgets('tapping like fills the heart and pops (US-17)', (tester) async {
    final deps = buildTestDependencies((request) async {
      if (request.method == 'POST' &&
          request.url.path == '/api/posts/post-1/like') {
        return jsonResponse(
          '{"id":"post-1","authorId":"user-1","authorUsername":"devuser",'
          '"content":"Hello","createdAt":"2026-06-15T10:00:00.000Z",'
          '"likeCount":1,"commentCount":0,"likedByMe":true}',
        );
      }
      return jsonResponse('{}');
    });

    await tester.pumpWidget(
      AppScope(
        dependencies: deps,
        child: MaterialApp(
          home: Scaffold(
            body: PostTile(
              post: buildPost(),
              likeService: deps.likeService,
              currentUserId: 'user-1',
              onDeleteRequested: (_) async {},
            ),
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.favorite_border_rounded), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite_border_rounded));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);
    expect(find.text('1 like'), findsOneWidget);
    await tester.pumpAndSettle();
  });
}
