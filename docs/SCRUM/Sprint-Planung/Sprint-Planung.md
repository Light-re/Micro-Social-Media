# Sprint-Planung

Das Projekt wird agil mit Scrum geplant. Da das Schulprojekt fünf Wochen dauert, wird jede Woche als ein Sprint betrachtet. Jeder Sprint hat ein klares Sprint-Ziel und ausgewählte User Stories aus dem Product Backlog.

## Sprint 1: Planung, Setup und UI-Grundstruktur

**Zeitraum:** Woche 1

**Sprint-Ziel:** Die App ist geplant, die Grundstruktur steht und die wichtigsten Screens sind als UI-Gerüst vorhanden.

Geplante User Stories:
- US-01 Registrierung öffnen
- Grundnavigation vorbereiten
- Login Screen als UI erstellen
- Register Screen als UI erstellen
- Home Feed Screen als UI erstellen
- Profile Screen als UI erstellen
- Create Post Screen als UI erstellen
- Comments Screen als UI erstellen

Aufgaben:
- Projektanforderungen klären
- User Stories finalisieren
- Product Backlog erstellen
- Flutter-Projekt vorbereiten
- Ordnerstruktur planen
- Navigation zwischen Screens vorbereiten
- Grunddesign festlegen

Ergebnis:
Eine klickbare App-Struktur ohne vollständige Firebase-Logik.

## Sprint 2: Authentifizierung

**Zeitraum:** Woche 2

**Sprint-Ziel:** User können sich registrieren, einloggen und ausloggen.

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

Aufgaben:
- Firebase Authentication einrichten
- Registrierung implementieren
- Login implementieren
- Logout implementieren
- Auth-Status beim App-Start prüfen
- Validierung für Login und Registrierung einbauen
- Fehlermeldungen verständlich anzeigen

Ergebnis:
User können sich sicher anmelden und die App erkennt, ob ein User eingeloggt ist.

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

Aufgaben:
- Post-Datenmodell erstellen
- Firestore-Struktur für Beiträge vorbereiten
- Beitrag erstellen implementieren
- Feed aus Firestore laden
- Beiträge nach Datum sortieren
- Empty State für leeren Feed anzeigen
- Eigene Beiträge löschen
- Löschoption nur bei eigenen Beiträgen anzeigen

Ergebnis:
Der Feed funktioniert als Kernbereich der App.

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

Aufgaben:
- User-Daten in Firestore speichern und laden
- Profil anzeigen
- Profil bearbeiten
- Eigene Beiträge im Profil anzeigen
- Like- und Unlike-Funktion implementieren
- Like-Anzahl aktualisieren
- Comments Screen umsetzen
- Kommentare speichern und anzeigen
- Kommentar-Anzahl anzeigen

Ergebnis:
Die App ist als einfache Social-Media-App vollständig nutzbar.

## Sprint 5: Testing, Bugfixing, Dokumentation und Präsentation

**Zeitraum:** Woche 5

**Sprint-Ziel:** Die App wird stabilisiert, getestet und für die Abgabe vorbereitet.

Geplante User Stories:
- US-32 Netzwerkfehler anzeigen
- Offene Must-have Stories fertigstellen
- Fehler aus vorherigen Sprints beheben

Aufgaben:
- Manuelle Tests durchführen
- Login, Registrierung, Feed, Likes, Kommentare und Profil testen
- Fehler beheben
- UI verbessern
- Dokumentation vervollständigen
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
