---
quick_id: 260914-bya
status: complete
commit: d1c5577
date: 2026-09-14
---

# Quick Task Summary: Update Saved Stories Tag Terminology

## Overview
Updated saved stories tag terminology from "Avainsana" to "Tägi" (and equivalents across SV and EN), updated search input hint and long-press guidance text, and added a third guidance line stating that image sequences can have multiple tags.

## Changes Completed
1. **Localization files (`lib/l10n/intl_fi.arb`, `lib/l10n/intl_sv.arb`, `lib/l10n/intl_en.arb`):**
   - Updated search stories hint (`searchStories`):
     - FI: "Hae kuvajonoja tägin nimellä..."
     - SV: "Sök bildsekvenser med taggnamn..."
     - EN: "Search image sequences by tag name..."
   - Updated long-press hint (`tagInfoLabel`):
     - FI: "Lisää tägejä painamalla kuvajonon nimeä pitkään"
     - SV: "Lägg till taggar genom att trycka länge på bildsekvensens namn"
     - EN: "Add tags by long-pressing the image sequence name"
   - Added new guidance label (`multipleTagsInfoLabel`):
     - FI: "Kuvajonolla voi olla monta tägiä"
     - SV: "En bildsekvens kan ha flera taggar"
     - EN: "An image sequence can have multiple tags"
   - Replaced all occurrences of "Avainsana" / "Avainsanat" with "Tägi" / "Tägit" in dialog titles, buttons, placeholders, and tooltips.
   - Updated `tagInUseWarning` across languages to reference "kuvajonossa" / "bildsekvenser" / "image sequences".
   - Updated `infoQuickStartStep5Desc` across languages for consistent terminology.
2. **UI Updates (`lib/pages/saved_image_stories_page.dart`):**
   - Added `Text(l10n.multipleTagsInfoLabel, style: TextStyle(fontSize: 14, color: Colors.grey[600]))` below `l10n.tagInfoLabel`.
3. **Tests (`test/pages/saved_image_stories_page_test.dart`, `test/widgets/tag_management_dialog_test.dart`):**
   - Added widget test verifying the updated guidance lines and search field hint on `SavedImageStoriesPage`.
   - Added widget test verifying Finnish "Tägi" terminology in `TagManagementDialog`.
   - All 67 tests passing.
