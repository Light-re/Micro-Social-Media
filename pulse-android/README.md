# Pulse Android

Sprint-0 skeleton for the Pulse Android app (`com.frattoninteractive.pulse`).

## Open in Android Studio

1. Install [Android Studio](https://developer.android.com/studio) with SDK 35 and JDK 17+.
2. **File → Open** and select this folder: `pulse-android/`.
3. Wait for **Gradle Sync** to finish (downloads dependencies on first open).
4. Create or start an emulator (API 26+), then **Run** the `app` configuration.

## Notes

- `minSdk` 26, `targetSdk` 35, Java source level 17.
- Retrofit, Room, Lifecycle, and Navigation are on the classpath but not wired yet (Sprint 1).
- Do **not** commit `local.properties` or `google-services.json` (see repo root `.gitignore`).
- For API calls to the local backend, use `http://10.0.2.2:8080` from the Android emulator.
- Cleartext HTTP is allowed only for `localhost`, `127.0.0.1`, and `10.0.2.2` via `res/xml/network_security_config.xml` (not app-wide). For a physical device on Wi‑Fi, add your PC’s LAN IP as another `<domain>` there if needed.

## Backend

Start the API from the repo root: `docker compose up -d` (see root `README.md`).
