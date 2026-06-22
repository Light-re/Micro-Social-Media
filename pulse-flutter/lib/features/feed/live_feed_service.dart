import 'data/live_feed_connection.dart';
import 'data/post_response.dart';

/// Exposes the realtime stream of newly created posts and the lifecycle hooks
/// the feed screen uses. Holds the merge logic so the screen stays thin.
class LiveFeedService {
  LiveFeedService(this._connection);

  final LiveFeedConnection _connection;

  /// Posts pushed by the backend as other users publish them.
  Stream<PostResponse> get posts => _connection.posts;

  void connect() => _connection.connect();

  Future<void> dispose() => _connection.disconnect();

  /// Returns a new list with [incoming] prepended, unless a post with the same
  /// id is already present (dedupe against the author's own optimistic insert).
  static List<PostResponse> merge(
    List<PostResponse> current,
    PostResponse incoming,
  ) {
    if (current.any((post) => post.id == incoming.id)) {
      return current;
    }
    return [incoming, ...current];
  }
}
