# GitHub Issues: Flutter Stack Pivot

Diese Issues decken den Wechsel von nativem Android (Java) zu Flutter (Dart) ab.

**Angelegt auf GitHub:**

| Task | Issue |
|---|---|
| T-08 Flutter-Projekt initialisieren | [#36](https://github.com/Light-re/Micro-Social-Media/issues/36) |
| T-09 Java-Skeleton migrieren | [#37](https://github.com/Light-re/Micro-Social-Media/issues/37) |
| T-10 pulse-android entfernen | [#38](https://github.com/Light-re/Micro-Social-Media/issues/38) |
| T-11 Dokumentation aktualisieren | [#39](https://github.com/Light-re/Micro-Social-Media/issues/39) |
| T-12 Flutter CI ergänzen | [#40](https://github.com/Light-re/Micro-Social-Media/issues/40) |

## Neue Labels

- `area:flutter` (ersetzt `area:android` für neue Mobile-Issues)
- `area:mobile` (optional, falls plattformübergreifend gemeint)

---

## Issue 1: Flutter-Projekt `pulse-flutter` initialisieren

**Titel:** T-08 Flutter-Projekt `pulse-flutter` initialisieren

**Labels:** `type:technical-task`, `priority:must-have`, `area:flutter`, `area:scrum`

**Milestone:** Sprint 0 oder Sprint 1

**Assignee:** Noé Fratton (oder Team-Entscheid)

**Beschreibung:**

Das Team wechselt von nativem Android (Java) zu Flutter (Dart). Ein neues Flutter-Projekt soll als offizieller Mobile-Client dienen und das alte `pulse-android/`-Skeleton ablösen.

**Akzeptanzkriterien:**

- Gegeben das Repository enthält noch kein Flutter-Projekt
- Wenn `pulse-flutter/` erstellt wird
- Dann existiert ein lauffähiges Flutter-Projekt mit Package-Name `com.frattoninteractive.pulse`
- Und die Standard-Ordnerstruktur `lib/features/` ist vorbereitet (z. B. `auth`, `feed`)
- Und `README.md` im Flutter-Ordner beschreibt Setup mit Flutter SDK und Android Studio / VS Code
- Und `flutter analyze` und `flutter test` laufen ohne Fehler (Basis-Skeleton)
- Und lokale Backend-URL für Emulator ist dokumentiert (`http://10.0.2.2:8080`)

**Abhängigkeiten:** Keine (kann parallel zu Issue 2 gestartet werden, Issue 2 setzt dieses voraus)

---

## Issue 2: Bestehendes `pulse-android` Java-Skeleton nach Dart/Flutter migrieren

**Titel:** T-09 `pulse-android` Java-Skeleton nach Flutter/Dart migrieren

**Labels:** `type:technical-task`, `priority:must-have`, `area:flutter`

**Milestone:** Sprint 1

**Assignee:** Noé Fratton (oder Team-Entscheid)

**Beschreibung:**

Das bestehende native Android-Skeleton in `pulse-android/` muss in das neue Flutter-Projekt überführt werden. Der Umfang ist aktuell klein (Sprint-0-Stand), soll aber vollständig portiert werden, damit nichts verloren geht.

**Zu migrierende Bestandteile aus `pulse-android/`:**

| Alt (Java/Android) | Neu (Flutter/Dart) |
|---|---|
| `MainActivity.java` + `activity_main.xml` | `main.dart` + Welcome/Home Screen Widget |
| `res/values/strings.xml` (`welcome_message`) | Flutter `strings` / Konstanten |
| `res/values/colors.xml`, `themes.xml` | Flutter `ThemeData` / `ColorScheme` |
| `network_security_config.xml` (Cleartext für localhost/10.0.2.2) | Android `network_security_config` in Flutter-Android-Teil oder `usesCleartextTraffic` in Debug |
| Emulator-Backend-URL `http://10.0.2.2:8080` | Gleiche URL in Flutter API-Konfiguration |
| App-ID `com.frattoninteractive.pulse` | Gleicher Package-Name in `pulse-flutter` |

**Akzeptanzkriterien:**

- Gegeben `pulse-flutter/` existiert (Issue 1)
- Wenn die Migration abgeschlossen ist
- Dann zeigt die Flutter-App dieselbe Welcome-Nachricht wie das alte Android-Skeleton
- Und Cleartext-HTTP zum lokalen Backend funktioniert im Emulator (localhost / 10.0.2.2)
- Und Theme/Farben sind sinnvoll portiert
- Und `flutter analyze` und `flutter test` sind grün
- Und die Migration ist in `pulse-flutter/README.md` kurz dokumentiert

**Hinweis:** Retrofit, Room und Navigation waren im Java-Projekt nur im Classpath, noch nicht implementiert — nicht portieren, sondern in Flutter mit `http`/`dio` und `sqflite`/`drift` neu aufbauen, wenn die Features anstehen.

**Abhängigkeiten:** Issue 1 (Flutter-Projekt initialisieren)

---

## Issue 3: Legacy `pulse-android` entfernen

**Titel:** T-10 Legacy-Ordner `pulse-android` entfernen

**Labels:** `type:technical-task`, `priority:should-have`, `area:flutter`

**Milestone:** Sprint 1

**Assignee:** Noé Fratton (oder Team-Entscheid)

**Beschreibung:**

Nach erfolgreicher Migration (Issue 2) wird der alte native Android-Ordner entfernt, damit das Team und AI-Agenten nicht mehr versehentlich Java-Code bearbeiten.

**Akzeptanzkriterien:**

- Gegeben die Flutter-Migration ist abgeschlossen und getestet
- Wenn `pulse-android/` entfernt wird
- Dann referenziert keine Agent-/Workflow-Datei mehr `pulse-android/` als aktiven Client
- Und Root-`README.md` verweist auf `pulse-flutter/`
- Und `.gitignore` ist für Flutter-Build-Artefakte angepasst

**Abhängigkeiten:** Issue 2

---

## Issue 4: Projekt-Dokumentation auf Flutter umstellen

**Titel:** T-11 Architektur- und Scrum-Dokumentation auf Flutter/Dart aktualisieren

**Labels:** `type:technical-task`, `priority:must-have`, `area:scrum`, `area:flutter`

**Milestone:** Sprint 0

**Assignee:** Ajan Neziri (oder Team-Entscheid)

**Beschreibung:**

Alle verbleibenden Projekt-Dokumente (README, Architektur-Diagramme, Product Backlog, Sprint-Planung, SCRUM-Rollen) sollen den Flutter/Dart-Stack widerspiegeln statt nativem Android Java und Room.

**Akzeptanzkriterien:**

- Gegeben Agent-Regeln bereits auf Flutter umgestellt sind
- Wenn die restliche Doku geprüft wird
- Dann erwähnen README, `docs/Architektur/`, Product Backlog und Sprint-Planung Flutter, Dart und sqflite/drift
- Und Mermaid-Diagramme zeigen `pulse-flutter` statt `pulse-android`
- Und Backlog-Tasks T-01/T-05 sind angepasst oder durch Flutter-Tasks ersetzt
- Und Git-Workflow beschreibt PRs nach `main` ohne `develop`-Branch

**Abhängigkeiten:** Kann parallel zu Issue 1–2 laufen

---

## Issue 5: Flutter CI in GitHub Actions ergänzen (optional)

**Titel:** T-12 Flutter CI-Job in GitHub Actions ergänzen

**Labels:** `type:technical-task`, `priority:should-have`, `area:flutter`, `area:backend`

**Milestone:** Sprint 1

**Assignee:** Noé Fratton (oder Team-Entscheid)

**Beschreibung:**

Aktuell prüft CI nur `pulse-backend`. Nach Einführung von `pulse-flutter/` soll auch der Mobile-Client in CI analysiert und getestet werden.

**Akzeptanzkriterien:**

- Gegeben `pulse-flutter/` existiert
- Wenn CI erweitert wird
- Dann läuft bei Push/PR auf `main` zusätzlich `flutter analyze` und `flutter test`
- Und der Workflow schlägt fehl, wenn Flutter-Analyse oder Tests fehlschlagen

**Abhängigkeiten:** Issue 1
