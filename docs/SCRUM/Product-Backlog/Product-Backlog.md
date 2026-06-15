# Product Backlog

Dieses Product Backlog basiert auf den User Stories der App **Pulse**. Die Priorisierung orientiert sich am MVP für ein realistisches 5-Wochen-Schulprojekt.

Die App wird mit Flutter/Dart entwickelt. Das Backend wird mit Spring Boot umgesetzt. MongoDB wird als NoSQL-Datenbank verwendet. `sqflite` oder `drift` wird als lokale SQL-Datenbank auf dem Gerät eingesetzt.

## Prioritäten

- Must-have: notwendig für eine präsentierbare MVP-Version
- Should-have: wichtig, aber nicht zwingend für die erste Abgabe
- Nice-to-have: nur umsetzen, wenn am Ende genügend Zeit bleibt

## Status

- Offen: noch nicht begonnen
- In Arbeit: wird aktuell umgesetzt
- In Review: Pull Request offen
- Fertig: implementiert, reviewed und getestet

## Backlog

| ID | User Story | Priorität | Story Points | Sprint | Verantwortlich | Status |
|---|---|---|---:|---|---|---|
| US-01 | Registrierung öffnen | Must-have | 1 | Sprint 1 | Noé | Offen |
| US-02 | Registrierung durchführen | Must-have | 5 | Sprint 1 | Noé | Offen |
| US-03 | Nach Registrierung weiterleiten | Must-have | 2 | Sprint 1 | Noé | Offen |
| US-04 | Login durchführen | Must-have | 5 | Sprint 1 | Noé | Offen |
| US-05 | Login-Fehler anzeigen | Must-have | 3 | Sprint 1 | Noé | Offen |
| US-06 | Logout durchführen | Must-have | 2 | Sprint 1 | Noé | Offen |
| US-07 | Auth-Status prüfen | Must-have | 3 | Sprint 1 | Noé | Offen |
| US-08 | Eigenes Profil anzeigen | Must-have | 3 | Sprint 3 | Alen | Offen |
| US-09 | Eigene Beiträge im Profil anzeigen | Should-have | 3 | Sprint 3 | Alen | Offen |
| US-10 | Profil bearbeiten | Must-have | 5 | Sprint 3 | Alen | Offen |
| US-11 | Benutzername ändern | Must-have | 2 | Sprint 3 | Alen | Offen |
| US-12 | Bio ändern | Should-have | 2 | Sprint 3 | Alen | Offen |
| US-13 | Beitrag erstellen | Must-have | 5 | Sprint 2 | Ajan | Offen |
| US-14 | Beitrag im Feed anzeigen | Must-have | 5 | Sprint 2 | Ajan | Offen |
| US-15 | Feed sortieren | Must-have | 2 | Sprint 2 | Ajan | Offen |
| US-16 | Leeren Feed anzeigen | Should-have | 2 | Sprint 2 | Ajan | Offen |
| US-17 | Beitrag liken | Must-have | 5 | Sprint 2 | Ajan | Offen |
| US-18 | Beitrag unliken | Must-have | 3 | Sprint 2 | Ajan | Offen |
| US-19 | Like-Anzahl anzeigen | Must-have | 2 | Sprint 2 | Ajan | Offen |
| US-20 | Kommentare öffnen | Must-have | 2 | Sprint 2 | Ajan | Offen |
| US-21 | Kommentar erstellen | Must-have | 5 | Sprint 2 | Ajan | Offen |
| US-22 | Kommentare anzeigen | Must-have | 3 | Sprint 2 | Ajan | Offen |
| US-23 | Kommentar-Anzahl anzeigen | Should-have | 2 | Sprint 2 | Ajan | Offen |
| US-24 | Eigenen Beitrag löschen | Must-have | 3 | Sprint 2 | Ajan | Offen |
| US-25 | Fremde Beiträge nicht löschen | Must-have | 2 | Sprint 2 | Ajan | Offen |
| US-26 | Eingaben validieren | Must-have | 3 | Sprint 1 | Noé | Offen |
| US-27 | E-Mail validieren | Must-have | 2 | Sprint 1 | Noé | Offen |
| US-28 | Passwort validieren | Must-have | 2 | Sprint 1 | Noé | Offen |
| US-29 | Ladezustand anzeigen | Must-have | 3 | Sprint 2 | Ajan | Offen |
| US-30 | Buttons während Laden sperren | Should-have | 2 | Sprint 2 | Ajan | Offen |
| US-31 | Fehler verständlich anzeigen | Must-have | 3 | Sprint 1 | Noé | Offen |
| US-32 | Netzwerkfehler anzeigen | Should-have | 2 | Sprint 5 | Alle | Offen |

## Technische Backlog Items

| ID | Aufgabe | Priorität | Sprint | Verantwortlich | Status |
|---|---|---|---|---|---|
| T-01 | Flutter-Projekt `pulse-flutter` erstellen | Must-have | Sprint 0 | Noé | Fertig |
| T-02 | Spring Boot Projekt `pulse-backend` erstellen | Must-have | Sprint 0 | Noé | Fertig |
| T-03 | Docker Compose für Backend und MongoDB erstellen | Must-have | Sprint 0 | Noé | Fertig |
| T-04 | MongoDB Atlas oder lokale MongoDB vorbereiten | Must-have | Sprint 0 | Noé | Fertig |
| T-05 | Lokale SQL-Datenbank im Flutter-Projekt vorbereiten (`sqflite` oder `drift`) | Must-have | Sprint 1 | Noé | Offen |
| T-06 | GitHub Issues aus User Stories erstellen | Must-have | Sprint 0 | Ajan | Fertig |
| T-07 | Product Backlog priorisieren und pflegen | Must-have | Sprint 0-5 | Ajan | In Arbeit |
| T-08 | Flutter-Projekt `pulse-flutter` initialisieren | Must-have | Sprint 0 | Ajan | Fertig |
| T-09 | Java/Android-Skeleton nach Flutter/Dart migrieren | Must-have | Sprint 0 | Ajan | Fertig |
| T-10 | Legacy-Ordner `pulse-android` entfernen | Must-have | Sprint 0 | Ajan | Fertig |
| T-11 | Architektur- und Scrum-Dokumentation auf Flutter/Dart aktualisieren | Must-have | Sprint 0 | Ajan | Fertig |
| T-12 | Flutter CI-Job ergänzen | Should-have | Sprint 1 | Ajan | Offen |
| T-13 | Post-API-Struktur definieren | Must-have | Sprint 2 | Ajan | Offen |
| T-14 | Feed-API-Struktur definieren | Must-have | Sprint 2 | Ajan | Offen |
| T-15 | SQL/NoSQL-Aufteilung dokumentieren | Should-have | Sprint 0 | Ajan | Fertig |

## MVP-Umfang

Für das MVP werden Registrierung, Login, Feed, Posts, Likes, Kommentare, Profil, lokale Session-Speicherung, Validierung, Ladezustände und verständliche Fehlermeldungen umgesetzt.

## Bewusst nicht im MVP

- Reels oder Kurzvideos
- Vollständiger Live-Chat
- Komplexe Stories mit allen Details
- Push Notifications als Muss-Funktion
- Algorithmischer Feed
- Hashtags und Trends als Kernfunktion
- React Web-Frontend
