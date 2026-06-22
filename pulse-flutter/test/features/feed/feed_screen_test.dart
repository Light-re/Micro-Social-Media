import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/di/app_scope.dart';
import 'package:pulse/features/feed/feed_screen.dart';
import 'package:pulse/features/feed/widgets/post_tile.dart';

import '../../support/test_dependencies.dart';

const _feedBody = '''
{
  "posts": [
    {
      "id": "post-1",
      "authorId": "user-1",
      "authorUsername": "devuser",
      "content": "Hello from the feed",
      "createdAt": "2026-06-15T10:00:00.000Z",
      "likeCount": 2,
      "commentCount": 1,
      "likedByMe": false
    }
  ]
}
''';

void main() {
  testWidgets('shows a loading indicator then renders the feed', (tester) async {
    final deps = buildTestDependencies((request) async {
      if (request.url.path == '/api/posts/feed') {
        return jsonResponse(_feedBody);
      }
      return jsonResponse('{}', status: 404);
    });

    await tester.pumpWidget(
      AppScope(
        dependencies: deps,
        child: const MaterialApp(home: FeedScreen()),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.byType(PostTile), findsOneWidget);
    expect(find.text('Hello from the feed'), findsOneWidget);
  });

  testWidgets('shows empty state when feed has no posts', (tester) async {
    final deps = buildTestDependencies((request) async {
      if (request.url.path == '/api/posts/feed') {
        return jsonResponse('{"posts":[]}');
      }
      return jsonResponse('{}', status: 404);
    });

    await tester.pumpWidget(
      AppScope(
        dependencies: deps,
        child: const MaterialApp(home: FeedScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Nothing here yet.'), findsOneWidget);
    expect(find.byType(PostTile), findsNothing);
  });

  testWidgets('shows an error state with retry when loading fails',
      (tester) async {
    final deps = buildTestDependencies((_) async => jsonResponse('', status: 500));

    await tester.pumpWidget(
      AppScope(
        dependencies: deps,
        child: const MaterialApp(home: FeedScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Retry'), findsOneWidget);
    expect(find.byType(PostTile), findsNothing);
  });
}
