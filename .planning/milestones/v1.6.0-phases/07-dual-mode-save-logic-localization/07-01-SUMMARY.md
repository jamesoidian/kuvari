---
phase: 7
plan: 1
subsystem: ui
tags: [edit-mode, save-dialog, localization, widgets]
dependency_graph:
  requires: []
  provides: [edit-mode-save-dialog, dual-mode-save-types]
  affects: [EditModeSaveDialog]
tech_stack:
  added: []
  patterns: [two-step-modal-dialog, sealed-result-types]
key_files:
  created:
    - lib/widgets/edit_mode_save_dialog.dart
    - test/widgets/edit_mode_save_dialog_test.dart
  modified:
    - lib/l10n/intl_fi.arb
    - lib/l10n/intl_sv.arb
    - lib/l10n/intl_en.arb
decisions:
  - "EditModeSaveDialog displays two clear selection cards ('Päivitä: [storyName]' and 'Tallenna uutena...')."
  - "Selecting 'Tallenna uutena...' seamlessly transitions within the dialog to a name TextField pre-filled with '{storyName} (kopio)'."
  - "Sealed class EditModeSaveResult cleanly models UpdateExistingStoryResult and SaveAsNewStoryResult(name)."
metrics:
  duration: 5m
  completed_date: "2026-09-14"
status: complete
actuals:
  tokens: 4200
  tasks: 3
  commits: 1
---

# Phase 7 Plan 1: EditModeSaveDialog & Trilingual Localization Summary

Built `EditModeSaveDialog` widget providing dual selection cards ("Päivitä olemassa oleva" vs "Tallenna uutena...") and name prompt step with full trilingual localization (FI, SV, EN) and isolated widget tests (`SAVE-01`).

## Completed Tasks

| Task | Name | Commit | Files |
|------|------|--------|-------|
| 1 | Add dual-mode save localization strings across FI, SV, and EN | `adfb27c` | `lib/l10n/*` |
| 2 | Implement EditModeSaveDialog widget and result types | `adfb27c` | `lib/widgets/edit_mode_save_dialog.dart` |
| 3 | Create widget tests for EditModeSaveDialog | `adfb27c` | `test/widgets/edit_mode_save_dialog_test.dart` |

## Verification & Key Findings

- Trilingual translations added in `intl_fi.arb`, `intl_sv.arb`, and `intl_en.arb` for option titles, descriptions, copy suffix, and SnackBar messages.
- `EditModeSaveDialog` renders two selection cards with teal icons and descriptive subtitles.
- Tapping "Päivitä" returns `UpdateExistingStoryResult`.
- Tapping "Tallenna uutena..." transitions smoothly to the name input step prefilled with `(kopio)` and autofocus, allowing back navigation or saving with `SaveAsNewStoryResult(name)`.
- 8/8 widget tests in `edit_mode_save_dialog_test.dart` pass.
- 90/90 tests in total pass without regressions.

## Deviations from Plan

None.

## Self-Check: PASSED
- `lib/widgets/edit_mode_save_dialog.dart` verified
- `test/widgets/edit_mode_save_dialog_test.dart` verified
- Commit `adfb27c` verified
