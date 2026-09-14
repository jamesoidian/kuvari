---
quick_task: 260914-update-saved-stories-tag-hint
status: complete
completed_date: "2026-09-14"
files_modified:
  - lib/l10n/intl_fi.arb
  - lib/l10n/intl_sv.arb
  - lib/l10n/intl_en.arb
  - test/pages/saved_image_stories_page_test.dart
---

# Quick Task Summary: Update Tag Hint Copy on Saved Stories Page

Updated the instruction label on `SavedImageStoriesPage` to refer directly to long-pressing the image sequence (rather than its name), across Finnish, Swedish, and English.

## Changes Made
- `intl_fi.arb`: "Lisää tägejä painamalla kuvajonoa pitkään"
- `intl_sv.arb`: "Lägg till taggar genom att trycka länge på bildsekvensen"
- `intl_en.arb`: "Add tags by long-pressing the image sequence"
- `test/pages/saved_image_stories_page_test.dart`: Updated expectation to verify the new text.

## Verification
- `flutter gen-l10n` regenerated localizations cleanly.
- `flutter test test/pages/saved_image_stories_page_test.dart` passed (6/6).
- `flutter test` passed with 94/94 tests green.
