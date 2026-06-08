# Architektur

## Systemübersicht

Pulse besteht aus zwei Hauptteilen:

- Flutter Mobile Client
- Spring Boot Backend

Der Flutter Client kommuniziert über REST mit dem Spring Boot Backend. Das Backend speichert cloudbasierte Daten in MongoDB. Die App nutzt zusätzlich eine lokale SQL-Datenbank, geplant mit `sqflite` oder `drift`.

```text
Flutter App (Dart)
        |
        | REST API
        v
Spring Boot Backend
        |
        v
MongoDB (NoSQL)

Flutter App
        |
        v
sqflite / drift (SQL lokal)
```

## Flutter Client

Technologien:

- Flutter
- Dart
- Widgets
- Feature-Struktur unter `lib/features/`
- HTTP-Client für REST API
- geplante lokale SQL-Datenbank mit `sqflite` oder `drift`

Aufgaben:

- UI anzeigen
- User-Eingaben validieren
- REST API aufrufen
- Ladezustände und Fehler anzeigen
- Session und Cache lokal speichern

## Backend

Technologien:

- Spring Boot
- Maven
- Spring Web
- Spring Security
- JWT
- Spring Data MongoDB

Aufgaben:

- REST API bereitstellen
- Registrierung und Login verarbeiten
- JWT erstellen und prüfen
- Posts, Likes und Kommentare verwalten
- Daten in MongoDB speichern

## SQL und NoSQL

### MongoDB (NoSQL)

MongoDB wird für cloudbasierte Social-Media-Daten verwendet:

- users
- posts
- likes
- comments
- follows

NoSQL passt hier, weil Posts und Kommentare flexibel aufgebaut sind und schnell als Dokumente gelesen werden können.

### sqflite / drift (SQL lokal)

Die lokale SQL-Datenbank wird im Flutter-Client verwendet für:

- posts_cache
- bookmarks
- user_session

SQL passt hier, weil lokale Daten strukturiert und offline lesbar gespeichert werden können.

## Docker

Docker wird für lokale Entwicklungsservices verwendet:

- Spring Boot Backend
- MongoDB
- Mongo Express als Datenbank-GUI

Die Flutter App selbst wird nicht in Docker gestartet. Sie läuft lokal in Android Studio oder VS Code auf einem Emulator oder auf einem echten Gerät.

## Geplante REST Endpoints

Auth:

- `POST /api/auth/register`
- `POST /api/auth/login`

User:

- `GET /api/users/{id}`
- `GET /api/users/me`
- `PUT /api/users/me`

Posts:

- `GET /api/posts/feed`
- `POST /api/posts`
- `DELETE /api/posts/{id}`
- `POST /api/posts/{id}/like`
- `DELETE /api/posts/{id}/like`
- `GET /api/posts/{id}/comments`
- `POST /api/posts/{id}/comments`

## Projektstruktur

```text
pulse/
  pulse-backend/
  pulse-flutter/
  docker-compose.yml
  README.md
  docs/
```
