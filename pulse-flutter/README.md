# Pulse Flutter

Dieses Verzeichnis enthaelt den aktiven Mobile-Client von Pulse.

Official Flutter/Dart mobile client for Pulse (`com.frattoninteractive.pulse`).

## Stack

- Flutter
- Dart
- Package-Name: `com.frattoninteractive.pulse`
- Lokale Backend-URL im Android Emulator: `http://10.0.2.2:8080`
- Lokale Backend-URL auf derselben Maschine: `http://localhost:8080`
- Geplante lokale SQL-Datenbank: `sqflite` oder `drift`

## Voraussetzungen

- Flutter SDK im stable channel mit Dart 3+
- Android Studio oder VS Code mit Flutter/Dart Plugin
- Backend laeuft via Docker aus dem Repo-Root: `docker compose up -d`

## Open and run

```bash
cd pulse-flutter
flutter pub get
flutter run
```

Use an Android emulator (API 26+) or a connected device.

## Backend URL

| Environment | Base URL |
|---|---|
| Android emulator | `http://10.0.2.2:8080` |
| Same machine (desktop) | `http://localhost:8080` |

Constants live in `lib/core/config/api_config.dart`.

Cleartext HTTP for local backend setup is enabled in the Android manifest for development.

## Project structure

```text
lib/
  core/          # shared config, theme, utilities
  features/
    auth/        # login, register, session
    feed/        # posts, likes, comments
  main.dart
```

Architecture: **Screen/Widget -> Service -> Repository** (see repo root `.cursorrules`).

## Checks

```bash
flutter analyze
flutter test
```

## Migration vom alten Android-Skeleton

Das fruehere `pulse-android/`-Skeleton bestand nur aus einer `MainActivity` mit einer Welcome-Nachricht. Diese Nachricht wurde in `lib/main.dart` als einfacher Welcome Screen uebernommen.

Fuer API-Aufrufe gegen das lokale Backend wird im Emulator weiterhin `http://10.0.2.2:8080` verwendet.
