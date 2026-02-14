# SPEC.md — Project Specification

> **Status**: `FINALIZED`

## Vision
Enhance Kuvari's image story management by introducing a flexible organization system using hierarchical tags (or folders) to allow users to categorize their communication boards for easier retrieval.

## Goals
1. **Hierarchical Organization**: (Deprecated) Switched to flat tags for simplicity.
2. **Flexible Tagging**: Allow stories to be associated with one or more tags.
3. **Intuitive Management**: Provide a long-press interaction on stories to manage their tags.
4. **Local Persistence**: Ensure all organization data is stored locally using Hive.
5. **Tag Lifecycle Management**: Allow users to edit tag names and delete tags from the system.
6. **Optimized Tag UI**: Ensure the tag selection and filter list is scrollable and accessible.

## Non-Goals (Out of Scope)
- **Cloud Sync**: Firebase synchronization is not required for this phase.
- **Visual Icons for Tags**: Tags will be name-only for simplicity.
- **Infinite Nesting**: The structure is limited to a max of two levels for now.

## Users
- **Primary Users**: Individuals using Kuvari for communication who need to organize a growing collection of saved stories (e.g., "Home", "School", "Food", "Emergency").
- **Caregivers/Educators**: Who set up and organize the boards for the primary user.

## Constraints
- **Framework**: Flutter.
- **Database**: Hive (already in use for `ImageStory`).

## Success Criteria
- [ ] Users can create new tags/folders.
- [ ] Users can assign tags to an `ImageStory` via a long-press menu.
- [ ] Users can browse stories filtered by tag/folder.
- [ ] Data persists across application restarts.
