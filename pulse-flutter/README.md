# Pulse Flutter

Dieses Verzeichnis enthält den aktiven Mobile-Client von Pulse.

## Stack

- Flutter
- Dart
- Package-Name: `com.frattoninteractive.pulse`
- Lokale Backend-URL im Android Emulator: `http://10.0.2.2:8080`
- Geplante lokale SQL-Datenbank: `sqflite` oder `drift`

## Setup

1. Flutter SDK installieren.
2. Android Studio oder VS Code mit Flutter/Dart Plugin einrichten.
3. Dependencies installieren:

```bash
flutter pub get
```

4. App starten:

```bash
flutter run
```

## Checks

```bash
flutter analyze
flutter test
```

## Migration vom alten Android-Skeleton

Das frühere `pulse-android/`-Skeleton bestand nur aus einer `MainActivity` mit einer Welcome-Nachricht. Diese Nachricht wurde in `lib/main.dart` als einfacher Welcome Screen übernommen.

Für API-Aufrufe gegen das lokale Backend wird im Emulator weiterhin `http://10.0.2.2:8080` verwendet.
