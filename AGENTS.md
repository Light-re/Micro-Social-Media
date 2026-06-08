# Pulse Agent Instructions

These rules apply to Codex and every other AI coding agent working in this repository.

- Keep the app realistic for the M335 school project: Flutter mobile client (`pulse-flutter/`), Spring Boot backend, Dockerized MongoDB, and simple service boundaries.
- The mobile stack is Flutter with Dart. Do not add new native Android Java code. Legacy `pulse-android/` exists only until migration is complete.
- Do not commit secrets, `.env`, Firebase files, local IDE settings, build outputs, or handoff documents.
- Keep architecture documentation in sync when backend services, Flutter client structure, Docker services, ports, or data stores change.
- For backend changes, run the Maven tests in `pulse-backend` before pushing. The CI requires at least 80% line coverage.
- For Flutter changes, run `flutter analyze` and `flutter test` in `pulse-flutter/` before pushing.
- Prefer focused tests for services, controllers, security, and validation over broad unrelated refactors.
- Keep generated or assistant-created content understandable for the team and written in German when it is project documentation.
- Use branches and pull requests into `main`. There is no `develop` branch.
