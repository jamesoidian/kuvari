# Quick Task Summary: Stack Edit and Play Icons Vertically on Saved Stories Cards

## Overview
Changed the action buttons layout on `SavedImageStoriesPage` story cards from horizontal adjacent positioning to vertically stacked icons (`Column`) on the right edge. This frees up ~48px of horizontal width for `SelectedImagesCarousel`, allowing more preview images to fit comfortably on screen.

## Changes Made
- **`lib/pages/saved_image_stories_page.dart`**:
  - Replaced the `ListTile` inside `Card` with a flexible `Padding` + `Row` layout:
    - Left/Center (`Expanded`): Column containing the story title text and `SelectedImagesCarousel`.
    - Right edge (`Column`): Vertically stacked `edit` (`IconButton(Icons.edit_outlined)`) above `play` (`IconButton(Stack(...))`) with compact visual density and zero padding.
  - This layout avoids `ListTile`'s hardcoded 56px trailing constraint (preventing `RenderFlex` overflows while keeping buttons comfortably spaced and tappable).
  - Removed unused field `_maxVisibleImages`.
- **`test/pages/saved_image_stories_page_test.dart`**:
  - Added test case verifying edit and play buttons are vertically stacked (`editCenter.dy < playCenter.dy`), horizontally aligned in the right action column, and positioned to the right of the carousel.
  - Cleaned up unused imports and obsolete methods.

## Verification
- Ran `flutter test test/pages/saved_image_stories_page_test.dart` — 6/6 tests passed.
- Ran full test suite `flutter test` — all 94 tests passed.
- Triggered `hot_reload` via DTD on active Android emulator.
