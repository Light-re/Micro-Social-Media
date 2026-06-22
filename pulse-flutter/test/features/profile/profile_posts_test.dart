import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/di/app_scope.dart';
import 'package:pulse/core/theme/pulse_theme.dart';
import 'package:pulse/features/auth/data/session_record.dart';
import 'package:pulse/features/profile/profile_screen.dart';

import '../../support/test_dependencies.dart';

void main() {
  testWidgets('profile shows the user\'s own posts (US-09)', (tester) async {
    final session = SessionRecord(
      userId: 'user-1',
      email: 'dev@pulse.test',
      username: 'devuser',
      token: 'jwt-token',
      savedAt: DateTime.utc(2026, 6, 15, 10),
    );

    final deps = buildTestDependencies(
      (request) async {
        if (request.url.path == '/api/users/me') {
          return jsonResponse(
            '{"id":"user-1","email":"dev@pulse.test","username":"devuser","bio":"Hello"}',
          );
        }
        if (request.url.path == '/api/posts/me') {
          return jsonResponse(
            '{"posts":[{"id":"post-1","authorId":"user-1",'
            '"authorUsername":"devuser","content":"My first post",'
            '"createdAt":"2026-06-15T10:00:00.000Z","likeCount":0,'
            '"commentCount":0,"likedByMe":false}]}',
          );
        }
        return jsonResponse('{}');
      },
      session: session,
    );

    await tester.pumpWidget(
      AppScope(
        dependencies: deps,
        child: MaterialApp(
          theme: PulseTheme.light(),
          home: const ProfileScreen(),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('My first post'), findsOneWidget);
    // Username shows in both the profile header and the post tile.
    expect(find.text('devuser'), findsWidgets);
  });

  testWidgets('profile shows empty state when there are no posts',
      (tester) async {
    final session = SessionRecord(
      userId: 'user-1',
      email: 'dev@pulse.test',
      username: 'devuser',
      token: 'jwt-token',
      savedAt: DateTime.utc(2026, 6, 15, 10),
    );

    final deps = buildTestDependencies(
      (request) async {
        if (request.url.path == '/api/users/me') {
          return jsonResponse(
            '{"id":"user-1","email":"dev@pulse.test","username":"devuser","bio":""}',
          );
        }
        return jsonResponse('{"posts":[]}');
      },
      session: session,
    );

    await tester.pumpWidget(
      AppScope(
        dependencies: deps,
        child: MaterialApp(
          theme: PulseTheme.light(),
          home: const ProfileScreen(),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('You have not posted yet.'), findsOneWidget);
  });
}
