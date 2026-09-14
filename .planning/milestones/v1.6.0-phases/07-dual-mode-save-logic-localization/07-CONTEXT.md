# Phase 7: Dual-Mode Save Logic & Localization — Context

**Phase:** 07-dual-mode-save-logic-localization  
**Milestone:** v1.6.0  
**Status:** Ready to plan  

## User Decisions & Locked Requirements

- **D-01: Dual-Mode Save Dialog Trigger (`SAVE-01`)**:
  - When `_saveImageStory` is invoked on `HomePage` while `_editingStory != null` (either via `EditModeBanner` "Tallenna" or `HomeAppBar` save action), present the dual-mode save dialog instead of the standard single-mode prompt.
  - When `_editingStory == null`, the standard "Tallenna kuvajono" name prompt continues to function unchanged.

- **D-02: Dialog Layout & Selection Cards**:
  - Presented as an `AlertDialog` with title "Tallenna kuvajono" / localized.
  - Contains two distinct selection cards (`Card` / `ListTile` with rounded border and ink ripple):
    1. **"Päivitä: [storyName]"**:
       - Icon: `Icons.update` / `Icons.sync` (teal accent).
       - Title: Localized "Päivitä: {storyName}".
       - Subtitle: Localized "Korvaa tallennettu versio säilyttäen tägit".
       - Action: immediately overwrites the existing story in Hive using its existing key/ID, preserving existing `name` and `tagIds`, with updated `images`.
    2. **"Tallenna uutena..."**:
       - Icon: `Icons.bookmark_add_outlined` (teal accent).
       - Title: Localized "Tallenna uutena...".
       - Subtitle: Localized "Luo uusi kuvajono uudella nimellä".
       - Action: prompts for a new name, pre-filled with `"{storyName} (kopio)"` / localized (`(kopia)` / `(copy)`), creates a fresh `ImageStory` with a new `Uuid().v4()`, and saves it to Hive.
  - Bottom action: TextButton "Peruuta" / localized, which dismisses the dialog without saving and stays in edit mode.

- **D-03: Post-Save Queue Cleanup (`SAVE-02`)**:
  - Following either successful save path ("Päivitä" or "Tallenna uutena"):
    - Log Firebase Analytics event (`update_image_story` with story name and count, or `save_image_story`).
    - Show localized confirmation `SnackBar` (`l10n.imageStorySaved(name)`).
    - Dismiss the dialog.
    - Cleanly reset HomePage state: `_editingStory = null; _selectedImages.clear(); _currentStartIndex = 0;`.
    - Edit mode banner disappears, and queue resets to empty state placeholder.

- **D-04: Trilingual Localization**:
  - Complete translations for Finnish, Swedish, and English in `intl_fi.arb`, `intl_sv.arb`, and `intl_en.arb`:
    - `updateExistingStory`: "Päivitä: {storyName}" / "Uppdatera: {storyName}" / "Update: {storyName}"
    - `updateExistingStoryDescription`: "Korvaa tallennettu versio säilyttäen tägit" / "Ersätter den sparade versionen och behåller taggar" / "Overwrites saved version and preserves tags"
    - `saveAsNewStory`: "Tallenna uutena kuvajonona..." / "Spara som ny bildsekvens..." / "Save as new sequence..."
    - `saveAsNewStoryDescription`: "Luo uusi kuvajono uudella nimellä" / "Skapa en ny bildsekvens med ett nytt namn" / "Create a new sequence with a new name"
    - `storyCopySuffix`: "{storyName} (kopio)" / "{storyName} (kopia)" / "{storyName} (copy)"
    - `storyUpdated`: "Kuvajono \"{name}\" päivitetty." / "Bildsekvens \"{name}\" uppdaterad." / "Image sequence \"{name}\" updated."

- **D-05: Non-Regression & Quality Gates**:
  - Standard queue saving (when `_editingStory == null`) must remain 100% intact.
  - Hive Box transactions must be safe, updating existing keys without duplicate entries.
  - Comprehensive unit and widget tests covering dialog rendering, both save pathways, and queue reset.
