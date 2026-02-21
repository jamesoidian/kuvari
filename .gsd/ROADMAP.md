# ROADMAP.md

> **Current Phase**: COMPLETED
> **Milestone**: v1.3.0 - Stabilized

- [x] Tag assignment via long-press
- [x] Filtering/Browsing by tag
- [x] Persistence in Hive
- [x] Ability to delete tags from the system
- [x] Ability to edit tag names
- [x] Scrollable tag selection/filter UI

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
**Status**: ✅ Completed
**Objective**: Final testing and UX refinements.

## Milestone v1.3.0: Stabilization & Infrastructure
- [x] Dependency upgrades to latest major versions
- [x] Storage robustness with `StorageService`
- [x] Model flattening and UI optimization
- [x] Test suite recovery and stabilization
- [x] Managed successful release build

## current_tasks
- [ ] No active tasks. All milestones completed.
