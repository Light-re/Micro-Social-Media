import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/features/auth/data/session_record.dart';
import 'package:pulse/features/home/home_shell.dart';
import 'package:pulse/features/home/welcome_screen.dart';
import 'package:pulse/main.dart';

import '../../support/test_dependencies.dart';

Future<void> pumpAuthGate(
  WidgetTester tester, {
  SessionRecord? session,
}) async {
  await tester.pumpWidget(
    PulseApp(
      dependencies: buildTestDependencies(
        (request) async {
          if (request.url.path == '/api/posts/feed') {
            return jsonResponse('{"posts":[]}');
          }
          return jsonResponse('{}');
        },
        session: session,
      ),
    ),
  );
  await tester.pump();
  for (var attempt = 0; attempt < 20; attempt++) {
    await tester.pump(const Duration(milliseconds: 50));
    if (find.byType(WelcomeScreen).evaluate().isNotEmpty ||
        find.byType(HomeShell).evaluate().isNotEmpty) {
      return;
    }
  }
  fail('Auth gate did not resolve');
}

void main() {
  testWidgets('routes to welcome when no session exists', (tester) async {
    await pumpAuthGate(tester);
    expect(find.byType(WelcomeScreen), findsOneWidget);
  });

  testWidgets('routes to home when session exists', (tester) async {
    await pumpAuthGate(
      tester,
      session: SessionRecord(
        userId: 'user-1',
        email: 'dev@pulse.test',
        username: 'devuser',
        token: 'jwt-token',
        savedAt: DateTime.utc(2026, 6, 15, 10),
      ),
    );
    expect(find.byType(HomeShell), findsOneWidget);
  });
}
