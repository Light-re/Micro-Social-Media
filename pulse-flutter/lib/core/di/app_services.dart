import '../../core/config/api_config.dart';
import '../../core/database/app_database.dart';
import '../../core/network/api_client.dart';
import '../../features/auth/auth_service.dart';
import '../../features/auth/data/auth_api_repository.dart';
import '../../features/auth/data/session_repository.dart';
import '../../features/user/data/user_api_repository.dart';
import '../../features/user/user_service.dart';

/// Shared service wiring for auth and profile features.
class AppServices {
  AppServices({String? baseUrl, ApiClient? apiClient, AppDatabase? appDatabase})
      : apiClient = apiClient ?? ApiClient(baseUrl: baseUrl ?? ApiConfig.emulatorBaseUrl),
        appDatabase = appDatabase ?? AppDatabase() {
    final sessionRepository = SessionRepository(this.appDatabase);
    authService = AuthService(
      AuthApiRepository(this.apiClient),
      sessionRepository,
    );
    userService = UserService(
      UserApiRepository(this.apiClient),
      sessionRepository,
    );
  }

  final ApiClient apiClient;
  final AppDatabase appDatabase;
  late final AuthService authService;
  late final UserService userService;
}
