# Sprint-Planung

Das Projekt wird agil mit Scrum geplant. Da das Schulprojekt fünf Wochen dauert, wird jede Woche als ein Sprint betrachtet. Jeder Sprint hat ein klares Sprint-Ziel und ausgewählte User Stories aus dem Product Backlog.

Die technische Zielarchitektur besteht aus einer Flutter App mit Dart, einem Spring Boot Backend, PostgreSQL als SQL-Datenbank, MongoDB als NoSQL-Datenbank und Docker Compose für Backend und Datenbanken.

Wichtig: Die Flutter App läuft lokal auf einem Emulator oder einem echten Handy. Docker Compose startet nur Spring Boot Backend, PostgreSQL und MongoDB.

## Sprint 1: Planung, Setup und Grundstruktur

**Zeitraum:** Woche 1

**Sprint-Ziel:** Die App und das Backend sind geplant, die Projektstruktur steht und die wichtigsten Screens sind als UI-Gerüst vorhanden.

Geplante User Stories:
- US-01 Registrierung öffnen
- Grundnavigation vorbereiten
- Login Screen als UI erstellen
- Register Screen als UI erstellen
- Home Feed Screen als UI erstellen
- Profile Screen als UI erstellen
- Create Post Screen als UI erstellen
- Comments Screen als UI erstellen

Technische Aufgaben:
- Projektanforderungen klären
- User Stories finalisieren
- Product Backlog erstellen
- Flutter-Projekt mit Dart vorbereiten
- Spring Boot Backend vorbereiten
- PostgreSQL als SQL-Datenbank einplanen
- MongoDB als NoSQL-Datenbank einplanen
- Docker Compose für Backend, PostgreSQL und MongoDB vorbereiten
- REST API grob planen
- SQL/NoSQL-Aufteilung festlegen
- Ordnerstruktur für App und Backend festlegen
- Grunddesign der mobilen App festlegen

Ergebnis:
Eine klickbare Flutter-App-Struktur und ein vorbereitetes Backend-Grundgerüst mit geplanter SQL/NoSQL-Datenhaltung.

## Sprint 2: Authentifizierung und User-Verwaltung

**Zeitraum:** Woche 2

**Sprint-Ziel:** User können sich über die mobile App registrieren, einloggen und ausloggen. Die App kommuniziert dafür mit dem Spring Boot Backend.

Geplante User Stories:
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
- User-Modell im Backend erstellen
- Auth Controller im Spring Boot Backend erstellen
- Registrierung als REST Endpoint umsetzen
- Login als REST Endpoint umsetzen
- Passwort sicher behandeln
- PostgreSQL Anbindung für User und Profile einrichten
- Flutter App mit Auth API verbinden
- Auth-Status in der App speichern
- Validierung und Fehlermeldungen in der App einbauen

Ergebnis:
User können sich über die App anmelden, und User-Daten werden über das Backend in PostgreSQL verarbeitet.

## Sprint 3: Beiträge und Feed

**Zeitraum:** Woche 3

**Sprint-Ziel:** User können Beiträge erstellen, im Feed sehen und eigene Beiträge löschen.

Geplante User Stories:
- US-13 Beitrag erstellen
- US-14 Beitrag im Feed anzeigen
- US-15 Feed sortieren
- US-16 Leeren Feed anzeigen
- US-24 Eigenen Beitrag löschen
- US-25 Fremde Beiträge nicht löschen
- US-29 Ladezustand anzeigen
- US-30 Buttons während Laden sperren

Technische Aufgaben:
- Post-Modell für MongoDB erstellen
- REST Endpoints für Beiträge erstellen
- Beiträge in MongoDB speichern
- Feed Endpoint nach Datum sortieren
- Flutter Feed Screen mit Backend verbinden
- Beitrag erstellen in der App umsetzen
- Beitrag löschen nur für eigene Beiträge erlauben
- Ladezustände in der App anzeigen

Ergebnis:
Der Feed funktioniert als Kernbereich der App und nutzt MongoDB für Beiträge.

## Sprint 4: Likes, Kommentare und Profil

**Zeitraum:** Woche 4

**Sprint-Ziel:** Die App bekommt typische Social-Media-Funktionen wie Likes, Kommentare und Profilbearbeitung.

Geplante User Stories:
- US-08 Eigenes Profil anzeigen
- US-09 Eigene Beiträge im Profil anzeigen
- US-10 Profil bearbeiten
- US-11 Benutzername ändern
- US-12 Bio ändern
- US-17 Beitrag liken
- US-18 Beitrag unliken
- US-19 Like-Anzahl anzeigen
- US-20 Kommentare öffnen
- US-21 Kommentar erstellen
- US-22 Kommentare anzeigen
- US-23 Kommentar-Anzahl anzeigen

Technische Aufgaben:
- Profile Endpoints im Backend erstellen
- Profil in PostgreSQL speichern und aktualisieren
- Like-Modell und Like Endpoints erstellen
- Likes in PostgreSQL speichern
- Comment-Modell für MongoDB erstellen
- Kommentare in MongoDB speichern
- Comments Screen mit Backend verbinden
- Like-Anzahl und Kommentar-Anzahl anzeigen
- Eigene Beiträge im Profil laden

Ergebnis:
Die App ist als einfache Social-Media-App vollständig nutzbar und verwendet SQL und NoSQL sinnvoll zusammen.

## Sprint 5: Testing, Bugfixing, Docker-Doku und Präsentation

**Zeitraum:** Woche 5

**Sprint-Ziel:** Die App wird stabilisiert, getestet und für die Abgabe vorbereitet.

Geplante User Stories:
- US-32 Netzwerkfehler anzeigen
- Offene Must-have Stories fertigstellen
- Fehler aus vorherigen Sprints beheben

Technische Aufgaben:
- Manuelle Tests durchführen
- Flutter App lokal auf Emulator oder Handy testen
- Backend, PostgreSQL und MongoDB über Docker Compose testen
- Login, Registrierung, Feed, Likes, Kommentare und Profil testen
- Fehler beheben
- Netzwerkfehler sinnvoll anzeigen
- UI verbessern
- Dokumentation vervollständigen
- Docker Startanleitung dokumentieren
- SQL/NoSQL-Aufteilung dokumentieren
- Screenshots vorbereiten
- Präsentation und Demo-Ablauf vorbereiten

Ergebnis:
Eine stabile und präsentierbare MVP-Version der Mini Social Media App.

## Sprint Review Vorlage

Am Ende jedes Sprints wird kurz dokumentiert:

- Sprint:
- Geplante Stories:
- Fertiggestellte Stories:
- Nicht fertiggestellte Stories:
- Probleme:
- Erkenntnisse:

## Retrospektive Vorlage

Am Ende jedes Sprints wird kurz reflektiert:

- Was lief gut?
- Was lief nicht so gut?
- Was verbessern wir im nächsten Sprint?
