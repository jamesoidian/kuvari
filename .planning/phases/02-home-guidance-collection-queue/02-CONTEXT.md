# Phase 2: Home Guidance & Collection Queue - Context

**Gathered:** 2026-09-13
**Status:** Ready for planning

<domain>
## Phase Boundary

Phase 2 focuses on home screen guidance and the collection queue (`JONO-01`, `JONO-02`):
- `JONO-01`: Guide user with an empty collection queue placeholder card on the home screen.
- `JONO-02`: Provide an intuitive, obvious action button to view the collected story.

Success Criteria:
1. Empty state tells user: "Valitsemasi kuvat tulevat tähän jonoon. Voit koota viestin, päiväjärjestyksen tai valintataulun."
2. Action button to view/play the story is clearly visible and accessible when images are added.
</domain>

<decisions>
## Implementation Decisions

### Empty Queue Container Design
- **D-01:** Bordered placeholder card — A dashed/rounded card (~80-84px high) with subtle teal background tint and icon, matching the carousel dimensions so there is zero layout jump or content reflow.
- **D-02:** Symbol collection icon — Use `Icons.collections_bookmark_outlined` in theme teal with gentle background tint to visually convey a collection of symbols.
- **D-03:** Interactive search focus — Tapping anywhere on the placeholder card automatically requests focus on the search input field (`_searchController` / search focus node), guiding users directly to finding symbols.
- **D-04:** Pinned position — The placeholder card remains pinned at the top above the search results, just like the active carousel, reinforcing the mental model of the collection area.

### Story Playback / View Action Trigger
- **D-05:** Extended FloatingActionButton — Use `FloatingActionButton.extended` in the bottom corner with a play icon (`Icons.play_arrow`) and clear text label indicating the action.
- **D-06:** Theme styling — Teal background (`Colors.teal` / theme primary) with white icon and bold high-contrast text.
- **D-07:** Dynamic count label — Label reflects the queued image count: "Näytä kuvajono (3)" / "Visa bildsekvens (3)" / "View story (3)".
- **D-08:** Conditional visibility — FAB is completely hidden when the queue is empty (`_selectedImages.isEmpty`), appearing smoothly once at least one image is queued.

### Queue Controls & Header Integration
- **D-09:** Smooth crossfade — Use `AnimatedCrossFade` to transition seamlessly between `EmptyQueuePlaceholder` and `SelectedImagesCarousel`.
- **D-10:** Clean self-contained layout — No redundant section header label above the queue; vertical space is preserved for search results.
- **D-11:** Dedicated modular widget — Create `lib/widgets/empty_queue_placeholder.dart` with dedicated unit/widget tests.

### Localization & AAC Instructional Copy
- **D-12:** Canonical instructional copy across 3 languages:
  - Finnish (`fi`): "Valitsemasi kuvat tulevat tähän jonoon. Voit koota viestin, päiväjärjestyksen tai valintataulun."
  - Swedish (`sv`): "Dina valda bilder hamnar i denna sekvens. Du kan skapa ett meddelande, en dagsordning eller en valbricka."
  - English (`en`): "Your selected images appear in this queue. You can compose a message, daily schedule, or choice board."
- **D-13:** Localized parametric FAB labels:
  - Finnish (`fi`): `viewImageStoryWithCount(count)` → "Näytä kuvajono ({count})"
  - Swedish (`sv`): `viewImageStoryWithCount(count)` → "Visa bildsekvens ({count})"
  - English (`en`): `viewImageStoryWithCount(count)` → "View story ({count})"
- **D-14:** Assistive accessibility semantics:
  - Wrap placeholder in explicit `Semantics` with label indicating the queue is empty and tapping will focus search, ensuring screen reader users understand the role and function.

### The Agent's Discretion
- Exact padding, corner radius (e.g. `BorderRadius.circular(12)`), and border dash/stroke implementation details inside `EmptyQueuePlaceholder`.
- `AnimatedCrossFade` duration (standard 250-300ms curve).
</decisions>

<specifics>
## Specific Ideas
- Matching the height of `SelectedImagesCarousel` (~80-84px) prevents the search bar and image grid from shifting up and down when the first image is added or the last image is removed.
- Tapping the empty card acts as a call-to-action that focuses the search bar, streamlining the user workflow.
</specifics>

<canonical_refs>
## Canonical References
**Downstream agents MUST read these before planning or implementing.**
- `.planning/ROADMAP.md` — Phase 2 requirements and success criteria.
- `.planning/REQUIREMENTS.md` — Requirement definitions for `JONO-01` and `JONO-02`.
- `lib/widgets/selected_images_carousel.dart` — Carousel dimensions, styling, and behavior.
- `lib/pages/home_page.dart` — Queue integration, FAB, and search controller interaction.
- `lib/l10n/intl_{fi,sv,en}.arb` — Existing localization keys and conventions.
</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- `SelectedImagesCarousel` (`lib/widgets/selected_images_carousel.dart`): The existing carousel widget rendered when `_selectedImages.isNotEmpty`.
- `HomePage` (`lib/pages/home_page.dart`): Coordinates `_selectedImages`, search, and bottom navigation / floating actions.

### Established Patterns
- ARB localization files in `lib/l10n/` with `flutter gen-l10n` generating `AppLocalizations`.
- Floating action buttons on `HomePage` navigating to `ImageViewerPage` with `_selectedImages`.
- Widget test suites under `test/widgets/` using `WidgetTester`.

### Integration Points
- `HomePage` body: Replace conditional carousel display with `AnimatedCrossFade` between `EmptyQueuePlaceholder` and `SelectedImagesCarousel`.
- `HomePage` floatingActionButton: Update to `FloatingActionButton.extended` with count label when `_selectedImages.isNotEmpty`.
- `EmptyQueuePlaceholder`: New widget in `lib/widgets/empty_queue_placeholder.dart`.
- ARB files: Add keys `emptyQueueGuidance` and `viewImageStoryWithCount` to `intl_fi.arb`, `intl_sv.arb`, and `intl_en.arb`.
</code_context>

<deferred>
## Deferred Ideas
None — discussion stayed strictly within Phase 2 AAC scope.
</deferred>

---

*Phase: 02-home-guidance-collection-queue*
