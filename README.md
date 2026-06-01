# Pulse

Dieses Repository enthält das Schulprojekt **Pulse** für das Modul 335 - Mobile-Applikation realisieren.

Pulse ist eine mobile Social-Media-App für Android. Die App wird als native Android-App mit Java entwickelt. Das Backend wird mit Spring Boot umgesetzt und stellt eine REST API bereit. Für die Datenhaltung werden bewusst SQL und NoSQL eingesetzt.

## Projektart

- Modul: 335 - Mobile-Applikation realisieren
- Vorgehensmodell: Scrum
- Projektdauer: 5 Wochen
- App-Name: Pulse
- Mobile App: Android Native mit Java
- Backend: Spring Boot 4.0.6 mit Maven
- NoSQL-Datenbank: MongoDB
- SQL-Datenbank: Room Database / SQLite lokal auf dem Android-Gerät
- API-Kommunikation: REST mit Retrofit und OkHttp
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
- Lokaler Cache mit Room
- Validierung von Eingaben
- Ladezustände und Fehlermeldungen

## Architektur

```text
Android App (Java)
        |
        | Retrofit / REST API
        v
Spring Boot Backend
        |
        v
MongoDB (NoSQL, Cloud oder lokal)

Android App
        |
        v
Room Database / SQLite (SQL, lokal)
```

MongoDB wird für cloudbasierte Social-Media-Daten verwendet. Room wird lokal auf dem Android-Gerät für Cache, Bookmarks und Session-Daten verwendet.

## Warum SQL und NoSQL?

Der Lehrer fordert beide Datenbanktypen. Im Projekt werden sie sinnvoll getrennt:

- **MongoDB / NoSQL:** User, Profile, Posts, Likes, Kommentare und flexible Social-Media-Daten
- **Room / SQL:** lokaler Cache, gespeicherte Posts und Session-Daten auf dem Gerät

## Dokumentation

Die Projektdokumentation befindet sich im Ordner `docs`.

Wichtige Dokumente:

- `docs/User Stories/User-Stories.md`
- `docs/SCRUM/Product-Backlog/Product-Backlog.md`
- `docs/SCRUM/Rollen/SCRUM-Rollen.md`
- `docs/SCRUM/Sprint-Planung/Sprint-Planung.md`
- `docs/Architektur/Architektur.md`
- `docs/Aufgaben/Ajan-Neziri.md`
- `docs/GitHub/GitHub-Issues.md`

## MVP

Der Fokus liegt auf einer stabilen, einfachen und präsentierbaren App. Reels, komplexe Story-Funktionen, Live-Chat, Push Notifications und grosse Zusatzfeatures werden nur umgesetzt, wenn nach dem MVP noch genügend Zeit bleibt.

## Repository-Struktur

```text
M335/
  pulse-backend/     # Spring Boot 4.0.6 REST API
  pulse-android/     # Android Java Skeleton
  docker-compose.yml # MongoDB + mongo-express + Backend
  .env.example       # Vorlage für JWT_SECRET (keine Secrets committen)
  docs/
```

## Lokales Setup (Sprint 0)

### Was brauchen Teammitglieder?

Jede Person im Team:

1. **Repository klonen** (GitHub-Zugang vom Team).
2. **`.env` anlegen:** `.env.example` nach `.env` kopieren und einen **eigenen** `JWT_SECRET` setzen (siehe unten). Die Datei `.env` **niemals** committen.
3. **JWT_SECRET:** Entweder jede Person generiert lokal eine eigene Zeichenkette (min. 32 Zeichen), oder das Team teilt **einmal** ein gemeinsames Dev-Secret über einen **sicheren Kanal** (Teams-Chat, Passwort-Manager) — nur für lokale Entwicklung, nicht für Produktion.
4. **Docker-Stack (empfohlen):** `docker compose up -d` — MongoDB-Zugangsdaten (`root` / `fratton2026`) stehen in `docker-compose.yml` und sind **nur für lokale Entwicklung** gedacht; sie sind kein Geheimnis im Repo, aber nicht für echte Produktion verwenden.
5. **MongoDB Atlas (optional):** Wer die Cloud-DB nutzt, braucht eine Connection-String-URI (eigener Cluster oder **ein** Team-Cluster, URI nur per sicherem Kanal teilen, **nie** in Git). URI in `SPRING_DATA_MONGODB_URI` (Docker) oder `application-secrets.properties` (Maven lokal) eintragen.
6. **Android-Entwickler:** `google-services.json` lokal in `pulse-android/app/` legen (Firebase/Google — falls später benötigt). **Niemals** committen; steht in `.gitignore`.
7. **`OPENAI_API_KEY`:** Optional, für spätere Sprints (Content-Moderation). **Sprint 0 braucht ihn nicht.**

| Datei / Ort | Wer | Committen? |
|-------------|-----|------------|
| `.env` mit `JWT_SECRET` | Jeder lokal | **Nein** |
| `application-secrets.properties` | Optional, lokale Overrides | **Nein** |
| `google-services.json` | Android-Devs | **Nein** |
| `docker-compose.yml` Mongo-User/Pass | Alle (lokal gleich) | Ja (nur Dev) |
| Atlas Connection String | Team / Einzelperson | **Nein** (nur sicher teilen) |

### Voraussetzungen

- **Java 21** (`java -version`)
- **Maven 3.9+** (optional; Docker baut das Backend auch ohne lokales Maven)
- **Docker Desktop** mit `docker compose`
- **Android Studio** (für `pulse-android/`)

### Schritt-für-Schritt: `.env` einrichten (Windows)

Im **PowerShell**-Fenster im Repo-Root (`M335`):

```powershell
# 1) Vorlage kopieren
Copy-Item .env.example .env

# 2) JWT_SECRET erzeugen (Beispiel: 32 zufällige Bytes als Base64)
$bytes = New-Object byte[] 32
[System.Security.Cryptography.RandomNumberGenerator]::Fill($bytes)
$secret = [Convert]::ToBase64String($bytes)
Write-Host "Dein JWT_SECRET (in .env eintragen):"
Write-Host $secret

# 3) .env bearbeiten — JWT_SECRET=... ersetzen (Editor oder):
notepad .env
```

**Alternative mit OpenSSL** (falls installiert, z. B. Git Bash):

```bash
openssl rand -hex 32
```

Den ausgegebenen Wert als `JWT_SECRET=...` in `.env` speichern.

### Was ist `JWT_SECRET`?

`JWT_SECRET` ist **kein** API-Token und **nicht** etwas, das man per Login-Endpoint „generiert“. Es ist ein **festes Signiergeheimnis** auf dem Server: Damit signiert und prüft das Backend JWTs (Algorithmus HS256). Alle Instanzen, die dieselben Tokens akzeptieren sollen, brauchen **denselben** Secret-Wert.

- Mindestens **32 Zeichen** (länger ist ok).
- Zufällig und schwer erratbar (kein `password123`).
- Nur auf dem Server / in `.env` — **nie** in Git, nie in der Android-App.

Optional für `mvn spring-boot:run` ohne Docker-Backend:

```powershell
Copy-Item pulse-backend\src\main\resources\application-secrets.properties.example `
          pulse-backend\src\main\resources\application-secrets.properties
# jwt.secret=... und ggf. spring.data.mongodb.uri=... eintragen (Datei ist gitignored)
```

Docker liest primär `JWT_SECRET` aus `.env` (siehe `docker-compose.yml`).

### MongoDB: lokal (Docker) vs. Atlas

**Lokal mit Docker Compose (Standard für Sprint 0)**

In `docker-compose.yml` sind feste Dev-Credentials hinterlegt:

- Benutzer: `root`
- Passwort: `fratton2026`
- Datenbank: `pulse`
- URI (vom Host): `mongodb://root:fratton2026@localhost:27017/pulse?authSource=admin`

Diese Werte sind **absichtlich im Repo** dokumentiert — nur für **lokale Entwicklung** auf euren Rechnern, nicht für ein öffentliches Produktionssystem.

**MongoDB Atlas (optional, Cloud)**

- Cluster in [MongoDB Atlas](https://www.mongodb.com/atlas) anlegen.
- Connection String kopieren (z. B. `mongodb+srv://user:pass@cluster....mongodb.net/pulse`).
- Setzen als:
  - **Docker:** Umgebungsvariable `SPRING_DATA_MONGODB_URI` (in `docker-compose.yml` überschreiben oder in `.env` ergänzen und in Compose referenzieren), **oder**
  - **Maven lokal:** `SPRING_DATA_MONGODB_URI` als System-Env, **oder** in `application-secrets.properties`:
    ```properties
    spring.data.mongodb.uri=mongodb+srv://...
    ```

### Optionale Variablen

| Variable | Sprint 0 | Hinweis |
|----------|----------|---------|
| `JWT_SECRET` | **Ja** | Siehe oben |
| `SPRING_DATA_MONGODB_URI` | Nur bei Atlas / abweichendem Host | Sonst Default aus `application.properties` / Compose |
| `OPENAI_API_KEY` | **Nein** | Spätere Moderation; in `.env.example` auskommentiert |

### Backend-Tests

Im Ordner `pulse-backend` gibt es leichte **Slice-Tests** (`@WebMvcTest`, Mock von Services, kein MongoDB):

```powershell
cd pulse-backend
mvn test
```

Spring Boot 4 benötigt dafür die Test-Dependency `spring-boot-starter-webmvc-test` (bereits in `pom.xml`). Die Tests prüfen u. a. Auth-Register/Login (HTTP + Validierung) und dass `/api/users/me` ohne JWT abgewiesen wird.

### Stack starten (Docker)

```powershell
# Im Repo-Root, nach .env mit JWT_SECRET
docker compose up -d
```

| Dienst | URL |
|--------|-----|
| REST API | http://localhost:8080 |
| Mongo Express (GUI) | http://localhost:8081 |
| MongoDB (Host) | `mongodb://root:fratton2026@localhost:27017/pulse?authSource=admin` |

Mongo Express nutzt dieselben Dev-Credentials (`root` / `fratton2026`).

### Backend nur mit Maven (ohne Docker-Backend)

Mongo muss laufen:

```powershell
docker compose up -d mongo mongo-express
cd pulse-backend
mvn spring-boot:run
```

### Auth-API testen (curl, Windows CMD)

**Registrieren**

```bash
curl -X POST http://localhost:8080/api/auth/register ^
  -H "Content-Type: application/json" ^
  -d "{\"email\":\"dev@pulse.test\",\"username\":\"devuser\",\"password\":\"password123\"}"
```

**Login** (Token aus Feld `token` kopieren)

```bash
curl -X POST http://localhost:8080/api/auth/login ^
  -H "Content-Type: application/json" ^
  -d "{\"email\":\"dev@pulse.test\",\"password\":\"password123\"}"
```

**Aktueller User** (geschützt)

```bash
curl http://localhost:8080/api/users/me ^
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

Unter Linux/macOS `^` durch `\` ersetzen. In PowerShell kann `curl` ein Alias für `Invoke-WebRequest` sein — dann Git Bash oder `curl.exe` verwenden.

### Endpoints (Sprint 0)

| Methode | Pfad | Auth |
|---------|------|------|
| POST | `/api/auth/register` | nein |
| POST | `/api/auth/login` | nein |
| GET | `/api/users/me` | JWT `Bearer` |

Weitere APIs (z. B. Posts) benötigen dasselbe JWT im Header `Authorization: Bearer <token>`.

### Android

Siehe [pulse-android/README.md](pulse-android/README.md).

- Emulator → Backend: **`http://10.0.2.2:8080`** (nicht `localhost`).
- `google-services.json` pro Entwickler lokal, **nicht** committen.
