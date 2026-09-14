---
phase: 02-home-guidance-collection-queue
plan: 01
subsystem: ui
tags: [flutter, empty-state, aac, localization, widget-test]

requires:
  - phase: 01-terminology-search-sharpness
    provides: High-res images and updated terminology in ARB files
provides:
  - Localized empty queue guidance copy across FI, SV, and EN
  - Localized parametric story playback label with count across FI, SV, and EN
  - Dedicated EmptyQueuePlaceholder widget matching carousel dimensions (~88-90px)
  - Isolated widget test suite validating rendering, semantics, and tap callbacks
affects: [02-02-PLAN, home_page]

actuals:
  tokens: 1200
  tasks: 3
  commits: 1

tech-stack:
  added: []
  patterns:
    - Zero-layout-shift placeholder matching active carousel height (~88-90px)
    - Assistive Semantics button wrapper on empty state placeholder
    - Parametric ARB string for count formatting

key-files:
  created:
    - lib/widgets/empty_queue_placeholder.dart
    - test/widgets/empty_queue_placeholder_test.dart
  modified:
    - lib/l10n/intl_fi.arb
    - lib/l10n/intl_sv.arb
    - lib/l10n/intl_en.arb
    - lib/l10n/app_localizations*.dart

key-decisions:
  - "D-01, D-02: EmptyQueuePlaceholder uses 90px height, rounded border with Colors.teal.shade200, subtle teal background tint, and Icons.collections_bookmark_outlined."
  - "D-11: EmptyQueuePlaceholder is implemented as an independent modular widget with its own unit/widget test suite."
  - "D-12: Canonical AAC guidance copy used across Finnish, Swedish, and English."
  - "D-13: Parametric count label viewImageStoryWithCount(count) generated in AppLocalizations."
  - "D-14: Wrapped container in Semantics with isButton: true, guidance label, and search hint."

patterns-established:
  - "Empty queue container matches active carousel height to avoid layout shift when populating or clearing queue"

requirements-completed:
  - JONO-01

coverage:
  - id: D1
    description: "Localized empty queue guidance string across FI, SV, and EN"
    requirement: JONO-01
    verification:
      - kind: unit
        ref: "test/widgets/empty_queue_placeholder_test.dart#renders collection icon and localized Finnish text for fi locale"
        status: pass
  - id: D2
    description: "EmptyQueuePlaceholder widget with collection icon, teal styling, and tap handling"
    requirement: JONO-01
    verification:
      - kind: widget
        ref: "test/widgets/empty_queue_placeholder_test.dart#invokes onTap callback when tapped"
        status: pass
---

# Plan 02-01: Empty Queue Placeholder & Localization Summary

Delivered localized guidance copy across Finnish, Swedish, and English for the collection queue empty state and parametric story playback button, alongside a dedicated `EmptyQueuePlaceholder` widget and isolated widget test suite.

## Accomplishments
1. **Localization Keys (`D-12`, `D-13`)**:
   - Added `emptyQueueGuidance` to `intl_fi.arb`, `intl_sv.arb`, and `intl_en.arb`.
   - Added `viewImageStoryWithCount(count)` with integer placeholder to all three ARB files.
   - Regenerated `AppLocalizations` via `flutter gen-l10n`.
2. **Modular Empty Queue Widget (`D-01`, `D-02`, `D-11`, `D-14`)**:
   - Implemented `EmptyQueuePlaceholder` in `lib/widgets/empty_queue_placeholder.dart`.
   - Constrained total outer height to 90.0px, matching `SelectedImagesCarousel`.
   - Styled with `Colors.teal.shade200` border, subtle teal tint, `Icons.collections_bookmark_outlined`, and high-contrast typography.
   - Integrated `InkWell` tap callback and accessibility `Semantics`.
3. **Automated Verification**:
   - Created `test/widgets/empty_queue_placeholder_test.dart` with 5 tests verifying rendering in FI, SV, and EN, tap callback invocation, and accessibility semantics.
   - All 49 project tests passing with 0 analyzer issues.
