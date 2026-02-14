# ROADMAP.md

> **Current Phase**: Not started
> **Milestone**: v1.0 - Organization & Categorization

## Must-Haves (from SPEC)
- [ ] Hierarchical tag support (2 levels)
- [ ] Tag assignment via long-press
- [ ] Filtering/Browsing by tag
- [ ] Persistence in Hive

## Phases

### Phase 1: Data Model & Persistence
**Status**: ⬜ Not Started
**Objective**: Update models to support tags and hierarchy.
**Requirements**: REQ-01, REQ-02, REQ-06
- Define `Tag` model.
- Update `ImageStory` model to include `tagIds`.
- Register new Hive adapters and migration logic if needed.

### Phase 2: Tag Management UI
**Status**: ⬜ Not Started
**Objective**: Implement the UI for creating and assigning tags.
**Requirements**: REQ-03, REQ-04
- Long-press interaction on `SavedImageStoriesPage`.
- Tag creation/selection modal with search.

### Phase 3: Organization & Filtering UI
**Status**: ⬜ Not Started
**Objective**: Allow users to browse and filter stories by tags.
**Requirements**: REQ-05
- Update saved stories view to show categories/folders.
- Implement filtering logic.

### Phase 4: Polish & Validation
**Status**: ⬜ Not Started
**Objective**: Final testing and UX refinements.
**Requirements**: REQ-07
- Verify persistence, deletion safety, and UI responsiveness.
