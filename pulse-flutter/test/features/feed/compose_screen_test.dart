import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:pulse/core/di/app_scope.dart';
import 'package:pulse/features/feed/compose_screen.dart';

import '../../support/test_dependencies.dart';

void main() {
  Finder postButton() => find.widgetWithText(TextButton, 'Post');

  testWidgets('post button is disabled until text is entered', (tester) async {
    final deps = buildTestDependencies((_) async => jsonResponse('{}'));

    await tester.pumpWidget(
      AppScope(
        dependencies: deps,
        child: const MaterialApp(home: ComposeScreen()),
      ),
    );

    expect(tester.widget<TextButton>(postButton()).onPressed, isNull);

    await tester.enterText(find.byType(TextField), 'Hello world');
    await tester.pump();

    expect(tester.widget<TextButton>(postButton()).onPressed, isNotNull);
  });

  testWidgets('shows progress and disables the button while submitting',
      (tester) async {
    final completer = Completer<http.Response>();
    final deps = buildTestDependencies((request) async {
      if (request.method == 'POST' && request.url.path == '/api/posts') {
        return completer.future;
      }
      return jsonResponse('{}');
    });

    await tester.pumpWidget(
      AppScope(
        dependencies: deps,
        child: const MaterialApp(home: ComposeScreen()),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Hello world');
    await tester.pump();
    await tester.tap(postButton());
    await tester.pump();

    expect(
      find.descendant(
        of: find.byType(AppBar),
        matching: find.byType(CircularProgressIndicator),
      ),
      findsOneWidget,
    );

    completer.complete(jsonResponse('', status: 500));
    await tester.pumpAndSettle();

    expect(find.byType(SnackBar), findsOneWidget);
  });
}
