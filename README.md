# Mini Social Media App

Dieses Repository enthält ein Schulprojekt für das Modul 335 - Mobile-Applikation realisieren.

Ziel ist eine einfache Social-Media-App als Handy-App. Die App wird mit Flutter und Dart entwickelt und läuft lokal auf einem Emulator oder einem echten Handy. Das Backend wird mit Spring Boot umgesetzt und über eine REST API mit der App verbunden.

Backend, PostgreSQL und MongoDB werden mit Docker Compose gestartet. PostgreSQL wird als SQL-Datenbank verwendet, MongoDB als NoSQL-Datenbank.

## Projektart

- Modul: 335 - Mobile-Applikation realisieren
- Vorgehensmodell: Scrum
- Projektdauer: 5 Wochen
- Mobile App: Flutter mit Dart
- Backend: Spring Boot
- SQL-Datenbank: PostgreSQL
- NoSQL-Datenbank: MongoDB
- Containerisierung: Docker / Docker Compose
- Kommunikation: REST API

## Geplante Hauptfunktionen

- Registrierung
- Login und Logout
- Profil anzeigen und bearbeiten
- Beitrag erstellen
- Feed anzeigen
- Beiträge liken und unliken
- Beiträge kommentieren
- Eigene Beiträge löschen
- Validierung von Eingaben
- Ladezustände und Fehlermeldungen

## Architektur

Die geplante Architektur besteht aus einer lokal gestarteten Flutter Mobile App und containerisierten Backend-Services:

```text
Flutter App lokal / Emulator
        |
        | REST API
        v
Docker Compose
        |
        +--> Spring Boot Backend
        +--> PostgreSQL (SQL)
        +--> MongoDB (NoSQL)
```

Die Flutter App wird nicht über Docker Compose gestartet, sondern lokal mit `flutter run`. Docker Compose startet das Spring Boot Backend, PostgreSQL und MongoDB.

## Datenhaltung

Die App verwendet bewusst zwei verschiedene Datenbanktypen:

- PostgreSQL für strukturierte relationale Daten wie User, Profile und Likes
- MongoDB für dokumentbasierte Social-Media-Inhalte wie Posts und Kommentare

Diese Aufteilung zeigt den Einsatz von SQL und NoSQL in einem gemeinsamen Projekt.

## Warum Dart?

Dart ist die Programmiersprache von Flutter. Da das Projekt eine Handy-App ist, wird die mobile App mit Flutter/Dart umgesetzt.

## Warum Spring Boot?

Spring Boot wird für das Backend verwendet. Es stellt die REST API bereit, verarbeitet Login, Beiträge, Likes, Kommentare und Profile und verbindet sich mit PostgreSQL und MongoDB.

## Warum Docker?

Docker wird verwendet, damit Backend, SQL-Datenbank und NoSQL-Datenbank einfach und einheitlich gestartet werden können. Dadurch ist die Entwicklungsumgebung für das Team besser nachvollziehbar.

## Dokumentation

Die Projektdokumentation befindet sich im Ordner `docs`.

Wichtige Dokumente:

- `docs/User Stories/User-Stories.md`
- `docs/SCRUM/Product-Backlog/Product-Backlog.md`
- `docs/SCRUM/Rollen/SCRUM-Rollen.md`
- `docs/SCRUM/Sprint-Planung/Sprint-Planung.md`

## MVP

Der Fokus liegt auf einer stabilen, einfachen und präsentierbaren App. Funktionen wie Reels, Storys, Live-Chat, private Nachrichten, Push Notifications, React Web-Frontend oder Firebase werden bewusst weggelassen.
