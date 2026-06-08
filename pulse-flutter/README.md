# Pulse Flutter

Official Flutter/Dart mobile client for Pulse (`com.frattoninteractive.pulse`).

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel, Dart 3+)
- Android Studio or VS Code with Flutter/Dart extensions
- Backend running via Docker from the repo root: `docker compose up -d`

## Open and run

```bash
cd pulse-flutter
flutter pub get
flutter run
```

Use an Android emulator (API 26+) or a connected device.

## Backend URL (local development)

| Environment | Base URL |
|---|---|
| Android emulator | `http://10.0.2.2:8080` |
| Same machine (desktop) | `http://localhost:8080` |

Constants live in `lib/core/config/api_config.dart`.

Cleartext HTTP for local backend setup is handled in issue #37 (migration from `pulse-android`).

## Project structure

```text
lib/
  core/          # shared config, theme, utilities
  features/
    auth/        # login, register, session
    feed/        # posts, likes, comments
  main.dart
```

Architecture: **Screen/Widget → Service → Repository** (see repo root `.cursorrules`).

## Verify

```bash
flutter analyze
flutter test
```
