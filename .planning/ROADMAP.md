# ROADMAP.md — Milestone v1.6.0: Story Editing & Safe Queue Management

> **Current Milestone**: v1.6.0 — Story Editing & Safe Queue Management  
> **Goal**: Enable opening and editing saved image stories on HomePage with full tools, safe transition guards, dual-mode save logic, and protected browsing in saved stories.

## Milestones

<details>
<summary>✅ v1.5.0 UX & AAC Communication Enhancements (Phases 1-4) — SHIPPED 2026-09-14</summary>

- [x] Phase 1: Terminology & Search Sharpness (1/1 plans) — completed 2026-09-13
- [x] Phase 2: Home Guidance & Collection Queue (2/2 plans) — completed 2026-09-13
- [x] Phase 3: Practical AAC Guidance & Info (2/2 plans) — completed 2026-09-13
- [x] Phase 4: Native Text-to-Speech (iOS & Android) (2/2 plans) — completed 2026-09-13

</details>

- 🚧 **v1.6.0 Story Editing & Safe Queue Management** — Phases 5-7 (in planning)

---

## Phases

| # | Phase | Status | Goal | Requirements | Success Criteria |
|---|-------|--------|------|--------------|------------------|
| 5 | **Safe Browsing & Carousel Protection** | [x] Complete (1/1 plans) | Ensure saved stories carousel is purely scrollable without accidental drag-to-reorder or deletions. | SAFE-01, SAFE-02 | 2 criteria |
| 6 | **Edit on Home Page Transition & Edit Mode UI** | [x] Complete (2/2 plans) | Enable opening saved stories for editing on HomePage with replacement warning and visual Edit Mode banner. | EDIT-01, EDIT-02, EDIT-03, MODE-01, MODE-02 | 4 criteria |
| 7 | **Dual-Mode Save Logic & Localization** | [ ] Ready (2 plans) | Implement save dialog ("Päivitä olemassa oleva" vs "Tallenna uutena") with full trilingual localization. | SAVE-01, SAVE-02 | 5 criteria |

---

### Phase 5: Safe Browsing & Carousel Protection

**Goal:** Lock down the carousel on `SavedImageStoriesPage` so it acts as a reliable, read-only horizontal reel, eliminating accidental drag gestures and gestures collisions during browsing.

- **Requirements:**
  - `SAFE-01`: Disable drag reordering on `SavedImageStoriesPage` carousel (`isReorderable: false` / pure horizontal scroll) so viewing and swiping stories does not trigger accidental reorders.
  - `SAFE-02`: Ensure individual image delete buttons are absent in the saved stories carousel to prevent accidental deletion during browsing.
- **Success Criteria:**
  1. Saved story carousels cannot be reordered by dragging, allowing smooth horizontal scrolling without gesture conflicts.
  2. Saved story carousels do not display delete buttons on individual symbols.

---

### Phase 6: Edit on Home Page Transition & Edit Mode UI

**Goal:** Provide an intuitive, protected hand-off from `SavedImageStoriesPage` to `HomePage`, establishing a clear Edit Mode with visual status indicator and unsaved change guards.

- **Requirements:**
  - `EDIT-01`: Provide an explicit "Muokkaa kotisivulla" (Edit on Home Page) button on each saved story card in `SavedImageStoriesPage`.
  - `EDIT-02`: Show a confirmation warning dialog when opening a saved story for editing if the home queue already contains selected images.
  - `EDIT-03`: Transition to `HomePage` in Edit Mode, populating the queue with the story's images and displaying a SnackBar confirming the story is open for editing.
  - `MODE-01`: Render a persistent Edit Mode banner above the collection queue on `HomePage` showing the story name and quick actions ("Tallenna muutokset" and "Lopeta muokkaus").
  - `MODE-02`: Guard against accidental data loss in Edit Mode by prompting confirmation when the user taps clear (trash can) or attempts to navigate away with unsaved modifications.
- **Success Criteria:**
  1. Each saved story card displays a "Muokkaa kotisivulla" action button.
  2. If the home queue already contains images when "Muokkaa kotisivulla" is tapped, a confirmation dialog prevents accidental replacement.
  3. `HomePage` displays a persistent Edit Mode banner showing the story title with "Tallenna muutokset" and "Lopeta muokkaus" actions.
  4. Tapping clear or navigating away with unsaved modifications prompts a confirmation dialog.

---

### Phase 7: Dual-Mode Save Logic & Localization

**Goal:** Provide flexible saving that allows either overwriting the existing saved story (retaining tags and ID) or saving as a new story, fully localized in Finnish, Swedish, and English.

- **Requirements:**
  - `SAVE-01`: When saving in Edit Mode, present a dialog offering:
    1. "Päivitä olemassa oleva" (updates existing story in Hive, preserving ID and tags).
    2. "Tallenna uutena kuvajonona..." (prompts for a name, saves a new story with new ID).
  - `SAVE-02`: Cleanly exit Edit Mode upon saving or explicit cancellation, returning `HomePage` to its standard clean queue state.
- **Success Criteria:**
  1. Saving in Edit Mode prompts a dialog with two clear options: "Päivitä olemassa oleva" and "Tallenna uutena kuvajonona".
  2. Updating overwrites the story's images in Hive without altering its original ID or associated tags.
  3. Saving as new prompts for a new name, creates a new `ImageStory` entry, and leaves the original story untouched.
  4. Completing save or cancelling cleans up Edit Mode and resets the home queue state.
  5. All labels, buttons, dialogs, and tooltips are localized across Finnish, Swedish, and English.
