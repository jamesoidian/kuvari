---
description: Runs all unit and integration tests across Flutter and Firebase.
---

Ensures the code is stable and passes all tests before deployment or commit.

// turbo
1. Run Flutter unit tests:
```bash
flutter test
```
2. Check for Firebase Functions tests and run them if present:
```bash
cd functions && npm test
```
3. If any tests fail, analyze the failures and suggest fixes.
4. Report the overall test status to the user.
