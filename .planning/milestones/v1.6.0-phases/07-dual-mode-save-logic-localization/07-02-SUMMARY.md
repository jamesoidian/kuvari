---
phase: 7
plan: 2
subsystem: ui
tags: [edit-mode, hive, save, home-page, integration]
dependency_graph:
  requires: [07-01]
  provides: [dual-mode-save-flow, hive-story-update]
  affects: [HomePage]
tech_stack:
  added: []
  patterns: [hive-key-update, clean-state-reset, dependency-injection-box]
key_files:
  created: []
  modified:
    - lib/pages/home_page.dart
    - test/pages/home_page_test.dart
decisions:
  - "HomePage._saveImageStory invokes EditModeSaveDialog when _editingStory is active."
  - "Updating existing stories overwrites the Hive record while preserving id, name, and tagIds."
  - "Saving as a new story generates a fresh UUID and adds a new record to Hive."
  - "Upon successful save, edit mode is cleanly exited, clearing _editingStory, empty queue, and resetting start index."
metrics:
  duration: 5m
  completed_date: "2026-09-14"
status: complete
actuals:
  tokens: 4300
  tasks: 2
  commits: 1
---

# Phase 7 Plan 2: HomePage Dual-Mode Save Wiring, Hive Integration & Reset Summary

Wired `EditModeSaveDialog` into `HomePage._saveImageStory`, implemented safe Hive overwrite and new story creation with tag preservation, logged analytics, showed feedback SnackBars, and cleanly reset queue state (`SAVE-01`, `SAVE-02`).

## Completed Tasks

| Task | Name | Commit | Files |
|------|------|--------|-------|
| 1 | Wire EditModeSaveDialog and Hive operations in HomePage | `2edf732` | `lib/pages/home_page.dart` |
| 2 | Add integration tests for dual-mode saving in HomePage | `2edf732` | `test/pages/home_page_test.dart` |

## Verification & Key Findings

- In `HomePage`:
  - Added optional `imageStoriesBox` parameter for dependency injection in tests.
  - When in edit mode (`_editingStory != null`):
    - Tapping save in `EditModeBanner` or `HomeAppBar` opens `EditModeSaveDialog`.
    - Selecting "Päivitä" updates the existing Hive record using its key, keeping existing `id`, `name`, and `tagIds`.
    - Selecting "Tallenna uutena..." creates a new Hive record with a new UUID and name.
    - Shows feedback SnackBar (`storyUpdated` or `imageStorySaved`) after clearing previous SnackBars.
    - Resets `_editingStory = null; _selectedImages.clear(); _currentStartIndex = 0;`.
  - When not in edit mode (`_editingStory == null`):
    - Standard single-dialog saving continues to operate cleanly.
- Integration tests in `home_page_test.dart` verified all save paths, cancellation, and state resets.
- All 94 tests in the test suite pass.

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] SnackBar queueing and test button ambiguity**
- **Found during:** Task 2 integration test run
- **Issue 1:** `ScaffoldMessenger.showSnackBar` queued behind edit mode start SnackBar unless `clearSnackBars()` was called first.
- **Issue 2:** Multiple widgets matched `find.text('Tallenna')` (banner button and dialog button).
- **Fix:** Added `ScaffoldMessenger.of(context).clearSnackBars()` before showing save confirmation SnackBars; scoped test finder to `find.descendant(of: find.byType(EditModeSaveDialog), matching: find.text('Tallenna'))`.
- **Files modified:** `lib/pages/home_page.dart`, `test/pages/home_page_test.dart`
- **Commit:** `2edf732`

## Self-Check: PASSED
- `lib/pages/home_page.dart` verified
- `test/pages/home_page_test.dart` verified
- Commit `2edf732` verified
