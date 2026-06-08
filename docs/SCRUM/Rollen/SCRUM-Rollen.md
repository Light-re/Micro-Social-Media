# Scrum-Rollen

In diesem Schulprojekt werden die Scrum-Rollen klar auf die Teammitglieder verteilt. Jede Rolle hat eigene Verantwortlichkeiten, damit die agile Zusammenarbeit strukturiert bleibt.

## Product Owner

**Verantwortlich:** Ajan Neziri

Aufgaben:

- Anforderungen und User Stories festlegen
- Product Backlog priorisieren und aktuell halten
- MVP-Umfang bestimmen
- GitHub Issues für User Stories vorbereiten
- Entscheiden, welche Features umgesetzt oder bewusst weggelassen werden
- Abnahme der fertigen Funktionen anhand der Akzeptanzkriterien

## Scrum Master

**Verantwortlich:** Noé Fratton

Aufgaben:

- Scrum-Prozess einhalten
- Sprint Planning, Standup, Review und Retrospektive moderieren
- Hindernisse dokumentieren und lösen
- GitHub Project Board pflegen
- Pull Requests prüfen und Reviews koordinieren
- Milestones nach jedem Sprint schliessen und neue erstellen

## Developers

**Verantwortlich:** Alen Arandjelovic und Dylan Kolb

Aufgaben:

- Flutter-App mit Dart entwickeln
- Spring Boot Backend mitentwickeln
- REST API zwischen App und Backend umsetzen
- MongoDB als NoSQL-Datenbank anbinden
- lokale SQL-Datenbank mit `sqflite` oder `drift` nutzen
- Features gemäss User Stories umsetzen
- Funktionen auf dem Emulator testen
- Pull Requests erstellen und reviewen

## Feature-Verantwortung

| Person | Hauptfeature | Verantwortlich für |
|---|---|---|
| Noé Fratton | Auth + Scrum | Register, Login, JWT, Spring Security, GitHub-Pflege, Sprint-Moderation |
| Ajan Neziri | Posts + Feed | Post-CRUD, Feed-Endpoint, Likes, Comments, Backlog pflegen, Flutter-Migration |
| Alen Arandjelovic | Follow + Profil | Follow/Unfollow, Profil-Page |
| Dylan Kolb | Explore + Testing | Explore-Page, UI-Feinschliff, manuelle Tests |

## Stakeholder

**Verantwortlich:** Lehrperson / Modulverantwortliche

Aufgaben:

- Anforderungen des Moduls vorgeben
- Feedback zum Projekt geben
- Bewertung der fertigen App und Dokumentation

## Scrum-Events Im Projekt

### Sprint Planning

Montag um 08:00 Uhr werden Backlog-Punkte geschätzt, das Sprint-Ziel definiert und Tasks verteilt.

### Daily Standup

Im kleinen Schulprojekt wird das Standup wöchentlich am Montag durchgeführt und bei Bedarf async im Gruppenchat ergänzt.

Fragen:

- Was habe ich seit dem letzten Standup fertiggestellt?
- Was werde ich bis zum nächsten Termin fertigstellen?
- Was blockiert mich gerade?

### Sprint Review

Am Montag um 16:30 Uhr wird gezeigt, was im Sprint fertig wurde.

### Sprint Retrospektive

Nach dem Review wird kurz reflektiert:

- Was lief gut?
- Was war schwierig?
- Was wird nächste Woche verbessert?

## Definition of Done

Eine User Story gilt als fertig, wenn:

- Code per Pull Request auf `main` gemerged ist
- keine Compile-Errors vorhanden sind
- keine offensichtlichen Runtime-Crashes auftreten
- die Funktion auf dem Emulator getestet wurde
- mindestens ein Fehlerfall getestet wurde
- ein anderes Teammitglied den Pull Request reviewed hat
- die GitHub Issue geschlossen und im Board auf Done ist
- keine API Keys oder Passwörter committed wurden
