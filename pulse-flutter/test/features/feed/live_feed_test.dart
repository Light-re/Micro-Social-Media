import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/di/app_scope.dart';
import 'package:pulse/features/feed/data/post_response.dart';
import 'package:pulse/features/feed/feed_screen.dart';
import 'package:pulse/features/feed/live_feed_service.dart';
import 'package:pulse/features/feed/widgets/post_tile.dart';

import '../../support/fake_live_feed_connection.dart';
import '../../support/test_dependencies.dart';

const _emptyFeed = '{"posts":[]}';

PostResponse _post(String id, String content) {
  return PostResponse(
    id: id,
    authorId: 'user-2',
    authorUsername: 'mara',
    content: content,
    createdAt: DateTime.utc(2026, 6, 15, 12),
    likeCount: 0,
    commentCount: 0,
  );
}

void main() {
  testWidgets('a post emitted over the live feed appears without reload',
      (tester) async {
    final live = FakeLiveFeedConnection();
    final deps = buildTestDependencies(
      (request) async {
        if (request.url.path == '/api/posts/feed') {
          return jsonResponse(_emptyFeed);
        }
        return jsonResponse('{}');
      },
      liveFeedConnection: live,
    );

    await tester.pumpWidget(
      AppScope(
        dependencies: deps,
        child: const MaterialApp(home: FeedScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(live.connectCalled, isTrue);
    expect(find.byType(PostTile), findsNothing);

    live.emit(_post('post-live', 'Live post arrived'));
    await tester.pumpAndSettle();

    expect(find.byType(PostTile), findsOneWidget);
    expect(find.text('Live post arrived'), findsOneWidget);
  });

  group('LiveFeedService.merge', () {
    test('prepends an incoming post', () {
      final current = [_post('a', 'A')];

      final merged = LiveFeedService.merge(current, _post('b', 'B'));

      expect(merged.map((p) => p.id).toList(), ['b', 'a']);
    });

    test('dedupes a post already present by id', () {
      final current = [_post('a', 'A')];

      final merged = LiveFeedService.merge(current, _post('a', 'A again'));

      expect(merged, same(current));
    });
  });
}
