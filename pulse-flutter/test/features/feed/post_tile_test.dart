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
}
