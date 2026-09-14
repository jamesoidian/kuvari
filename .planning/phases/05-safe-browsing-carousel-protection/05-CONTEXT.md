# Phase 5: Safe Browsing & Carousel Protection — Context

**Phase:** 05-safe-browsing-carousel-protection  
**Milestone:** v1.6.0  
**Status:** Ready to plan  

## User Decisions & Locked Requirements

- **D-01: Read-Only Carousel Mode**: `SelectedImagesCarousel` must support a non-reorderable mode (e.g. `isReorderable: false`, default `true`). When `isReorderable` is `false`, render a standard horizontal `ListView` instead of `ReorderableListView`, removing the long-press drag gesture entirely.
- **D-02: Protect Saved Stories Page**: In `lib/pages/saved_image_stories_page.dart`, pass `isReorderable: false` to `SelectedImagesCarousel` so users cannot pick up or drag symbols. This prevents accidental rearrangement when scrolling or viewing saved stories.
- **D-03: No Deletion on Saved Stories Reel**: Ensure `showClearButton: false` remains enforced, and individual symbol deletion buttons are absent from saved stories carousels.
- **D-04: Smooth Touch & Gesture Interaction**: Eliminating `ReorderableListView` in the saved stories reel avoids gesture ambiguity between horizontal scrolling, card dismissal, and card long-press (tagging).
- **D-05: Non-regression**: All existing `SavedImageStoriesPage` behaviors (filtering chips, search bar, play button, card dismiss-to-delete, long-press to open tag dialog) must remain functional and tested.
