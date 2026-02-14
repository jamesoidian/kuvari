---
phase: 4
plan: 1
wave: 1
---

# Plan 4.1: Final Polish & Validation

## Objective
Ensure the Organization & Categorization feature is robust, well-tested, and free of technical debt before final delivery.

## Context
- .gsd/SPEC.md
- .gsd/ROADMAP.md
- lib/pages/saved_image_stories_page.dart
- test/widgets/tag_management_dialog_test.dart

## Tasks

<task type="auto">
  <name>Cleanup Remaining Lint Warnings</name>
  <files>
    - test/pages/home_page_test.dart
    - test/services/kuvari_service_test.dart
  </files>
  <action>
    - Remove unused imports found in the previous `flutter analyze` run.
    - Fix the `depend_on_referenced_packages` warning if applicable.
  </action>
  <verify>flutter analyze</verify>
  <done>Analysis passes with zero issues.</done>
</task>

<task type="auto">
  <name>Verify Tag-to-Story Persistence Logic</name>
  <files>
    - test/pages/saved_image_stories_page_test.dart
  </files>
  <action>
    - Add a widget test to `saved_image_stories_page_test.dart` that verifies long-pressing a story opens the dialog, and applying tags correctly updates the Hive box and UI.
  </action>
  <verify>flutter test test/pages/saved_image_stories_page_test.dart</verify>
  <done>Integration test for tag assignment passes.</done>
</task>

## Success Criteria
- [ ] No lint warnings or errors in the project.
- [ ] Automated tests cover the full loop of tag assignment and persistence.
- [ ] All features from SPEC.md are verified as working across Finnish, Swedish, and English.
