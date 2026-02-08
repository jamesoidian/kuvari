---
description: How to deploy Firebase Cloud Functions
---

# Deployment Workflow

1. Navigate to the functions directory:
   ```bash
   cd functions
   ```

2. Check for vulnerabilities:
// turbo
   ```bash
   npm audit
   ```

3. If vulnerabilities are found in transitive dependencies, apply `overrides` in `package.json` as seen in previous fixes.

4. Run tests or local serve for verification:
   ```bash
   npm run serve
   ```

5. Deploy to Firebase:
   ```bash
   firebase deploy --only functions
   ```

6. Verify the deployment in the Firebase Console.
