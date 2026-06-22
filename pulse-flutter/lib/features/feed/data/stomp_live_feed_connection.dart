import 'dart:async';
import 'dart:convert';

import 'package:stomp_dart_client/stomp_dart_client.dart';

import '../../../core/network/api_client.dart' show TokenProvider;
import 'live_feed_connection.dart';
import 'post_response.dart';

/// STOMP-over-WebSocket implementation of [LiveFeedConnection]. Subscribes to
/// `/topic/posts` and emits each broadcast post. The JWT is sent in the STOMP
/// CONNECT headers so the socket is authenticated like the REST API.
class StompLiveFeedConnection implements LiveFeedConnection {
  StompLiveFeedConnection({
    required this.url,
    required this.tokenProvider,
    this.topic = '/topic/posts',
    StompClient Function(StompConfig config)? clientFactory,
  }) : _clientFactory =
            clientFactory ?? ((config) => StompClient(config: config));

  final String url;
  final TokenProvider tokenProvider;
  final String topic;
  final StompClient Function(StompConfig config) _clientFactory;

  final StreamController<PostResponse> _controller =
      StreamController<PostResponse>.broadcast();
  StompClient? _client;

  @override
  Stream<PostResponse> get posts => _controller.stream;

  @override
  void connect() {
    if (_client != null) {
      return;
    }
    unawaited(_start());
  }

  Future<void> _start() async {
    try {
      final token = await tokenProvider();
      final headers = <String, String>{};
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
      _client = _clientFactory(StompConfig(
        url: url,
        stompConnectHeaders: headers,
        onConnect: _onConnect,
        onWebSocketError: (_) {},
        onStompError: (_) {},
      ))
        ..activate();
    } catch (_) {
      // Socket unavailable; REST feed remains the fallback.
    }
  }

  void _onConnect(StompFrame frame) {
    _client?.subscribe(destination: topic, callback: _onMessage);
  }

  void _onMessage(StompFrame frame) {
    final body = frame.body;
    if (body == null || body.isEmpty) {
      return;
    }
    try {
      final json = jsonDecode(body) as Map<String, dynamic>;
      _controller.add(PostResponse.fromJson(json));
    } catch (_) {
      // Ignore malformed frames; the REST feed remains the source of truth.
    }
  }

  @override
  Future<void> disconnect() async {
    _client?.deactivate();
    _client = null;
    if (!_controller.isClosed) {
      await _controller.close();
    }
  }
}
