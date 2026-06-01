# Pulse

Dieses Repository enthält das Schulprojekt **Pulse** für das Modul 335 - Mobile-Applikation realisieren.

Pulse ist eine mobile Social-Media-App für Android. Die App wird als native Android-App mit Java entwickelt. Das Backend wird mit Spring Boot umgesetzt und stellt eine REST API bereit. Für die Datenhaltung werden bewusst SQL und NoSQL eingesetzt.

## Projektart

- Modul: 335 - Mobile-Applikation realisieren
- Schule: WISS St. Gallen
- Vorgehensmodell: Scrum
- Projektdauer: 5 Wochen
- App-Name: Pulse
- Mobile App: Android Native mit Java
- Backend: Spring Boot mit Maven
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
