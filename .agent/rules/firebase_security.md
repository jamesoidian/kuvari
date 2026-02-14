# Firebase Security Best Practices

Guidelines for maintaining security in Firebase Cloud Functions and Firestore.

## Activation
- Activates when working in the `functions/` directory or with Firebase-related code.

## Guidelines

- **Sensitive Logic**: All business logic involving external API keys or sensitive data must be handled in Cloud Functions.
- **OpenSymbols API**: The OpenSymbols token must be managed exclusively within Firebase Cloud Functions (env variables).
- **Validation**: Cloud Functions must validate all incoming data before performing updates or deletions in Firestore.
- **Admin SDK**: Use the Admin SDK with caution; always ensure it's used within a secure, server-side context.
