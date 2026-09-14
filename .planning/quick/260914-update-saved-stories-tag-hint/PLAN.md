---
quick_task: 260914-update-saved-stories-tag-hint
title: Update tag hint copy on saved stories page
files_modified:
  - lib/l10n/intl_fi.arb
  - lib/l10n/intl_sv.arb
  - lib/l10n/intl_en.arb
  - test/pages/saved_image_stories_page_test.dart
---

# Quick Task: Update Tag Hint Copy on Saved Stories Page

<objective>
Update the instruction label on `SavedImageStoriesPage` from "Lisää tägejä painamalla kuvajonon nimeä pitkään" to "Lisää tägejä painamalla kuvajonoa pitkään", along with corresponding Swedish and English translations, and update matching test assertions.
</objective>

<tasks>

<task type="auto">
  <name>Task 1: Update tagInfoLabel in arb files and run flutter gen-l10n</name>
  <files>
    lib/l10n/intl_fi.arb
    lib/l10n/intl_sv.arb
    lib/l10n/intl_en.arb
  </files>
  <action>
    Update `tagInfoLabel` in:
    - `intl_fi.arb`: "Lisää tägejä painamalla kuvajonoa pitkään"
    - `intl_sv.arb`: "Lägg till taggar genom att trycka länge på bildsekvensen"
    - `intl_en.arb`: "Add tags by long-pressing the image sequence"
    Run `flutter gen-l10n`.
  </action>
  <verify>
    flutter gen-l10n
  </verify>
  <done>
    Translations regenerated with updated tagInfoLabel copy.
  </done>
</task>

<task type="auto">
  <name>Task 2: Update widget test and verify</name>
  <files>
    test/pages/saved_image_stories_page_test.dart
  </files>
  <action>
    In `test/pages/saved_image_stories_page_test.dart`:
    Update line 157 to expect "Lisää tägejä painamalla kuvajonoa pitkään".
    Run `flutter test test/pages/saved_image_stories_page_test.dart` and `flutter test`.
  </action>
  <verify>
    flutter test test/pages/saved_image_stories_page_test.dart && flutter test
  </verify>
  <done>
    All tests pass cleanly.
  </done>
</task>

</tasks>
