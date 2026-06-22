import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pulse/core/di/app_dependencies.dart';
import 'package:pulse/features/auth/data/session_record.dart';
import 'package:pulse/features/feed/data/live_feed_connection.dart';
import 'package:pulse/features/feed/live_feed_service.dart';

import 'fake_live_feed_connection.dart';
import 'fake_session_repository.dart';

/// Routes a mocked HTTP request to a canned response by method + path.
typedef MockHandler = Future<http.Response> Function(http.Request request);

/// Builds [AppDependencies] backed by a [MockClient] and an in-memory session
/// store so widget tests never touch the network or disk. The live feed uses a
/// no-op fake connection by default so tests never open a real socket.
AppDependencies buildTestDependencies(
  MockHandler handler, {
  SessionRecord? session,
  LiveFeedConnection? liveFeedConnection,
}) {
  return AppDependencies.create(
    httpClient: MockClient(handler),
    sessionRepository: FakeSessionRepository(session),
    liveFeedService:
        LiveFeedService(liveFeedConnection ?? FakeLiveFeedConnection()),
  );
}

http.Response jsonResponse(String body, {int status = 200}) {
  return http.Response(
    body,
    status,
    headers: {'content-type': 'application/json'},
  );
}
