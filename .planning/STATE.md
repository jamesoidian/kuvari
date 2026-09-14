---
gsd_state_version: "1.0"
milestone: v1.6.0
milestone_name: Story Editing & Safe Queue Management
status: completed
last_updated: "2026-09-14T10:27:00.000Z"
last_activity: 2026-09-14
progress:
  total_phases: 3
  completed_phases: 3
  total_plans: 5
  completed_plans: 5
  percent: 100
---

# State

> Last Updated: 2026-09-14

## Current Position

Milestone: v1.6.0 — Story Editing & Safe Queue Management (Completed & Archived)  
Status: Ready for `/gsd-new-milestone`  
Last activity: 2026-09-14 — Milestone v1.6.0 archived and tagged.

## Milestone v1.6.0 Summary

- **Phase 5: Safe Browsing & Carousel Protection** (`SAFE-01`, `SAFE-02`):
  - Made saved story carousels read-only and non-reorderable (`isReorderable: false`).
  - Suppressed individual symbol delete buttons on `SavedImageStoriesPage`.
- **Phase 6: Edit on Home Page Transition & Edit Mode UI** (`EDIT-01`, `EDIT-02`, `EDIT-03`, `MODE-01`, `MODE-02`):
  - Added dedicated "Muokkaa kotisivulla" action button with active queue replacement guard.
  - Implemented persistent amber `EditModeBanner` on `HomePage` with title editing, quick save, and exit controls.
  - Added `PopScope` and queue clear data loss prevention guards.
- **Phase 7: Dual-Mode Save Logic & Localization** (`SAVE-01`, `SAVE-02`):
  - Implemented `EditModeSaveDialog` offering "Päivitä olemassa oleva" vs "Tallenna uutena kuvajonona...".
  - Preserved original ID and tags on update; created fresh UUID and name on save as new.
  - Full trilingual localization across Finnish, Swedish, and English.
  - Re-architected action icons into vertically stacked layout on card right edge.

## Accumulated Context

### Key Decisions

- `SelectedImagesCarousel` renders standard `ListView` when `isReorderable: false` to eliminate accidental drag gestures.
- Story editing hand-off uses `Navigator.pop(context, story)` returning to `HomePage` for consistent search and editing tools.
- Dual-mode save offers explicit choice between overwriting Hive record in place or creating an independent copy (`(kopio)`).
- Quick action buttons (edit and play) stacked vertically on the card's right edge save horizontal width for symbol previews.

## Quick Tasks Completed

| Task | Date | Status | Description |
|------|------|--------|-------------|
| `clarify-licensing-and-workplace-use` | 2026-09-14 | Complete ✓ | Clarify free assistive tool status and workplace/care usage in InfoPage and docs |
| [260914-bya](./milestones/v1.6.0-quick/260914-bya-update-saved-stories-tag-terminology/) | 2026-09-14 | Complete ✓ | Update saved stories tag terminology ("Avainsana" -> "Tägi"), hints, and guidance |
| [260914-update-saved-stories-tag-hint](./milestones/v1.6.0-quick/260914-update-saved-stories-tag-hint/) | 2026-09-14 | Complete ✓ | Update tag hint copy on saved stories page ("...kuvajonoa pitkään") |
| [260914-stack-saved-stories-action-icons](./milestones/v1.6.0-quick/260914-stack-saved-stories-action-icons/) | 2026-09-14 | Complete ✓ | Stack edit and play icons vertically on saved stories cards |

## Next Steps

1. Start next milestone: `/gsd-new-milestone`
