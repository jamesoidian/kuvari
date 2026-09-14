# Phase 6: Edit on Home Page Transition & Edit Mode UI — Context

**Phase:** 06-edit-on-home-page-transition-edit-mode-ui  
**Milestone:** v1.6.0  
**Status:** Ready to plan  

## User Decisions & Locked Requirements

- **D-01: Edit Button on Saved Story Card (`EDIT-01`)**:
  - In `SavedImageStoriesPage`, each story card's `ListTile.trailing` renders a `Row(mainAxisSize: MainAxisSize.min, ...)` containing:
    1. An edit icon button (`Icons.edit_outlined`), styled clearly with a tooltip and semantic label ("Muokkaa kotisivulla" / localized).
    2. The existing teal play button.
  - Tapping the edit button initiates the transition back to `HomePage` for editing.

- **D-02: Queue Replacement Warning Dialog (`EDIT-02`)**:
  - `SavedImageStoriesPage` receives current queue status (`hasActiveQueue: bool` and `activeQueueCount: int`) passed from `HomePage` via `HomeAppBar`.
  - When edit is tapped, if `hasActiveQueue` is `true`, a confirmation dialog appears:
    - Title: "Korvataanko nykyinen kuvajono?" (Replace current queue?)
    - Body: localized warning indicating that the home queue already contains X items.
    - Actions: "Peruuta" (Cancel) and "Korvaa ja muokkaa" (Replace and edit).
  - If user cancels, stay on `SavedImageStoriesPage`.
  - If confirmed (or if `hasActiveQueue` is `false`), pop `SavedImageStoriesPage` and return the `ImageStory` object to `HomePage`.

- **D-03: Transition to HomePage in Edit Mode (`EDIT-03`)**:
  - `HomePage` receives the returned `ImageStory` from the navigation push.
  - `HomePage` sets `_editingStory = story`, replaces `_selectedImages` with a copy of `story.images`, and presents a confirmation `SnackBar` indicating the story is open for editing.

- **D-04: Persistent Edit Mode Banner (`MODE-01`)**:
  - Render an `EditModeBanner` widget above the collection queue on `HomePage`.
  - Layout: Compact Material 3 banner with subtle warm accent tint (e.g. amber-50 container with amber border and icon), showing:
    - Pencil icon (`Icons.edit`).
    - Localized label and story title in bold ("Muokataan: **[Story Name]**").
    - Action buttons: "Tallenna" (triggering save) and "Lopeta" (close button or exit action).

- **D-05: Unsaved Modifications Guard (`MODE-02`)**:
  - Guard the clear queue action: When tapping the trash can in `SelectedImagesCarousel` while in Edit Mode, show a confirmation dialog before clearing the queue.
  - Guard the exit action: When tapping "Lopeta" on the banner or triggering `PopScope` back navigation, check if `_selectedImages` differs from `_editingStory.images`.
    - If modified: prompt confirmation dialog ("Hylätäänkö muutokset?").
    - If unmodified: exit Edit Mode immediately without confirmation.

- **D-06: Trilingual Localization**:
  - Provide complete translations for Finnish, Swedish, and English in `intl_fi.arb`, `intl_sv.arb`, and `intl_en.arb`.
