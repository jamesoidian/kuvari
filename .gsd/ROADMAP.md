# ROADMAP.md

> **Current Phase**: 4
> **Milestone**: v1.0 - Organization & Categorization

## Must-Haves (from SPEC)
- [x] Hierarchical tag support 
- [x] Tag assignment via long-press
- [x] Filtering/Browsing by tag
- [x] Persistence in Hive

## Phases

### Phase 1: Data Model & Persistence
**Status**: ✅ Completed
**Objective**: Update models to support tags and hierarchy.
**Requirements**: REQ-01, REQ-02, REQ-06
- [x] Define `Tag` model.
- [x] Update `ImageStory` model to include `tagIds`.
- [x] Register new Hive adapters and migration logic if needed.

### Phase 2: Tag Management UI
**Status**: ✅ Completed
**Objective**: Implement the UI for creating and assigning tags.
**Requirements**: REQ-03, REQ-04
- [x] Long-press interaction on `SavedImageStoriesPage`.
- [x] Tag creation/selection modal with search.

### Phase 3: Organization & Filtering UI
**Status**: ✅ Completed
**Objective**: Allow users to browse and filter stories by tags.
**Requirements**: REQ-05
- [x] Update saved stories view to show categories/folders.
- [x] Implement filtering logic.

### Phase 4: Polish & Validation
**Status**: ⬜ Not Started
**Objective**: Final testing and UX refinements.
**Requirements**: REQ-07
- Verify persistence, deletion safety, and UI responsiveness.
