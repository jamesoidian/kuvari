---
phase: 6
plan: 1
subsystem: ui
tags: [edit-mode, transition, saved-stories, dialogs]
dependency_graph:
  requires: []
  provides: [edit-on-home-page-transition]
  affects: [SavedImageStoriesPage, HomeAppBar, HomePage]
tech_stack:
  added: []
  patterns: [navigator-push-pop-return-pattern, replace-warning-dialog]
key_files:
  created: []
  modified:
    - lib/l10n/intl_fi.arb
    - lib/l10n/intl_sv.arb
    - lib/l10n/intl_en.arb
    - lib/pages/saved_image_stories_page.dart
    - lib/widgets/home_app_bar.dart
    - lib/pages/home_page.dart
    - test/pages/saved_image_stories_page_test.dart
    - test/pages/home_page_test.dart
decisions:
  - "Saved story cards display an edit icon button (Icons.edit_outlined) in the trailing area alongside the play button."
  - "Tapping edit when the home queue is non-empty prompts an AlertDialog warning that existing images will be replaced."
  - "When edit is confirmed, SavedImageStoriesPage pops returning the ImageStory, and HomePage populates the queue and displays a SnackBar."
metrics:
  duration: 5m
  completed_date: "2026-09-14"
status: complete
actuals:
  tokens: 4200
  tasks: 2
  commits: 2
---

# Phase 6 Plan 1: Edit on Home Page Transition & Replacement Guard Summary

Implemented the transition from SavedImageStoriesPage to HomePage in Edit Mode (`EDIT-01`, `EDIT-03`) and guarded against accidental home queue replacement with a confirmation dialog (`EDIT-02`).

## Completed Tasks

| Task | Name | Commit | Files |
|------|------|--------|-------|
| 1 | Add localization and edit button with replacement dialog on SavedImageStoriesPage | `e1653d8` | `lib/l10n/*`, `lib/pages/saved_image_stories_page.dart`, `test/pages/saved_image_stories_page_test.dart` |
| 2 | Wire transition in HomeAppBar and HomePage with Edit Mode initialization | `57698d8` | `lib/widgets/home_app_bar.dart`, `lib/pages/home_page.dart`, `test/pages/home_page_test.dart` |

## Verification & Key Findings

- Trilingual localization (FI, SV, EN) added for all story editing, replacement warning, and banner strings.
- `SavedImageStoriesPage` renders an `IconButton(icon: Icon(Icons.edit_outlined))` on each card trailing section.
- If `hasActiveQueue` is true, a confirmation warning dialog prompts the user with the count of active images and the story name. Confirming pops the route with the `ImageStory`.
- `HomePage` receives the returned story through `HomeAppBar.onEditStory`, sets `_editingStory`, fills `_selectedImages`, and displays a confirming `SnackBar`.
- 73/73 tests passing.

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] Added HomeAppBar import in test**
- **Found during:** Task 2 verify
- **Issue:** Missing `HomeAppBar` import in `test/pages/home_page_test.dart`.
- **Fix:** Added `import 'package:kuvari_app/widgets/home_app_bar.dart';`.
- **Files modified:** `test/pages/home_page_test.dart`
- **Commit:** `57698d8`

## Self-Check: PASSED
- `lib/pages/saved_image_stories_page.dart` verified
- `lib/widgets/home_app_bar.dart` verified
- `lib/pages/home_page.dart` verified
- Commits `e1653d8` and `57698d8` verified
