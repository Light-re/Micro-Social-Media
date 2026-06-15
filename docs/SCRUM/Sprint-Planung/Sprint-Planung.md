# Sprint-Planung

Das Projekt wird agil mit Scrum geplant. Das Handoff beschreibt einen gemeinsamen Montag pro Woche und zusätzliche asynchrone Arbeit zwischen den Montagen.

Die Zielarchitektur besteht aus einer Flutter-App mit Dart, einem Spring Boot Backend, MongoDB als NoSQL-Datenbank und `sqflite` oder `drift` als lokaler SQL-Datenbank.

## Sprint 0: Setup und Vorbereitung

**Sprint-Ziel:** Alle Teammitglieder können das Projekt lokal starten und kennen ihre Rollen.

Geplante Aufgaben:

- Java 21 installieren und prüfen
- Docker Desktop installieren
- Flutter SDK installieren
- Android Studio oder VS Code einrichten
- Emulator einrichten
- Spring Boot Projekt `pulse-backend` erstellen
- Flutter Projekt `pulse-flutter` erstellen
- altes `pulse-android`-Skeleton nach Flutter migrieren und entfernen
- Docker Compose für Backend und MongoDB vorbereiten
- MongoDB Atlas oder lokale MongoDB vorbereiten
- User Stories als GitHub Issues anlegen
- GitHub Project Board einrichten

Verantwortung:

- Noé: Backend-Grundsetup, Docker, GitHub Board
- Ajan: User Stories, Product Backlog, Flutter-Migration und Dokumentation
- Alle: lokale Entwicklungsumgebung einrichten

## Sprint 1: Authentifizierung

**Sprint-Ziel:** Registrierung und Login funktionieren mit JWT und lokal gespeicherter Session.

Geplante User Stories:

- US-01 Registrierung öffnen
- US-02 Registrierung durchführen
- US-03 Nach Registrierung weiterleiten
- US-04 Login durchführen
- US-05 Login-Fehler anzeigen
- US-06 Logout durchführen
- US-07 Auth-Status prüfen
- US-26 Eingaben validieren
- US-27 E-Mail validieren
- US-28 Passwort validieren
- US-31 Fehler verständlich anzeigen

Technische Aufgaben:

- Spring Security konfigurieren
- JWT erstellen und prüfen
- Auth Endpoints erstellen
- Flutter Login und Register Screens umsetzen
- Token lokal mit `sqflite` oder `drift` speichern
- Session beim App-Start prüfen

Hauptverantwortung:

- Noé

## Sprint 2: Posts und Feed

**Sprint-Ziel:** User können Posts erstellen, im Feed sehen, liken und kommentieren.

Geplante User Stories:

- US-13 Beitrag erstellen
- US-14 Beitrag im Feed anzeigen
- US-15 Feed sortieren
- US-16 Leeren Feed anzeigen
- US-17 Beitrag liken
- US-18 Beitrag unliken
- US-19 Like-Anzahl anzeigen
- US-20 Kommentare öffnen
- US-21 Kommentar erstellen
- US-22 Kommentare anzeigen
- US-23 Kommentar-Anzahl anzeigen
- US-24 Eigenen Beitrag löschen
- US-25 Fremde Beiträge nicht löschen
- US-29 Ladezustand anzeigen
- US-30 Buttons während Laden sperren

Technische Aufgaben:

- Post-Modell in MongoDB erstellen
- PostController, PostService und PostRepository erstellen
- Endpoints für Feed, Create Post, Delete Post, Like, Unlike und Comments erstellen
- Flutter Feed Screen mit Backend anbinden
- Posts lokal mit `sqflite` oder `drift` cachen
- Empty State und Ladezustände im Feed anzeigen

Hauptverantwortung:

- Ajan

## Sprint 3: Follow und Profil

**Sprint-Ziel:** Profile und Follow-Funktionen sind nutzbar.

Geplante Aufgaben:

- Profil anzeigen
- Profil bearbeiten
- Eigene Beiträge im Profil anzeigen
- Follow/Unfollow vorbereiten
- Follower- und Following-Zähler aktualisieren

Hauptverantwortung:

- Alen

## Sprint 4: Explore und optionale Erweiterungen

**Sprint-Ziel:** Erweiterte Social-Media-Funktionen werden nur umgesetzt, wenn das MVP stabil ist.

Geplante Aufgaben:

- Explore-Page vorbereiten
- Optionale Benachrichtigungen prüfen
- Content-Moderation prüfen

Hauptverantwortung:

- Alen und Dylan

## Sprint 5: Testing, Bugfixing und Präsentation

**Sprint-Ziel:** Die App ist stabil, dokumentiert und präsentierbar.

Geplante Aufgaben:

- Manuelle Tests auf dem Emulator durchführen
- Happy Path und Fehlerfälle testen
- Bugs beheben
- UI verbessern
- Dokumentation vervollständigen
- Demo-Szenario vorbereiten
- Präsentation vorbereiten

Hauptverantwortung:

- Alle

## Sprint Review Vorlage

- Sprint:
- Geplante Stories:
- Fertiggestellte Stories:
- Nicht fertiggestellte Stories:
- Probleme:
- Erkenntnisse:

## Retrospektive Vorlage

- Was lief gut?
- Was lief nicht so gut?
- Was verbessern wir im nächsten Sprint?
