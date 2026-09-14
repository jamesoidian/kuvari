---
phase: 01-terminology-search-sharpness
plan: 01
subsystem: ui
tags: [l10n, aac, symbols, retina, terminology, flutter]

requires: []
provides:
  - AAC nomenclature alignment: "Category" renamed to "Image Type" / "Kuvatyyppi" / "Bildtyp"
  - Sharp symbol rendering in ImageGrid using full-resolution image URL
affects: [02-guidance-discovery, 03-choice-mode, 04-practical-aac-info]

actuals:
  tokens: 1500
  tasks: 3
  commits: 3

tech-stack:
  added: []
  patterns:
    - High-resolution SVG and PNG rendering directly from symbol sources in grid views
    - Standardized AAC terminology across Finnish, Swedish, and English localizations

key-files:
  created: []
  modified:
    - lib/l10n/intl_fi.arb
    - lib/l10n/intl_sv.arb
    - lib/l10n/intl_en.arb
    - lib/l10n/app_localizations.dart
    - lib/l10n/app_localizations_fi.dart
    - lib/l10n/app_localizations_sv.dart
    - lib/l10n/app_localizations_en.dart
    - lib/widgets/image_grid.dart
    - test/widgets/category_selection_dialog_test.dart
    - test/widgets/image_grid_test.dart

key-decisions:
  - "Renamed 'Category' to 'Image Type' (Kuvatyypit / Bildtyper) to prevent confusion with semantic AAC topic categories"
  - "Rendered full-resolution img.url in ImageGrid instead of low-resolution thumbnail to eliminate blurriness on Retina screens"

patterns-established:
  - "Use img.url for symbol rendering on modern displays to preserve vector clarity"

requirements-completed:
  - TERM-01
  - IMG-01

status: complete
---

# Phase 01 Plan 01: Terminology & Search Sharpness Summary

**One-liner:** Aligned symbol set filtering terminology with AAC standards ("Image Type" / "Kuvatyyppi" / "Bildtyp") and replaced low-resolution grid thumbnails with full-resolution symbol URLs for crisp Retina rendering.

## Overview

In AAC communication systems and Papunet's symbol services, "kategoria" (category) denotes semantic topic domains such as food, clothing, feelings, or activities. Kuvari's filter dialog actually selects symbol sets and drawing styles (such as Arasaac, Sclera, photos, or line drawings). Retaining "kategoria" caused confusion among AAC professionals. This plan aligned terminology across all three supported languages (Finnish, Swedish, and English) and updated ImageGrid to display full-resolution symbol assets (`img.url`) rather than small thumbnails (`img.thumb`), resolving blurriness on modern high-DPI displays.

## Tasks Completed

| Task | Name | Commit | Key Files Modified |
|------|------|--------|---------------------|
| 1 | Update ARB localization files and regenerate localizations | `753e60e` | `lib/l10n/intl_fi.arb`, `lib/l10n/intl_sv.arb`, `lib/l10n/intl_en.arb`, generated localization files |
| 2 | Render full-resolution symbols in ImageGrid | `42cc8a1` | `lib/widgets/image_grid.dart` |
| 3 | Update widget tests and verify complete test suite | `d99eaa1` | `test/widgets/category_selection_dialog_test.dart`, `test/widgets/image_grid_test.dart` |

## Verification Results

- `flutter gen-l10n`: Successfully generated `app_localizations.dart` and locale subclasses without errors.
- Static analysis of `lib/widgets/image_grid.dart`: 0 issues found.
- `flutter test`: 44/44 tests passed with 0 failures.
  - Dialog title verified in `category_selection_dialog_test.dart`: confirms "Valitse kuvatyypit" is displayed.
  - Full-resolution rendering verified in `image_grid_test.dart`: confirms `KuvariImageDisplay.url` receives `img.url`.

## Deviations from Plan

None - plan executed exactly as written.

## Known Stubs

None.

## Threat Surface Scan

No new network endpoints, authorization paths, or storage schemas were added.

## Self-Check: PASSED

- [x] `lib/l10n/intl_fi.arb` updated and exists
- [x] `lib/l10n/intl_sv.arb` updated and exists
- [x] `lib/l10n/intl_en.arb` updated and exists
- [x] `lib/widgets/image_grid.dart` updated and exists
- [x] `test/widgets/category_selection_dialog_test.dart` updated and exists
- [x] `test/widgets/image_grid_test.dart` updated and exists
- [x] Task 1 commit `753e60e` exists in git log
- [x] Task 2 commit `42cc8a1` exists in git log
- [x] Task 3 commit `d99eaa1` exists in git log
