# GitHub Issues Vorlage

Diese Liste ist für Ajan vorbereitet. Jede User Story soll als eigenes GitHub Issue angelegt werden.

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
- `area:android`
- `area:scrum`

## Milestones

- Sprint 0
- Sprint 1
- Sprint 2
- Sprint 3
- Sprint 4
- Sprint 5

## Issues Für Ajan

### US-13 Beitrag erstellen

Labels: `type:user-story`, `priority:must-have`, `area:feed`, `area:backend`, `area:android`

Milestone: Sprint 2

Assignee: Ajan Neziri

Beschreibung:
Als User möchte ich einen Beitrag erstellen, damit ich Inhalte teilen kann.

Akzeptanzkriterium:
- Gegeben ich bin auf dem Create Post Screen
- Wenn ich einen gültigen Text veröffentliche
- Dann wird der Beitrag gespeichert

### US-14 Beitrag im Feed anzeigen

Labels: `type:user-story`, `priority:must-have`, `area:feed`

Milestone: Sprint 2

Assignee: Ajan Neziri

Beschreibung:
Als User möchte ich neue Beiträge im Feed sehen, damit ich aktuelle Inhalte lesen kann.

Akzeptanzkriterium:
- Gegeben ein Beitrag wurde erstellt
- Wenn ich den Feed öffne
- Dann wird der Beitrag angezeigt

### US-15 Feed sortieren

Labels: `type:user-story`, `priority:must-have`, `area:feed`

Milestone: Sprint 2

Assignee: Ajan Neziri

Beschreibung:
Als User möchte ich die neuesten Beiträge zuerst sehen, damit der Feed aktuell wirkt.

Akzeptanzkriterium:
- Gegeben mehrere Beiträge existieren
- Wenn der Feed geladen wird
- Dann stehen die neuesten Beiträge oben

### US-17 Beitrag liken

Labels: `type:user-story`, `priority:must-have`, `area:feed`

Milestone: Sprint 2

Assignee: Ajan Neziri

Beschreibung:
Als User möchte ich einen Beitrag liken, damit ich meine Zustimmung zeigen kann.

Akzeptanzkriterium:
- Gegeben ich habe einen Beitrag noch nicht gelikt
- Wenn ich auf Like tippe
- Dann wird der Beitrag gelikt

### US-18 Beitrag unliken

Labels: `type:user-story`, `priority:must-have`, `area:feed`

Milestone: Sprint 2

Assignee: Ajan Neziri

Beschreibung:
Als User möchte ich meinen Like entfernen, damit ich meine Reaktion ändern kann.

Akzeptanzkriterium:
- Gegeben ich habe einen Beitrag bereits gelikt
- Wenn ich erneut auf Like tippe
- Dann wird mein Like entfernt

### US-20 Kommentare öffnen

Labels: `type:user-story`, `priority:must-have`, `area:comments`

Milestone: Sprint 2

Assignee: Ajan Neziri

Beschreibung:
Als User möchte ich die Kommentare eines Beitrags öffnen, damit ich die Diskussion lesen kann.

Akzeptanzkriterium:
- Gegeben ich sehe einen Beitrag
- Wenn ich auf Kommentare tippe
- Dann öffnet sich der Comments Screen

### US-21 Kommentar erstellen

Labels: `type:user-story`, `priority:must-have`, `area:comments`

Milestone: Sprint 2

Assignee: Ajan Neziri

Beschreibung:
Als User möchte ich einen Kommentar schreiben, damit ich auf einen Beitrag reagieren kann.

Akzeptanzkriterium:
- Gegeben ich bin auf dem Comments Screen
- Wenn ich einen gültigen Kommentar absende
- Dann wird der Kommentar gespeichert

### US-22 Kommentare anzeigen

Labels: `type:user-story`, `priority:must-have`, `area:comments`

Milestone: Sprint 2

Assignee: Ajan Neziri

Beschreibung:
Als User möchte ich bestehende Kommentare sehen, damit ich die Reaktionen anderer lesen kann.

Akzeptanzkriterium:
- Gegeben ein Beitrag hat Kommentare
- Wenn ich den Comments Screen öffne
- Dann werden die Kommentare angezeigt

### US-24 Eigenen Beitrag löschen

Labels: `type:user-story`, `priority:must-have`, `area:feed`

Milestone: Sprint 2

Assignee: Ajan Neziri

Beschreibung:
Als User möchte ich meine eigenen Beiträge löschen, damit ich Kontrolle über meine Inhalte habe.

Akzeptanzkriterium:
- Gegeben ich sehe einen eigenen Beitrag
- Wenn ich ihn lösche
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
Das Product Backlog wird priorisiert und während des Projekts aktuell gehalten.

Akzeptanzkriterium:
- Gegeben sich Anforderungen oder Status ändern
- Wenn das Backlog geprüft wird
- Dann ist Priorität, Sprint und Status aktuell
