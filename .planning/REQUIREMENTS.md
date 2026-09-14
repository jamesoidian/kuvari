# Requirements: Kuvari

**Defined:** 2026-09-14  
**Milestone:** v1.6.0 — Story Editing & Safe Queue Management  
**Core Value:** Providing a fast, simple, and intuitive visual communication tool that empowers users to express needs, understand daily structures, and make choices through symbols.

## v1.6.0 Requirements

### Safe Story Carousel
- [x] **SAFE-01**: Disable drag reordering on `SavedImageStoriesPage` carousel (`isReorderable: false` / pure horizontal scroll) so viewing and swiping stories does not trigger accidental reorders.
- [x] **SAFE-02**: Ensure individual image delete buttons are absent in the saved stories carousel to prevent accidental deletion during browsing.

### Edit on Home Page Transition
- [ ] **EDIT-01**: Provide an explicit "Muokkaa kotisivulla" (Edit on Home Page) button on each saved story card in `SavedImageStoriesPage`.
- [ ] **EDIT-02**: Show a confirmation warning dialog when opening a saved story for editing if the home queue already contains selected images.
- [ ] **EDIT-03**: Transition to `HomePage` in Edit Mode, populating the queue with the story's images and displaying a SnackBar confirming the story is open for editing.

### Home Page Edit Mode UI & Protection
- [ ] **MODE-01**: Render a persistent Edit Mode banner above the collection queue on `HomePage` showing the story name and quick actions ("Tallenna muutokset" and "Lopeta muokkaus").
- [ ] **MODE-02**: Guard against accidental data loss in Edit Mode by prompting confirmation when the user taps clear (trash can) or attempts to navigate away with unsaved modifications.

### Dual-Mode Save Logic
- [ ] **SAVE-01**: When saving in Edit Mode, present a dialog offering:
  1. "Päivitä olemassa oleva" (updates existing story in Hive, preserving ID and tags).
  2. "Tallenna uutena kuvajonona..." (prompts for a name, saves a new story with new ID).
- [ ] **SAVE-02**: Cleanly exit Edit Mode upon saving or explicit cancellation, returning `HomePage` to its standard clean queue state.

---

## Out of Scope

| Feature | Reason |
|---------|--------|
| In-place story editing directly inside SavedImageStoriesPage | The home page has the full search, image repository, reordering, and symbol collection tools; duplicating search on the saved stories page adds excessive UI complexity. |
| Automatic background overwrite without confirmation | In AAC rutiinit, accidental overwrites destroy established visual schedules; explicit user confirmation is essential. |
| Multi-level undo/redo history stack | Simple discard/save confirmations suffice for atomic queue updates. |

---

## Traceability

| Requirement | Phase | Status |
|-------------|-------|--------|
| SAFE-01 | Phase 5 | Complete |
| SAFE-02 | Phase 5 | Complete |
| EDIT-01 | Phase 6 | Pending |
| EDIT-02 | Phase 6 | Pending |
| EDIT-03 | Phase 6 | Pending |
| MODE-01 | Phase 6 | Pending |
| MODE-02 | Phase 6 | Pending |
| SAVE-01 | Phase 7 | Pending |
| SAVE-02 | Phase 7 | Pending |

**Coverage:**
- Milestone v1.6.0 requirements: 9 total
- Mapped to phases: 9
- Unmapped: 0 ✓
