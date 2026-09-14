# Quick Task: Update Saved Stories Tag Terminology

**Quick ID:** `260914-bya`
**Date:** 2026-09-14
**Description:** Update saved stories tag terminology from "Avainsana" to "Tägi", update search hint and long-press guidance, and add multiple tags info line.

## Tasks

### Task 1: Update ARB files and generate localizations
- **Files:** `lib/l10n/intl_fi.arb`, `lib/l10n/intl_sv.arb`, `lib/l10n/intl_en.arb`
- **Action:**
  - Replace "Avainsana"/"Avainsanat" with "Tägi"/"Tägit" across all Finnish strings.
  - Update `searchStories`:
    - FI: "Hae kuvajonoja tägin nimellä..."
    - SV: "Sök bildsekvenser med taggnamn..."
    - EN: "Search image sequences by tag name..."
  - Update `tagInfoLabel`:
    - FI: "Lisää tägejä painamalla kuvajonon nimeä pitkään"
    - SV: "Lägg till taggar genom att trycka länge på bildsekvensens namn"
    - EN: "Add tags by long-pressing the image sequence name"
  - Add `multipleTagsInfoLabel`:
    - FI: "Kuvajonolla voi olla monta tägiä"
    - SV: "En bildsekvens kan ha flera taggar"
    - EN: "An image sequence can have multiple tags"
  - Update `tagInUseWarning` to use "kuvajonossa" / "bildsekvenser" / "image sequences".
  - Run `flutter gen-l10n`.
- **Verify:** `flutter gen-l10n` succeeds and generates updated `AppLocalizations`.

### Task 2: Update UI and tests
- **Files:** `lib/pages/saved_image_stories_page.dart`, `test/pages/saved_image_stories_page_test.dart`, `test/widgets/tag_management_dialog_test.dart`
- **Action:**
  - Add `Text(l10n.multipleTagsInfoLabel, style: TextStyle(fontSize: 14, color: Colors.grey[600]))` to the instruction column in `SavedImageStoriesPage`.
  - Update any comments in `saved_image_stories_page.dart`.
  - Add widget test coverage for the new instruction labels and verify all existing tests pass.
- **Verify:** `flutter test` passes all tests cleanly.
