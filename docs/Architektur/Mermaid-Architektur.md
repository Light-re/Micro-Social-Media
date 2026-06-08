# Mermaid Architekturdiagramm

```mermaid
flowchart TB
    subgraph DEV["Entwicklungsumgebung"]
        IDE["Android Studio / VS Code"]
        EMU["Android Emulator / echtes Android-Gerät"]
        COMPASS["MongoDB Compass optional"]
        BROWSER["Browser"]
    end

    subgraph CLIENT["Flutter App: pulse-flutter"]
        UI["Widgets"]
        STATE["State / View Models geplant"]
        REPO["Repository Layer geplant"]
        HTTP["HTTP Client"]
        SQL["sqflite / drift\nSQL lokal"]
        SESSION["user_session\nJWT + eigenes Profil"]
        CACHE["posts_cache / bookmarks\nOffline-Cache"]
    end

    subgraph DOCKER["Docker Compose Stack"]
        BACKEND["Spring Boot Backend\npulse-backend\nPort 8080"]
        MONGO["MongoDB\nNoSQL\nPort 27017"]
        MONGOEXP["Mongo Express\nDB-GUI\nPort 8081"]
    end

    subgraph BACKEND_LAYERS["Backend-Schichten"]
        AUTH["AuthController / AuthService\nRegister, Login, JWT"]
        SECURITY["Spring Security\nJWT Filter"]
        USER["UserController / UserService"]
        POST["PostController / PostService\ngeplant"]
        COMMENT["Comment Logic\ngeplant"]
        LIKE["Like Logic\ngeplant"]
        MONGO_REPO["Spring Data MongoDB Repositories"]
    end

    subgraph MONGO_DATA["MongoDB Collections"]
        USERS["users"]
        POSTS["posts"]
        COMMENTS["comments / embedded comments"]
        LIKES["likes"]
        FOLLOWS["follows optional"]
    end

    subgraph OPTIONAL["Spätere optionale Dienste"]
        FCM["Firebase Cloud Messaging\nPush Notifications"]
        OPENAI["OpenAI Moderation API\nContent Moderation"]
    end

    IDE --> EMU
    EMU --> UI

    UI --> STATE
    STATE --> REPO
    REPO --> HTTP
    REPO --> SQL
    SQL --> SESSION
    SQL --> CACHE

    HTTP -->|"REST API\nhttp://10.0.2.2:8080/api"| BACKEND

    BACKEND --> SECURITY
    SECURITY --> AUTH
    SECURITY --> USER
    SECURITY --> POST
    SECURITY --> COMMENT
    SECURITY --> LIKE

    AUTH --> MONGO_REPO
    USER --> MONGO_REPO
    POST --> MONGO_REPO
    COMMENT --> MONGO_REPO
    LIKE --> MONGO_REPO

    MONGO_REPO --> MONGO
    MONGO --> USERS
    MONGO --> POSTS
    MONGO --> COMMENTS
    MONGO --> LIKES
    MONGO --> FOLLOWS

    BROWSER -->|"http://localhost:8081"| MONGOEXP
    MONGOEXP --> MONGO
    COMPASS -->|"mongodb://root:fratton2026@localhost:27017"| MONGO

    BACKEND -. "spätere Sprints" .-> OPENAI
    BACKEND -. "spätere Sprints" .-> FCM
```

## Kurz erklärt

- Die Flutter App läuft lokal in Android Studio oder VS Code auf einem Emulator oder echten Gerät.
- Die App nutzt einen HTTP-Client, um REST Requests an das Spring Boot Backend zu senden.
- Das Spring Boot Backend läuft im Docker Compose Stack auf Port `8080`.
- MongoDB läuft ebenfalls im Docker Compose Stack auf Port `27017`.
- Mongo Express läuft auf Port `8081` und dient als einfache Web-GUI für MongoDB.
- `sqflite` oder `drift` erfüllt den lokalen SQL-Teil des Projekts.
- MongoDB erfüllt den NoSQL-Teil des Projekts.
