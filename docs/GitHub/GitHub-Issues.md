# GitHub Issues Vorlage

Diese Liste ist fuer Ajan vorbereitet. Jede User Story soll als eigenes GitHub Issue angelegt werden.

**Stack-Pivot (Flutter):** Siehe [Flutter-Stack-Pivot-Issues.md](Flutter-Stack-Pivot-Issues.md) fuer Issues zum Wechsel von nativem Android Java zu Flutter/Dart.

## Labels

- `type:user-story`
- `type:technical-task`
- `priority:must-have`
- `priority:should-have`
- `priority:nice-to-have`
- `area:auth`
- `area:feed`
- `area:profile`
- `area:comments`
- `area:backend`
- `area:flutter`
- `area:mobile`
- `area:scrum`

## Milestones

- Sprint 0
- Sprint 1
- Sprint 2
- Sprint 3
- Sprint 4
- Sprint 5

## Issues Fuer Ajan

### US-13 Beitrag erstellen

Labels: `type:user-story`, `priority:must-have`, `area:feed`, `area:backend`, `area:flutter`

Milestone: Sprint 2

Assignee: Ajan Neziri

Beschreibung:
Als User moechte ich einen Beitrag erstellen, damit ich Inhalte teilen kann.

Akzeptanzkriterium:
- Gegeben ich bin auf dem Create Post Screen
- Wenn ich einen gueltigen Text veroeffentliche
- Dann wird der Beitrag gespeichert

### US-14 Beitrag im Feed anzeigen

Labels: `type:user-story`, `priority:must-have`, `area:feed`

Milestone: Sprint 2

Assignee: Ajan Neziri

Beschreibung:
Als User moechte ich neue Beitraege im Feed sehen, damit ich aktuelle Inhalte lesen kann.

Akzeptanzkriterium:
- Gegeben ein Beitrag wurde erstellt
- Wenn ich den Feed oeffne
- Dann wird der Beitrag angezeigt

### US-15 Feed sortieren

Labels: `type:user-story`, `priority:must-have`, `area:feed`

Milestone: Sprint 2

Assignee: Ajan Neziri

Beschreibung:
Als User moechte ich die neuesten Beitraege zuerst sehen, damit der Feed aktuell wirkt.

Akzeptanzkriterium:
- Gegeben mehrere Beitraege existieren
- Wenn der Feed geladen wird
- Dann stehen die neuesten Beitraege oben

### US-17 Beitrag liken

Labels: `type:user-story`, `priority:must-have`, `area:feed`

Milestone: Sprint 2

Assignee: Ajan Neziri

Beschreibung:
Als User moechte ich einen Beitrag liken, damit ich meine Zustimmung zeigen kann.

Akzeptanzkriterium:
- Gegeben ich habe einen Beitrag noch nicht gelikt
- Wenn ich auf Like tippe
- Dann wird der Beitrag gelikt

### US-18 Beitrag unliken

Labels: `type:user-story`, `priority:must-have`, `area:feed`

Milestone: Sprint 2

Assignee: Ajan Neziri

Beschreibung:
Als User moechte ich meinen Like entfernen, damit ich meine Reaktion aendern kann.

Akzeptanzkriterium:
- Gegeben ich habe einen Beitrag bereits gelikt
- Wenn ich erneut auf Like tippe
- Dann wird mein Like entfernt

### US-20 Kommentare oeffnen

Labels: `type:user-story`, `priority:must-have`, `area:comments`

Milestone: Sprint 2

Assignee: Ajan Neziri

Beschreibung:
Als User moechte ich die Kommentare eines Beitrags oeffnen, damit ich die Diskussion lesen kann.

Akzeptanzkriterium:
- Gegeben ich sehe einen Beitrag
- Wenn ich auf Kommentare tippe
- Dann oeffnet sich der Comments Screen

### US-21 Kommentar erstellen

Labels: `type:user-story`, `priority:must-have`, `area:comments`

Milestone: Sprint 2

Assignee: Ajan Neziri

Beschreibung:
Als User moechte ich einen Kommentar schreiben, damit ich auf einen Beitrag reagieren kann.

Akzeptanzkriterium:
- Gegeben ich bin auf dem Comments Screen
- Wenn ich einen gueltigen Kommentar absende
- Dann wird der Kommentar gespeichert

### US-22 Kommentare anzeigen

Labels: `type:user-story`, `priority:must-have`, `area:comments`

Milestone: Sprint 2

Assignee: Ajan Neziri

Beschreibung:
Als User moechte ich bestehende Kommentare sehen, damit ich die Reaktionen anderer lesen kann.

Akzeptanzkriterium:
- Gegeben ein Beitrag hat Kommentare
- Wenn ich den Comments Screen oeffne
- Dann werden die Kommentare angezeigt

### US-24 Eigenen Beitrag loeschen

Labels: `type:user-story`, `priority:must-have`, `area:feed`

Milestone: Sprint 2

Assignee: Ajan Neziri

Beschreibung:
Als User moechte ich meine eigenen Beitraege loeschen, damit ich Kontrolle ueber meine Inhalte habe.

Akzeptanzkriterium:
- Gegeben ich sehe einen eigenen Beitrag
- Wenn ich ihn loesche
- Dann verschwindet der Beitrag aus dem Feed

### T-06 GitHub Issues aus User Stories erstellen

Labels: `type:technical-task`, `priority:must-have`, `area:scrum`

Milestone: Sprint 0

Assignee: Ajan Neziri

Beschreibung:
Alle User Stories werden als GitHub Issues angelegt und mit Label, Assignee und Milestone versehen.

Akzeptanzkriterium:
- Gegeben die User Stories sind dokumentiert
- Wenn Sprint 0 abgeschlossen ist
- Dann existieren die wichtigsten User Stories als GitHub Issues

### T-07 Product Backlog pflegen

Labels: `type:technical-task`, `priority:must-have`, `area:scrum`

Milestone: Sprint 0

Assignee: Ajan Neziri

Beschreibung:
Das Product Backlog wird priorisiert und waehrend des Projekts aktuell gehalten.

Akzeptanzkriterium:
- Gegeben sich Anforderungen oder Status aendern
- Wenn das Backlog geprueft wird
- Dann ist Prioritaet, Sprint und Status aktuell
