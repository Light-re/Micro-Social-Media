# Post API

REST-Struktur fuer Beitraege in MongoDB (`posts` Collection). Implementiert in `pulse-backend` unter `com.frattoninteractive.pulse.post`.

Siehe auch: [Feed-API.md](Feed-API.md)

## Endpoints

| Methode | Pfad | Auth | Beschreibung |
|---|---|---|---|
| `POST` | `/api/posts` | JWT | Beitrag erstellen |
| `DELETE` | `/api/posts/{postId}` | JWT | Eigenen Beitrag loeschen |

## Request DTOs

### `CreatePostRequest`

```json
{
  "content": "Mein erster Pulse-Post"
}
```

| Feld | Typ | Regeln |
|---|---|---|
| `content` | string | Pflicht, max. 500 Zeichen |

Java: `com.frattoninteractive.pulse.post.dto.CreatePostRequest`

## Response DTO

### `PostResponse`

```json
{
  "id": "665f1c2f9a1b2c3d4e5f6789",
  "authorId": "user-1",
  "authorUsername": "devuser",
  "content": "Mein erster Pulse-Post",
  "createdAt": "2026-06-15T10:00:00Z",
  "likeCount": 0,
  "commentCount": 0
}
```

Java: `com.frattoninteractive.pulse.post.dto.PostResponse`  
Flutter: `lib/features/feed/data/post_response.dart`

## MongoDB Collection `posts`

| Feld | Typ | Index | Beschreibung |
|---|---|---|---|
| `_id` | ObjectId/string | PK | Post-ID |
| `authorId` | string | ja | User-ID des Autors |
| `authorUsername` | string | nein | Denormalisiert fuer Feed-Anzeige |
| `content` | string | nein | Post-Text |
| `createdAt` | ISO-8601 instant | ja | Erstellungszeitpunkt |
| `likeCount` | number | nein | Anzahl Likes (Default 0) |
| `commentCount` | number | nein | Anzahl Kommentare (Default 0) |

## Fehlerfaelle

| Status | Situation |
|---|---|
| `400` | Validierung (`content` leer/zu lang) |
| `401` | Kein gueltiges JWT |
| `403` | Fremden Post loeschen |
| `404` | Post existiert nicht |

## Architektur

```text
PostController -> PostService -> PostRepository
                      |
                      v
                   UserService (Autor-Username)
```

Likes und Kommentare werden in separaten User Stories ergaenzt.
