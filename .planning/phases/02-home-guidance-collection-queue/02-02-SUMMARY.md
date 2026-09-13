---
phase: 02-home-guidance-collection-queue
plan: 02
subsystem: ui
tags: [flutter, home-page, crossfade, focus-piping, extended-fab, widget-test]

requires:
  - phase: 02-home-guidance-collection-queue
    provides: EmptyQueuePlaceholder and localized guidance/count strings
provides:
  - AnimatedCrossFade on HomePage between EmptyQueuePlaceholder and SelectedImagesCarousel
  - Search focus piping from EmptyQueuePlaceholder tap to search TextField
  - FloatingActionButton.extended with dynamic item count and play icon
  - Complete widget test coverage verifying empty state, focus, transitions, and FAB
affects: [home_page, kuvari_search_bar, home_search_section]

actuals:
  tokens: 1500
  tasks: 4
  commits: 1

tech-stack:
  added: []
  patterns:
    - FocusNode piping via optional constructor injection with internal fallback
    - AnimatedCrossFade with identical height (90px) children for zero layout shift
    - Material 3 FloatingActionButton.extended with dynamic count and visibility guard

key-files:
  created: []
  modified:
    - lib/widgets/kuvari_search_bar.dart
    - lib/widgets/home_search_section.dart
    - lib/pages/home_page.dart
    - test/pages/home_page_test.dart

key-decisions:
  - "D-03: HomePage creates _searchFocusNode and pipes it down through HomeSearchSection to KuvariSearchBar; tapping EmptyQueuePlaceholder requests search focus."
  - "D-04, D-09, D-10: Pinned queue container at top of body using AnimatedCrossFade with duration 250ms and matching 90px heights, without redundant section headers."
  - "D-05, D-06, D-07, D-08: FloatingActionButton.extended in bottom corner appears when queue has items, displays 'Näytä kuvajono (N)', teal background, play icon, and completely disappears when queue is empty."

patterns-established:
  - "Queue container always occupies 90px pinned above search, crossfading seamlessly between placeholder and carousel"
  - "Extended FAB conditionally rendered (null when queue empty) avoiding awkward zero-state buttons"

requirements-completed:
  - JONO-01
  - JONO-02

coverage:
  - id: D3
    description: "Tapping EmptyQueuePlaceholder focuses search TextField"
    requirement: JONO-01
    verification:
      - kind: widget
        ref: "test/pages/home_page_test.dart#Tapping EmptyQueuePlaceholder focuses search TextField (D-03)"
        status: pass
  - id: D4_D9
    description: "Empty queue displays placeholder and crossfades to carousel when populated"
    requirement: JONO-01
    verification:
      - kind: widget
        ref: "test/pages/home_page_test.dart#Empty queue displays placeholder and hides FAB"
        status: pass
  - id: D5_D7_D8
    description: "Extended FAB appears with dynamic count when queue has items, navigates to viewer, and disappears when cleared"
    requirement: JONO-02
    verification:
      - kind: widget
        ref: "test/pages/home_page_test.dart#Selecting image shows carousel, extended FAB with count, and allows navigation"
        status: pass
---

# Plan 02-02: Home Page Queue Integration & Extended FAB Summary

Delivered full integration of `EmptyQueuePlaceholder`, search focus piping, zero-layout-shift `AnimatedCrossFade`, and `FloatingActionButton.extended` on `HomePage`, backed by comprehensive widget tests.

## Accomplishments
1. **FocusNode Piping (`D-03`)**:
   - Added optional `FocusNode? focusNode` to `KuvariSearchBar` with graceful internal fallback and lifecycle management.
   - Forwarded `focusNode` through `HomeSearchSection`.
   - Wired `_searchFocusNode` in `_HomePageState` to request focus whenever `EmptyQueuePlaceholder` is tapped.
2. **Smooth Queue Crossfade (`D-04`, `D-09`, `D-10`)**:
   - Replaced conditional carousel rendering with `AnimatedCrossFade` (250ms, easeInOut).
   - Seamless transition between 90px `EmptyQueuePlaceholder` and 90px `SelectedImagesCarousel` eliminates vertical layout shift.
   - Maintained clean layout without superfluous section headers.
3. **Extended FAB with Dynamic Count (`D-05`, `D-06`, `D-07`, `D-08`)**:
   - Upgraded `floatingActionButton` to `FloatingActionButton.extended` with `Icons.play_arrow`, theme teal background, white bold typography, and localized count label (e.g. "Näytä kuvajono (1)").
   - FAB is completely hidden (`null`) when the queue is empty.
   - Navigates cleanly to `ImageViewerPage` when pressed.
4. **Automated Verification (`JONO-01`, `JONO-02`)**:
   - Expanded `test/pages/home_page_test.dart` to verify empty state, search focus on placeholder tap, crossfade transitions, dynamic FAB label, story navigation, and clearing behavior.
   - All 51 project tests pass with 0 analyzer warnings.
