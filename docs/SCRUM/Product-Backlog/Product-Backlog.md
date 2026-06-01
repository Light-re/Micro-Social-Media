# Product Backlog

Dieses Product Backlog basiert auf den User Stories der Mini Social Media App. Die Priorisierung orientiert sich am MVP für ein realistisches 5-Wochen-Schulprojekt.

Die App wird als mobile App mit Flutter/Dart umgesetzt und lokal auf einem Emulator oder Handy gestartet. Das Backend wird mit Spring Boot entwickelt. PostgreSQL wird als SQL-Datenbank genutzt, MongoDB als NoSQL-Datenbank. Spring Boot, PostgreSQL und MongoDB werden mit Docker Compose gestartet.

## Prioritäten

- Must-have: notwendig für eine präsentierbare MVP-Version
- Should-have: wichtig, aber nicht zwingend für die erste Abgabe
- Nice-to-have: nur umsetzen, wenn am Ende genügend Zeit bleibt

## Status

- Offen: noch nicht begonnen
- In Arbeit: wird aktuell umgesetzt
- Fertig: implementiert und getestet

## Backlog

| ID | User Story | Priorität | Story Points | Sprint | Status |
|---|---|---|---:|---|---|
| US-01 | Registrierung öffnen | Must-have | 1 | Sprint 1 | Offen |
| US-02 | Registrierung durchführen | Must-have | 5 | Sprint 2 | Offen |
| US-03 | Nach Registrierung weiterleiten | Must-have | 2 | Sprint 2 | Offen |
| US-04 | Login durchführen | Must-have | 5 | Sprint 2 | Offen |
| US-05 | Login-Fehler anzeigen | Must-have | 3 | Sprint 2 | Offen |
| US-06 | Logout durchführen | Must-have | 2 | Sprint 2 | Offen |
| US-07 | Auth-Status prüfen | Must-have | 3 | Sprint 2 | Offen |
| US-08 | Eigenes Profil anzeigen | Must-have | 3 | Sprint 4 | Offen |
| US-09 | Eigene Beiträge im Profil anzeigen | Should-have | 3 | Sprint 4 | Offen |
| US-10 | Profil bearbeiten | Must-have | 5 | Sprint 4 | Offen |
| US-11 | Benutzername ändern | Must-have | 2 | Sprint 4 | Offen |
| US-12 | Bio ändern | Should-have | 2 | Sprint 4 | Offen |
| US-13 | Beitrag erstellen | Must-have | 5 | Sprint 3 | Offen |
| US-14 | Beitrag im Feed anzeigen | Must-have | 5 | Sprint 3 | Offen |
| US-15 | Feed sortieren | Must-have | 2 | Sprint 3 | Offen |
| US-16 | Leeren Feed anzeigen | Should-have | 2 | Sprint 3 | Offen |
| US-17 | Beitrag liken | Must-have | 5 | Sprint 4 | Offen |
| US-18 | Beitrag unliken | Must-have | 3 | Sprint 4 | Offen |
| US-19 | Like-Anzahl anzeigen | Must-have | 2 | Sprint 4 | Offen |
| US-20 | Kommentare öffnen | Must-have | 2 | Sprint 4 | Offen |
| US-21 | Kommentar erstellen | Must-have | 5 | Sprint 4 | Offen |
| US-22 | Kommentare anzeigen | Must-have | 3 | Sprint 4 | Offen |
| US-23 | Kommentar-Anzahl anzeigen | Should-have | 2 | Sprint 4 | Offen |
| US-24 | Eigenen Beitrag löschen | Must-have | 3 | Sprint 3 | Offen |
| US-25 | Fremde Beiträge nicht löschen | Must-have | 2 | Sprint 3 | Offen |
| US-26 | Eingaben validieren | Must-have | 3 | Sprint 2 | Offen |
| US-27 | E-Mail validieren | Must-have | 2 | Sprint 2 | Offen |
| US-28 | Passwort validieren | Must-have | 2 | Sprint 2 | Offen |
| US-29 | Ladezustand anzeigen | Must-have | 3 | Sprint 3 | Offen |
| US-30 | Buttons während Laden sperren | Should-have | 2 | Sprint 3 | Offen |
| US-31 | Fehler verständlich anzeigen | Must-have | 3 | Sprint 2 | Offen |
| US-32 | Netzwerkfehler anzeigen | Should-have | 2 | Sprint 5 | Offen |

## Technische Backlog Items

| ID | Aufgabe | Priorität | Sprint | Status |
|---|---|---|---|---|
| T-01 | Flutter-Projekt mit Dart erstellen | Must-have | Sprint 1 | Offen |
| T-02 | Spring Boot Backend erstellen | Must-have | Sprint 1 | Offen |
| T-03 | PostgreSQL als SQL-Datenbank vorbereiten | Must-have | Sprint 1 | Offen |
| T-04 | MongoDB als NoSQL-Datenbank vorbereiten | Must-have | Sprint 1 | Offen |
| T-05 | Docker Compose für Backend, PostgreSQL und MongoDB erstellen | Must-have | Sprint 1 | Offen |
| T-06 | REST API Struktur definieren | Must-have | Sprint 1 | Offen |
| T-07 | Auth-Endpunkte im Backend vorbereiten | Must-have | Sprint 2 | Offen |
| T-08 | App mit Backend API verbinden | Must-have | Sprint 2 | Offen |
| T-09 | Datenmodelle für User, Post, Comment und Like erstellen | Must-have | Sprint 2 | Offen |
| T-10 | SQL/NoSQL-Aufteilung dokumentieren | Should-have | Sprint 2 | Offen |
| T-11 | Fehlerbehandlung zwischen App und Backend standardisieren | Should-have | Sprint 3 | Offen |
| T-12 | Docker Setup dokumentieren | Should-have | Sprint 5 | Offen |

## MVP-Umfang

Für das MVP werden vor allem Registrierung, Login, Logout, Feed, Beiträge, Likes, Kommentare, Profil, Validierung, Ladezustände und verständliche Fehlermeldungen umgesetzt.

Technisch gehören Flutter/Dart, Spring Boot, PostgreSQL, MongoDB und Docker Compose zum MVP, weil diese Architektur für das Projekt geplant ist.

## Geplante Datenbank-Aufteilung

- PostgreSQL: User, Profile, Login-relevante Daten und Likes
- MongoDB: Posts und Kommentare

## Bewusst nicht im MVP

- Storys
- Reels oder Kurzvideos
- Live-Chat
- Private Nachrichten
- Push Notifications
- Follow-System
- Algorithmischer Feed
- Hashtags und Trends
- Video-Uploads
- React Web-Frontend
- Firebase als Backend
- Flutter Frontend in Docker starten
