# Agentic Trunk-Based Issue Workflow

This repository uses a lightweight trunk-based workflow with strict CI gates. The goal is to let multiple developers and AI agents move quickly without damaging architecture or code quality.

## Branch Strategy

- `main`: stable branch, always releasable.
- `develop`: integration branch for sprint work.
- Feature branches: one branch per GitHub issue.

Branch naming:

```text
feature/issue-XYZ-short-description
```

Examples:

```text
feature/issue-013-create-post
feature/issue-021-create-comment
feature/issue-004-login
```

## Issue Ownership

Every issue must have:

- a clear title
- acceptance criteria
- a responsible developer
- a sprint or milestone
- a priority

Before implementation starts, the developer or AI agent must read the issue and identify the affected packages.

## Commit Rules

Use small commits with direct messages.

When a commit completes an issue, include:

```text
closes #XYZ
```

Example:

```text
implement post creation closes #13
```

If a commit only partially contributes to an issue, do not use `closes`.

## Pull Request Rules

Every feature branch must open a pull request into `develop`.

PR requirements:

- link the issue in the PR body
- describe what changed
- describe how it was tested
- include screenshots or API examples when useful
- pass GitHub Actions CI
- be reviewed by at least one teammate

Do not merge when:

- tests fail
- Jacoco coverage is below 80%
- ArchUnit architecture rules fail
- the PR bypasses Controller -> Service -> Repository layering
- secrets or local credentials are included

## AI Agent Rules

AI agents must:

- inspect the existing package structure before editing
- keep changes scoped to the issue
- use Java records for DTOs
- use constructor injection
- avoid field-level `@Autowired`
- avoid direct Controller -> Repository access
- add or update tests for changed behavior
- run relevant Maven checks before reporting completion

AI agents must not:

- weaken CI gates
- delete tests to make a build pass
- introduce deprecated APIs
- commit `.env`, `application-secrets.properties`, API keys, or generated local files

## Verification Commands

Run from the repository root:

```bash
cd pulse-backend
mvn clean compile
mvn clean test
```

The `mvn clean test` command runs:

- unit and web tests
- ArchUnit architecture checks
- Jacoco coverage report
- Jacoco 80% line coverage gate

## Definition of Done

An issue is done when:

- implementation is complete
- acceptance criteria are met
- tests cover the happy path and at least one failure path
- CI passes
- PR is reviewed
- PR is merged into `develop`
- issue is closed through `closes #XYZ`
