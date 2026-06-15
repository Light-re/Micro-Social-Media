# Feed API

REST-Struktur fuer den Post-Feed. Baut auf [Post-API.md](Post-API.md) auf.

## Endpoint

| Methode | Pfad | Auth | Beschreibung |
|---|---|---|---|
| `GET` | `/api/posts/feed` | JWT | Alle Beitraege, neueste zuerst |

## Sortierung

- Standard: `createdAt` absteigend (neueste zuerst)
- Implementierung: `PostRepository.findAllByOrderByCreatedAtDesc()`
- Entspricht **US-15 Feed sortieren**

## Response DTO

### `FeedResponse`

```json
{
  "posts": [
    {
      "id": "post-2",
      "authorId": "user-1",
      "authorUsername": "devuser",
      "content": "Neuester Post",
      "createdAt": "2026-06-15T12:00:00Z",
      "likeCount": 1,
      "commentCount": 0
    },
    {
      "id": "post-1",
      "authorId": "user-2",
      "authorUsername": "alice",
      "content": "Aelterer Post",
      "createdAt": "2026-06-15T10:00:00Z",
      "likeCount": 0,
      "commentCount": 2
    }
  ]
}
```

| Feld | Typ | Beschreibung |
|---|---|---|
| `posts` | `PostResponse[]` | Sortierte Liste, kann leer sein (US-16) |

Java: `com.frattoninteractive.pulse.post.dto.FeedResponse`  
Flutter: `lib/features/feed/data/feed_response.dart`

## Flutter-Client

Der Feed-Screen mappt `FeedResponse.posts` auf Feed-Widgets. Leere Liste zeigt den Empty-State (US-16).

## Architektur

```text
PostController.getFeed() -> PostService.getFeed() -> PostRepository
```

Pagination ist fuer das MVP nicht vorgesehen.
