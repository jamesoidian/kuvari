---
description: Updates localizations after adding new strings to code.
---

Simplifies the process of updating translation files and generating code.

1. Ensure all new user-facing strings in `.dart` files use `AppLocalizations`.
2. Update the `.arb` files in `lib/l10n/` with the new strings.
// turbo
3. Run the Flutter localization generator:
```bash
flutter gen-l10n
```
4. Verify that the generated localization classes are updated.
