# Pulse

Dieses Repository enthält das Schulprojekt **Pulse** für das Modul 335 - Mobile-Applikation realisieren.

Pulse ist eine mobile Social-Media-App. Der aktive Mobile-Client wird mit **Flutter/Dart** entwickelt. Das Backend wird mit **Spring Boot** umgesetzt und stellt eine REST API bereit. Für die Datenhaltung werden bewusst SQL und NoSQL eingesetzt.

## Projektart

- Modul: 335 - Mobile-Applikation realisieren
- Vorgehensmodell: Scrum
- Projektdauer: 5 Wochen
- App-Name: Pulse
- Mobile App: Flutter mit Dart
- Backend: Spring Boot 4.0.6 mit Maven
- NoSQL-Datenbank: MongoDB
- SQL-Datenbank lokal: geplant mit `sqflite` oder `drift`
- API-Kommunikation: REST über HTTP-Client im Flutter-Client
- Authentifizierung: JWT
- Containerisierung: Docker / Docker Compose für Backend-Services

## Geplante Hauptfunktionen

- Registrierung
- Login und Logout
- Profil anzeigen und bearbeiten
- Beitrag erstellen
- Feed anzeigen
- Beiträge liken und unliken
- Beiträge kommentieren
- Eigene Beiträge löschen
- Lokaler Cache mit `sqflite` oder `drift`
- Validierung von Eingaben
- Ladezustände und Fehlermeldungen

## Architektur

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

MongoDB wird für cloudbasierte Social-Media-Daten verwendet. `sqflite` oder `drift` wird lokal auf dem Gerät für Cache, Bookmarks und Session-Daten verwendet.

## Warum SQL und NoSQL?

Der Lehrer fordert beide Datenbanktypen. Im Projekt werden sie sinnvoll getrennt:

- **MongoDB / NoSQL:** User, Profile, Posts, Likes, Kommentare und flexible Social-Media-Daten
- **sqflite oder drift / SQL:** lokaler Cache, gespeicherte Posts und Session-Daten auf dem Gerät

## Dokumentation

Die Projektdokumentation befindet sich im Ordner `docs`.

Wichtige Dokumente:

- `docs/User Stories/User-Stories.md`
- `docs/SCRUM/Product-Backlog/Product-Backlog.md`
- `docs/SCRUM/Rollen/SCRUM-Rollen.md`
- `docs/SCRUM/Sprint-Planung/Sprint-Planung.md`
- `docs/Architektur/Architektur.md`
- `docs/Architektur/Docker.md`
- `docs/Architektur/Post-API.md`
- `docs/Architektur/Feed-API.md`
- `docs/Architektur/Mermaid-Architektur.md`
- `docs/Architektur/Service-Mermaid-Diagramm.md`
- `docs/GitHub/GitHub-Issues.md`

## App-Screenshots und Funktionsdokumentation

Die folgenden Screenshots dokumentieren den aktuellen Stand der Flutter-App im Emulator. Sie zeigen den wichtigsten Benutzerfluss von der Registrierung und Anmeldung bis zum Feed, Kommentieren und Bearbeiten des eigenen Profils.

### Authentifizierung

Die App startet für nicht angemeldete Benutzer mit dem Login-Screen. Bestehende Benutzer können sich mit E-Mail und Passwort anmelden. Über den Link **Create account** gelangt man zur Registrierung.

<img src="docs/Screenshots/Screenshot%202026-06-22%20114133.png" width="260" alt="Login-Screen mit E-Mail- und Passwortfeld">
<img src="docs/Screenshots/Screenshot%202026-06-22%20115401.png" width="260" alt="Leerer Login-Screen">
<img src="docs/Screenshots/Screenshot%202026-06-22%20115424.png" width="260" alt="Registrierungs-Screen">

Beim Registrieren werden E-Mail, Benutzername und Passwort erfasst. Nach erfolgreicher Anmeldung wird der JWT-Token vom Client verwendet, um geschützte Backend-Endpunkte wie Feed, Profil, Likes und Kommentare aufzurufen.

### Feed, Likes und Kommentare

Der Feed zeigt Posts aller Benutzer in einer chronologischen Kartenansicht. Jeder Post enthält Avatar, Anzeigename, Benutzername, Zeitangabe, Inhalt sowie die Anzahl der Likes und Kommentare. Die untere Navigation verbindet die Hauptbereiche **Feed**, **Post** und **Profile**.

<img src="docs/Screenshots/Screenshot%202026-06-22%20114920.png" width="260" alt="Pulse Feed mit mehreren Posts">
<img src="docs/Screenshots/Screenshot%202026-06-22%20115121.png" width="260" alt="Feed nach erstelltem Test-Post">

Über das Herzsymbol können Beiträge geliked werden. Das Kommentarsymbol öffnet die Kommentaransicht. Dort wird angezeigt, ob bereits Kommentare vorhanden sind, und am unteren Rand befindet sich das Eingabefeld zum Erstellen eines neuen Kommentars.

<img src="docs/Screenshots/Screenshot%202026-06-22%20115000.png" width="260" alt="Leere Kommentaransicht">
<img src="docs/Screenshots/Screenshot%202026-06-22%20115037.png" width="260" alt="Kommentaransicht mit einem Kommentar">

### Profil und Profilbearbeitung

Im Profil sieht der angemeldete Benutzer seine Profildaten und die eigenen Posts. Der Screen enthält zusätzlich Aktionen zum Bearbeiten des Profils und zum Abmelden.

<img src="docs/Screenshots/Screenshot%202026-06-22%20115246.png" width="260" alt="Profilansicht mit eigenem Post">

In der Profilbearbeitung können Benutzername und Bio angepasst werden. Die Änderungen werden über **Save changes** gespeichert und danach im Profil angezeigt.

<img src="docs/Screenshots/Screenshot%202026-06-22%20115330.png" width="260" alt="Profil bearbeiten mit Username und Bio">

## MVP

Der Fokus liegt auf einer stabilen, einfachen und präsentierbaren App. Reels, komplexe Story-Funktionen, Live-Chat, Push Notifications und grosse Zusatzfeatures werden nur umgesetzt, wenn nach dem MVP noch genügend Zeit bleibt.

## Repository-Struktur

```text
M335-Projekt/
  pulse-backend/     # Spring Boot REST API
  pulse-flutter/     # Flutter/Dart Mobile Client
  docker-compose.yml # MongoDB + mongo-express + Backend
  .env.example       # Vorlage für JWT_SECRET
  docs/
```

## Lokales Setup

### Voraussetzungen

- **Java 21** (`java -version`)
- **Maven 3.9+** (optional; Docker baut das Backend auch ohne lokales Maven)
- **Docker Desktop** mit `docker compose`
- **Flutter SDK**
- **Android Studio** oder **VS Code** mit Flutter/Dart Plugin

### `.env` einrichten

Im Repo-Root:

```powershell
Copy-Item .env.example .env
notepad .env
```

In `.env` muss ein eigener `JWT_SECRET` stehen. Die Datei `.env` darf nie committed werden.

### Stack starten

Minimal (MongoDB + Backend):

```powershell
docker compose up -d --build
```

Mit Mongo Express DB-GUI:

```powershell
docker compose --profile dev up -d --build
```

| Dienst | URL | Profil |
|---|---|---|
| REST API | http://localhost:8080 | default |
| Healthcheck | http://localhost:8080/actuator/health | default |
| Mongo Express | http://localhost:8081 | `dev` |
| MongoDB | `mongodb://root:fratton2026@localhost:27017/pulse?authSource=admin` | default |

Details zum Docker-Stack: [`docs/Architektur/Docker.md`](docs/Architektur/Docker.md)

```powershell
docker compose ps
docker compose logs -f backend
docker compose down
```

### Backend-Tests

```powershell
cd pulse-backend
mvn -B clean test
```

Die Tests prüfen unter anderem Auth, User, Security, Fehlerbehandlung, ArchUnit-Regeln und die JaCoCo-Coverage-Grenze.

### Flutter-Client

```powershell
cd pulse-flutter
flutter pub get
flutter analyze
flutter test
flutter run
```

Für API-Aufrufe aus dem Android Emulator wird diese Backend-URL verwendet:

```text
http://10.0.2.2:8080
```

## Endpoints

| Methode | Pfad | Auth |
|---|---|---|
| POST | `/api/auth/register` | nein |
| POST | `/api/auth/login` | nein |
| GET | `/api/users/me` | JWT |
| POST | `/api/posts` | JWT |
| GET | `/api/posts/feed` | JWT |
| DELETE | `/api/posts/{id}` | JWT |

## Auth-API testen

Registrieren:

```bash
curl -X POST http://localhost:8080/api/auth/register \
  -H "Content-Type: application/json" \
  -d "{\"email\":\"dev@pulse.test\",\"username\":\"devuser\",\"password\":\"password123\"}"
```

Login:

```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d "{\"email\":\"dev@pulse.test\",\"password\":\"password123\"}"
```

Aktueller User:

```bash
curl http://localhost:8080/api/users/me \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```
