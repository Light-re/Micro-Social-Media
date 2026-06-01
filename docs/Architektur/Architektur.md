# Architektur

## Systemübersicht

Pulse besteht aus zwei Hauptteilen:

- Android Client
- Spring Boot Backend

Der Android Client kommuniziert über Retrofit und OkHttp mit dem Spring Boot Backend. Das Backend speichert cloudbasierte Daten in MongoDB. Die Android App nutzt zusätzlich Room/SQLite als lokale SQL-Datenbank.

```text
Android App (Java)
        |
        | Retrofit / REST
        v
Spring Boot Backend
        |
        v
MongoDB (NoSQL)

Android App
        |
        v
Room / SQLite (SQL lokal)
```

## Android Client

Technologien:
- Android Native
- Java
- Activities / Fragments / XML
- ViewModel + LiveData
- Repository Pattern
- Retrofit + OkHttp
- Room Database

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

### Room / SQLite (SQL lokal)

Room wird lokal auf dem Android-Gerät verwendet:

- posts_cache
- bookmarks
- user_session

SQL passt hier, weil lokale Daten strukturiert und offline lesbar gespeichert werden können.

## Docker

Docker wird für lokale Entwicklungsservices verwendet:

- Spring Boot Backend
- MongoDB
- optional Mongo Express als Datenbank-GUI

Die Android App selbst wird nicht in Docker gestartet. Sie läuft lokal in Android Studio auf einem Emulator oder auf einem echten Gerät.

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
  pulse-android/
  docker-compose.yml
  README.md
  docs/
```
