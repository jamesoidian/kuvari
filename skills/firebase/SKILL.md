---
name: firebase
description: Conventions for Firebase Cloud Functions and Admin SDK.
---

# Firebase & Cloud Functions Conventions

## Security
- **Version Control**: Never commit sensitive keys or service account files.
- **Dependencies**: Keep dependencies updated. Use `overrides` in `package.json` to fix critical transitive vulnerabilities (e.g., `fast-xml-parser`).
- **Validation**: Validate all incoming data in callable functions.

## Implementation Patterns
- Use `axios` for external HTTP requests.
- Use `firebase-admin` for interacting with Firestore, Storage, and Auth.
- Implement structured logging using `firebase-functions/logger`.

## Maintenance
- Always run `npm audit` before deploying or adding new dependencies.
- Ensure `engines.node` in `package.json` matches the intended runtime.
