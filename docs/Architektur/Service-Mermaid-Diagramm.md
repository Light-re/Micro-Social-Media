# Service Mermaid Diagramm

Dieses Diagramm zeigt die geplanten Services von Pulse. Die bereits vorhandenen Services sind grün markiert. Geplante Services sind grau gestrichelt.

```mermaid
flowchart TB
    APP["Flutter App\npulse-flutter\nDart"]

    subgraph BACKEND["Spring Boot Backend: pulse-backend"]
        subgraph EXISTING["Bereits vorhanden"]
            AUTH_CTRL["AuthController\nPOST /api/auth/register\nPOST /api/auth/login"]
            AUTH_SVC["AuthService"]
            JWT["JWT / Spring Security\nJwtUtil\nJwtAuthenticationFilter\nSecurityConfig"]

            USER_CTRL["UserController\nGET /api/users/me"]
            USER_SVC["UserService"]
            USER_REPO["UserRepository\nMongoRepository"]

            ERRORS["GlobalExceptionHandler\nValidation / Conflict / Unauthorized"]
        end

        subgraph PLANNED_CORE["Geplant für MVP"]
            POST_CTRL["PostController\nPOST /api/posts\nDELETE /api/posts/{id}"]
            POST_SVC["PostService"]
            FEED_CTRL["FeedController\nGET /api/feed"]
            FEED_SVC["FeedService"]
            LIKE_CTRL["LikeController\nPOST /api/posts/{id}/like\nDELETE /api/posts/{id}/like"]
            LIKE_SVC["LikeService"]
            COMMENT_CTRL["CommentController\nGET /api/posts/{id}/comments\nPOST /api/posts/{id}/comments"]
            COMMENT_SVC["CommentService"]
        end

        subgraph PLANNED_EXTRA["Optional / spätere Sprints"]
            FOLLOW_SVC["FollowService\nFollow / Unfollow"]
            EXPLORE_SVC["ExploreService\nExplore Feed"]
            MEDIA_SVC["MediaService\nBilder Upload"]
            NOTIFY_SVC["NotificationService\nPush Notifications"]
            MODERATION_SVC["ModerationService\nContent Moderation"]
        end
    end

    subgraph DATA["Datenhaltung"]
        MONGO["MongoDB\nNoSQL"]
        SQL["sqflite / drift\nSQL lokal im Flutter-Client"]
    end

    subgraph EXTERNAL["Externe / optionale Dienste"]
        FCM["Firebase Cloud Messaging\noptional"]
        OPENAI["OpenAI Moderation API\noptional"]
    end

    APP -->|"REST API über HTTP Client"| AUTH_CTRL
    APP -->|"REST API über HTTP Client"| USER_CTRL
    APP -. "später" .-> POST_CTRL
    APP -. "später" .-> FEED_CTRL
    APP -. "später" .-> LIKE_CTRL
    APP -. "später" .-> COMMENT_CTRL

    APP --> SQL

    AUTH_CTRL --> AUTH_SVC
    AUTH_SVC --> USER_SVC
    AUTH_SVC --> JWT

    USER_CTRL --> JWT
    USER_CTRL --> USER_SVC
    USER_SVC --> USER_REPO
    USER_REPO --> MONGO

    POST_CTRL -.-> POST_SVC
    POST_SVC -.-> MONGO
    FEED_CTRL -.-> FEED_SVC
    FEED_SVC -.-> MONGO
    LIKE_CTRL -.-> LIKE_SVC
    LIKE_SVC -.-> MONGO
    COMMENT_CTRL -.-> COMMENT_SVC
    COMMENT_SVC -.-> MONGO

    FOLLOW_SVC -.-> MONGO
    EXPLORE_SVC -.-> MONGO
    MEDIA_SVC -.-> MONGO
    NOTIFY_SVC -.-> FCM
    MODERATION_SVC -.-> OPENAI

    AUTH_CTRL --> ERRORS
    USER_CTRL --> ERRORS
    POST_CTRL -.-> ERRORS
    COMMENT_CTRL -.-> ERRORS
```

## Legende

- Grün: bereits im Backend vorhanden
- Grau gestrichelt: geplant, aber noch nicht umgesetzt
- Blau: Datenhaltung
- Gelb: Flutter App
- Violett gestrichelt: externe optionale Dienste

## Bereits vorhandene Backend-Services

- `AuthController`
- `AuthService`
- `JwtUtil`
- `JwtAuthenticationFilter`
- `SecurityConfig`
- `UserController`
- `UserService`
- `UserRepository`
- `GlobalExceptionHandler`

## Geplante MVP-Services

- `PostService`
- `FeedService`
- `LikeService`
- `CommentService`
