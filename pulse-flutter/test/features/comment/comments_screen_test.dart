import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/di/app_scope.dart';
import 'package:pulse/features/comment/comments_screen.dart';

import '../../support/test_dependencies.dart';

const _commentsBody = '''
[
  {
    "id": "comment-1",
    "postId": "post-1",
    "authorId": "user-1",
    "authorUsername": "devuser",
    "content": "Great thought",
    "createdAt": "2026-06-15T10:00:00.000Z"
  }
]
''';

void main() {
  testWidgets('lists comments after loading', (tester) async {
    final deps = buildTestDependencies((request) async {
      if (request.url.path == '/api/posts/post-1/comments') {
        return jsonResponse(_commentsBody);
      }
      return jsonResponse('{}', status: 404);
    });

    await tester.pumpWidget(
      AppScope(
        dependencies: deps,
        child: const MaterialApp(
          home: CommentsScreen(postId: 'post-1', initialCommentCount: 1),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.text('Great thought'), findsOneWidget);
  });

  testWidgets('send button is disabled until a comment is typed',
      (tester) async {
    final deps = buildTestDependencies((request) async {
      if (request.url.path == '/api/posts/post-1/comments') {
        return jsonResponse('[]');
      }
      return jsonResponse('{}', status: 404);
    });

    await tester.pumpWidget(
      AppScope(
        dependencies: deps,
        child: const MaterialApp(
          home: CommentsScreen(postId: 'post-1', initialCommentCount: 0),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final sendButton = find.widgetWithIcon(IconButton, Icons.send_rounded);
    expect(tester.widget<IconButton>(sendButton).onPressed, isNull);

    await tester.enterText(find.byType(TextField), 'My comment');
    await tester.pump();

    expect(tester.widget<IconButton>(sendButton).onPressed, isNotNull);
  });
}
