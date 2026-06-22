import 'post_response.dart';

/// Transport abstraction for the realtime live feed. Implementations stream
/// posts created by other users as they arrive from the backend. Keeping this
/// behind an interface lets the feed layer stay testable without a real socket.
abstract class LiveFeedConnection {
  /// Broadcast stream of posts pushed by the backend.
  Stream<PostResponse> get posts;

  /// Opens the connection. Safe to call more than once.
  void connect();

  /// Closes the connection and releases resources.
  Future<void> disconnect();
}
