# ROADMAP.md

> **Current Phase**: 1
> **Milestone**: v1.2.2 - Tag Editing & Removal

- [x] Tag assignment via long-press
- [x] Filtering/Browsing by tag
- [x] Persistence in Hive
- [ ] Ability to delete tags from the system
- [ ] Ability to edit tag names
- [ ] Scrollable tag selection/filter UI

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
**Requirements**: REQ-07
- [x] Verify persistence, deletion safety, and UI responsiveness.

## Milestone v1.2.2: Tag Editing & Removal

### Phase 1: Tag Deletion & Editing Logic
**Status**: ⬜ Not Started
**Objective**: Implement the business logic for renaming and removing tags from Hive.
- Ensure stories are updated (or tags removed from their lists) when a tag is deleted.

### Phase 2: Tag Management UI Refinement
**Status**: ⬜ Not Started
**Objective**: Add Edit and Delete actions to the Tag Management Dialog.
- Implement confirmation dialogs for deletion.

### Phase 3: Scrollable Tag List UI
**Status**: ⬜ Not Started
**Objective**: Refine the tag list in `SavedImageStoriesPage` to be scrollable and user-friendly.
