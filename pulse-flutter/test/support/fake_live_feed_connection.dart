import 'dart:async';

import 'package:pulse/features/feed/data/live_feed_connection.dart';
import 'package:pulse/features/feed/data/post_response.dart';

/// In-memory [LiveFeedConnection] for tests. Lets a test emit posts as if they
/// arrived over the socket, without any real network.
class FakeLiveFeedConnection implements LiveFeedConnection {
  final StreamController<PostResponse> _controller =
      StreamController<PostResponse>.broadcast();
  bool connectCalled = false;

  @override
  Stream<PostResponse> get posts => _controller.stream;

  @override
  void connect() {
    connectCalled = true;
  }

  @override
  Future<void> disconnect() async {
    if (!_controller.isClosed) {
      await _controller.close();
    }
  }

  /// Simulates a post broadcast from the backend.
  void emit(PostResponse post) {
    if (!_controller.isClosed) {
      _controller.add(post);
    }
  }
}
