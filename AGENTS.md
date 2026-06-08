# Pulse Agent Instructions

These rules apply to Codex and every other AI coding agent working in this repository.

- Keep the app realistic for the M335 school project: native Android client, Spring Boot backend, Dockerized PostgreSQL/MongoDB, and simple service boundaries.
- Do not commit secrets, `.env`, Firebase files, local IDE settings, build outputs, or handoff documents.
- Keep architecture documentation in sync when backend services, Docker services, ports, or data stores change.
- For backend changes, run the Maven tests in `pulse-backend` before pushing. The CI requires at least 80% line coverage.
- Prefer focused tests for services, controllers, security, and validation over broad unrelated refactors.
- Keep generated or assistant-created content understandable for the team and written in German when it is project documentation.
