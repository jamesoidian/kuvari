---
quick_task: 260914-stack-saved-stories-action-icons
title: Stack edit and play icons vertically on saved stories cards
files_modified:
  - lib/pages/saved_image_stories_page.dart
  - test/pages/saved_image_stories_page_test.dart
---

# Quick Task: Stack Edit and Play Icons Vertically on Saved Stories Cards

<objective>
Change the trailing action layout in `SavedImageStoriesPage` story cards from a horizontal `Row` to a vertical `Column` so the edit and play icons are stacked vertically on the right edge, maximizing horizontal space for the image carousel.
</objective>

<tasks>

<task type="auto">
  <name>Task 1: Change trailing Row to Column in SavedImageStoriesPage</name>
  <files>
    lib/pages/saved_image_stories_page.dart
  </files>
  <action>
    In `lib/pages/saved_image_stories_page.dart`:
    Replace the `trailing: Row(mainAxisSize: MainAxisSize.min, ...)` with:
    ```dart
    trailing: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: const Icon(Icons.edit_outlined),
          tooltip: l10n.editOnHomePage,
          onPressed: () => _handleEditStory(story),
        ),
        const SizedBox(height: 6),
        IconButton(
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: Stack(...),
          onPressed: () { ... },
          tooltip: l10n.viewImageStory,
        ),
      ],
    )
    ```
  </action>
  <verify>
    flutter test test/pages/saved_image_stories_page_test.dart
  </verify>
  <done>
    Icons are stacked vertically and tests pass.
  </done>
</task>

<task type="auto">
  <name>Task 2: Verify all widget tests across the project</name>
  <files>
    test/pages/saved_image_stories_page_test.dart
  </files>
  <action>
    Run full test suite to ensure no regressions.
  </action>
  <verify>
    flutter test
  </verify>
  <done>
    All 94+ tests pass.
  </done>
</task>

</tasks>
