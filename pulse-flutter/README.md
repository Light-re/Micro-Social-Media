# Pulse Flutter

Dieses Verzeichnis enthaelt den aktiven Mobile-Client von Pulse.

Official Flutter/Dart mobile client for Pulse (`com.frattoninteractive.pulse`).

## Stack

- Flutter
- Dart
- Package-Name: `com.frattoninteractive.pulse`
- Lokale Backend-URL im Android Emulator: `http://10.0.2.2:8080`
- Lokale Backend-URL auf derselben Maschine: `http://localhost:8080`
- Geplante lokale SQL-Datenbank: `sqflite`

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

## Project structure

```text
lib/
  core/
    config/
    database/    # sqflite setup (user_session table)
    strings/
    theme/
  features/
    auth/
      data/        # SessionRepository (local SQL)
    feed/
      data/        # PostResponse, FeedResponse DTOs
    home/
  main.dart
```

## Lokale SQL (`sqflite`)

Session-Daten (JWT, User-ID) werden in SQLite gespeichert:

| Tabelle | Zweck |
|---|---|
| `user_session` | Ein aktiver Login (Token, User-Metadaten) |

Klassen:

- `lib/core/database/app_database.dart` — DB-Oeffnung und Schema
- `lib/features/auth/data/session_repository.dart` — `saveSession`, `getSession`, `clearSession`

Voraussetzung fuer **US-07 Auth-Status prüfen**.

Architecture: **Screen/Widget -> Service -> Repository** (see repo root `.cursorrules`).

## Checks

```bash
flutter analyze
flutter test
```

## Migration vom alten Android-Skeleton (`pulse-android`)

Das native Java-Skeleton wurde vollstaendig nach Flutter portiert:

| Alt (`pulse-android`) | Neu (`pulse-flutter`) |
|---|---|
| `MainActivity.java` + `activity_main.xml` | `lib/features/home/welcome_screen.dart` |
| `strings.xml` (`welcome_message`) | `lib/core/strings/app_strings.dart` |
| `colors.xml` (`purple_500`, `white`) | `lib/core/theme/pulse_colors.dart` |
| `themes.xml` (Material 3) | `lib/core/theme/pulse_theme.dart` |
| `network_security_config.xml` | `android/app/src/main/res/xml/network_security_config.xml` |
| Emulator-URL `http://10.0.2.2:8080` | `lib/core/config/api_config.dart` |
| App-ID `com.frattoninteractive.pulse` | unveraendert im Flutter-Android-Teil |

Cleartext HTTP ist nur fuer `localhost`, `127.0.0.1` und `10.0.2.2` erlaubt (wie im alten Skeleton), nicht app-weit.

Retrofit, Room und Navigation waren im Java-Projekt nur vorbereitet und wurden nicht portiert. API- und SQL-Zugriff kommen in Flutter mit `http`/`dio` und `sqflite`/`drift`.
