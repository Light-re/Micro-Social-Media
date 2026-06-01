# Mermaid Architekturdiagramm

```mermaid
flowchart TB
    subgraph DEV["Entwicklungsumgebung"]
        AS["Android Studio"]
        EMU["Android Emulator / echtes Android-Gerät"]
        COMPASS["MongoDB Compass optional"]
        BROWSER["Browser"]
    end

    subgraph CLIENT["Android App: pulse-android"]
        UI["Activities / Fragments / XML"]
        VM["ViewModel + LiveData"]
        REPO["Repository Layer"]
        RETROFIT["Retrofit + OkHttp"]
        ROOM["Room Database / SQLite\nSQL lokal"]
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

    AS --> EMU
    EMU --> UI

    UI --> VM
    VM --> REPO
    REPO --> RETROFIT
    REPO --> ROOM
    ROOM --> SESSION
    ROOM --> CACHE

    RETROFIT -->|"REST API\nhttp://10.0.2.2:8080/api\noder localhost bei Gerät/Setup"| BACKEND

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

    classDef local fill:#e8f2ff,stroke:#2f6fbb,color:#111;
    classDef docker fill:#fff4df,stroke:#c27b00,color:#111;
    classDef backend fill:#eaf7ea,stroke:#2d8a34,color:#111;
    classDef data fill:#f3e8ff,stroke:#7a3db8,color:#111;
    classDef optional fill:#f5f5f5,stroke:#777,color:#111,stroke-dasharray: 5 5;

    class AS,EMU,COMPASS,BROWSER,UI,VM,REPO,RETROFIT,ROOM,SESSION,CACHE local;
    class BACKEND,MONGO,MONGOEXP docker;
    class AUTH,SECURITY,USER,POST,COMMENT,LIKE,MONGO_REPO backend;
    class USERS,POSTS,COMMENTS,LIKES,FOLLOWS data;
    class FCM,OPENAI optional;
```

## Kurz erklärt

- Die Android App läuft lokal in Android Studio auf einem Emulator oder echten Android-Gerät.
- Die App nutzt Retrofit und OkHttp, um REST Requests an das Spring Boot Backend zu senden.
- Das Spring Boot Backend läuft im Docker Compose Stack auf Port `8080`.
- MongoDB läuft ebenfalls im Docker Compose Stack auf Port `27017`.
- Mongo Express läuft auf Port `8081` und dient als einfache Web-GUI für MongoDB.
- Room/SQLite läuft lokal auf dem Android-Gerät und erfüllt den SQL-Teil des Projekts.
- MongoDB erfüllt den NoSQL-Teil des Projekts.
- Firebase Cloud Messaging und OpenAI Moderation sind nur optionale spätere Erweiterungen.
