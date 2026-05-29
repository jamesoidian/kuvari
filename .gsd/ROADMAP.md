# ROADMAP.md

> **Current Milestone**: Text-to-Speech
> **Goal**: Adding text-to-speech (TTS) to Kuvari so that users can tap an icon to hear the image's word

## Must-Haves
- [x] Add TTS Package
- [x] Ensure Configuration
- [x] Create TTS Service
- [ ] Update UI

## Phases

### Phase 1: Setup & Configuration
**Status**: ✅ Complete
**Objective**: Add the `flutter_tts` package and update platform configurations.

### Phase 2: Service Layer
**Status**: ✅ Complete
**Objective**: Create a `TtsService` to initialize TTS and handle language selection.

### Phase 3: UI Integration
**Status**: ⬜ Not Started
**Objective**: Add a speaker icon button to image cards and connect it to the TTS service.

### Phase 4: Testing & Polish
**Status**: ⬜ Not Started
**Objective**: Verify TTS playback across supported languages and handle edge cases.

---

## Past Milestone: v1.3.0 - Stabilized
**Status**: ✅ Completed

- [x] Tag assignment via long-press
- [x] Filtering/Browsing by tag
- [x] Persistence in Hive
- [x] Ability to delete tags from the system
- [x] Ability to edit tag names
- [x] Scrollable tag selection/filter UI

### Phase 1: Data Model & Persistence
**Status**: ✅ Completed
**Objective**: Update models to support tags and hierarchy.

### Phase 2: Tag Management UI
**Status**: ✅ Completed
**Objective**: Implement the UI for creating and assigning tags.

### Phase 3: Organization & Filtering UI
**Status**: ✅ Completed
**Objective**: Allow users to browse and filter stories by tags.

### Phase 4: Polish & Validation
**Status**: ✅ Completed
**Objective**: Final testing and UX refinements.
