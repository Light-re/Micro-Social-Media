import 'package:http/http.dart' as http;

import '../../features/auth/auth_service.dart';
import '../../features/auth/data/auth_repository.dart';
import '../../features/auth/data/session_repository.dart';
import '../../features/comment/comment_service.dart';
import '../../features/comment/data/comment_repository.dart';
import '../../features/feed/data/post_repository.dart';
import '../../features/feed/feed_service.dart';
import '../../features/like/data/like_repository.dart';
import '../../features/like/like_service.dart';
import '../config/api_config.dart';
import '../database/app_database.dart';
import '../network/api_client.dart';

/// Composition root holding the shared services used across the app.
class AppDependencies {
  AppDependencies({
    required this.authService,
    required this.feedService,
    required this.likeService,
    required this.commentService,
    required http.Client httpClient,
    required AppDatabase database,
  })  : _httpClient = httpClient,
        _database = database;

  final AuthService authService;
  final FeedService feedService;
  final LikeService likeService;
  final CommentService commentService;

  final http.Client _httpClient;
  final AppDatabase _database;

  /// Wires the real backend stack (http + sqflite). Injectable for tests.
  factory AppDependencies.create({
    http.Client? httpClient,
    AppDatabase? database,
    SessionRepository? sessionRepository,
    String baseUrl = ApiConfig.baseUrl,
  }) {
    final client = httpClient ?? http.Client();
    final db = database ?? AppDatabase();
    final sessions = sessionRepository ?? SessionRepository(db);

    final apiClient = ApiClient(
      httpClient: client,
      baseUrl: baseUrl,
      tokenProvider: () async => (await sessions.getSession())?.token,
    );

    return AppDependencies(
      httpClient: client,
      database: db,
      authService: AuthService(
        authRepository: AuthRepository(apiClient),
        sessionRepository: sessions,
      ),
      feedService: FeedService(PostRepository(apiClient)),
      likeService: LikeService(LikeRepository(apiClient)),
      commentService: CommentService(CommentRepository(apiClient)),
    );
  }

  Future<void> dispose() async {
    _httpClient.close();
    await _database.close();
  }
}
