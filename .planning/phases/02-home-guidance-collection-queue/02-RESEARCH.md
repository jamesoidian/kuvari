# Phase 2: Home Guidance & Collection Queue - Research

**Researched:** 2026-09-13
**Domain:** Flutter UI, AAC Onboarding, Collection Queue, Animations, Localization
**Confidence:** HIGH

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- **D-01:** Bordered placeholder card (~80–84px high) with subtle teal background tint and icon, precisely matching the carousel footprint to ensure zero layout shift.
- **D-02:** Use `Icons.collections_bookmark_outlined` in theme teal with gentle background tint to visually convey a symbol sequence.
- **D-03:** Tapping anywhere on the placeholder card automatically requests focus on the search input field (`_searchFocusNode`), guiding users directly to symbol selection.
- **D-04:** Pinned at the top of the body above the search results, mirroring the position of `SelectedImagesCarousel`.
- **D-05:** Use `FloatingActionButton.extended` in the bottom corner with `Icons.play_arrow` and clear descriptive label.
- **D-06:** Teal background (`Colors.teal` / theme primary) with white icon and bold high-contrast text.
- **D-07:** FAB label dynamically reflects queued image count: "Näytä kuvajono (3)" / "Visa bildsekvens (3)" / "View story (3)".
- **D-08:** FAB is conditionally visible only when `_selectedImages.isNotEmpty`. Hidden when queue is empty.
- **D-09:** Use `AnimatedCrossFade` to transition seamlessly between `EmptyQueuePlaceholder` and `SelectedImagesCarousel`.
- **D-10:** Self-contained layout with no redundant section headers above the queue to preserve vertical space for search results.
- **D-11:** Encapsulate placeholder into dedicated widget `lib/widgets/empty_queue_placeholder.dart` accompanied by isolated widget tests.
- **D-12:** Canonical copy across 3 languages:
  - **fi**: *"Valitsemasi kuvat tulevat tähän jonoon. Voit koota viestin, päiväjärjestyksen tai valintataulun."*
  - **sv**: *"Dina valda bilder hamnar i denna sekvens. Du kan skapa ett meddelande, en dagsordning eller en valbricka."*
  - **en**: *"Your selected images appear in this queue. You can compose a message, daily schedule, or choice board."*
- **D-13:** Localized parametric FAB labels: `viewImageStoryWithCount(count)`:
  - **fi**: "Näytä kuvajono ({count})"
  - **sv**: "Visa bildsekvens ({count})"
  - **en**: "View story ({count})"
- **D-14:** Wrap placeholder in explicit `Semantics` (marked as a button with clear label/hint) to assist screen readers.

### The Agent's Discretion
- Exact border stroke and corner radius details inside `EmptyQueuePlaceholder`.
- `AnimatedCrossFade` duration (standard 250ms) and curve (`Curves.easeInOut`).

### Deferred Ideas (OUT OF SCOPE)
None — discussion stayed strictly within Phase 2 AAC scope.
</user_constraints>

<architectural_responsibility_map>
## Architectural Responsibility Map
Single-tier Flutter client application — all capabilities reside in Flutter Client UI & Presentation layer.
</architectural_responsibility_map>

<research_summary>
## Summary

Phase 2 introduces two key AAC interactions on `HomePage`: an instructive empty state placeholder for the collection queue (**JONO-01**) and an extended FAB with dynamic image count for launching story playback (**JONO-02**). Currently, `SelectedImagesCarousel` is rendered conditionally (`if (_selectedImages.isNotEmpty)`), which causes the search bar and image grid to jump vertically by ~90px when the first symbol is picked or cleared.

To solve this, a dedicated `EmptyQueuePlaceholder` widget matching the carousel's exact height (~88–90px) will be created. `HomePage` will manage an `AnimatedCrossFade` between the placeholder and the carousel, maintaining zero layout shift. Additionally, tapping the placeholder will focus the search field by piping a `FocusNode` from `HomePage` through `HomeSearchSection` to `KuvariSearchBar`.

The existing FAB on `HomePage` will be upgraded from a standard circular FAB to `FloatingActionButton.extended` with a play icon and localized parametric label `"Näytä kuvajono ({count})"`. All new text strings will be defined in ARB files for Finnish, Swedish, and English.

**Primary recommendation:** Implement in two clean, focused waves: first the ARB keys and `EmptyQueuePlaceholder` widget with isolated tests; second the `HomePage` integration (focus node, `AnimatedCrossFade`, extended FAB) and end-to-end widget tests.
</research_summary>

<standard_stack>
## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| flutter | SDK | UI framework | Core application framework |
| flutter_localizations | SDK | Localization | Official Flutter localization support |
| intl | ^0.20.2 | Text formatting / pluralization | Standard Dart i18n package |

### Supporting
| Component | Purpose | When to Use |
|-----------|---------|-------------|
| `AnimatedCrossFade` | Smooth transition between two widgets of identical height | Swapping empty queue placeholder and active carousel |
| `FloatingActionButton.extended` | Material 3 extended FAB with icon and label | Playback action trigger with count |
| `Semantics` | Screen reader accessibility annotations | Announcing empty queue state and CTA |
</standard_stack>

<architecture_patterns>
## Architecture Patterns

### Component Interaction Flow

```
+-------------------------------------------------------------+
| HomePage                                                    |
|                                                             |
|  +-------------------------------------------------------+  |
|  | AnimatedCrossFade                                     |  |
|  |  firstChild: EmptyQueuePlaceholder                    |  |
|  |    (tap calls _searchFocusNode.requestFocus())        |  |
|  |  secondChild: SelectedImagesCarousel                  |  |
|  +-------------------------------------------------------+  |
|                                                             |
|  +-------------------------------------------------------+  |
|  | HomeSearchSection                                     |  |
|  |  KuvariSearchBar(focusNode: _searchFocusNode)         |  |
|  +-------------------------------------------------------+  |
|                                                             |
|  +-------------------------------------------------------+  |
|  | ImageGrid (search results)                            |  |
|  +-------------------------------------------------------+  |
|                                                             |
|  floatingActionButton: FloatingActionButton.extended        |
|    (visible only when _selectedImages.isNotEmpty)           |
|    label: "Näytä kuvajono (N)"                              |
+-------------------------------------------------------------+
```

### File Responsibilities
- `lib/widgets/empty_queue_placeholder.dart`: Dedicated stateless or stateful widget displaying border, teal background tint, `Icons.collections_bookmark_outlined`, localized instructional text, and tap gesture detector with accessibility `Semantics`.
- `lib/widgets/kuvari_search_bar.dart` & `lib/widgets/home_search_section.dart`: Accept optional `FocusNode? focusNode` parameter so `HomePage` can request focus externally.
- `lib/pages/home_page.dart`: Manages `_searchFocusNode`, passes it to search bar, embeds `AnimatedCrossFade` for queue area, and renders `FloatingActionButton.extended`.
- `lib/l10n/intl_{fi,sv,en}.arb`: Defines `emptyQueueGuidance` and `viewImageStoryWithCount(count)`.
- `test/widgets/empty_queue_placeholder_test.dart`: Isolated widget test verifying styling, text, semantics, and tap callback.
- `test/pages/home_page_test.dart`: Verifies crossfade transitions, focus request on tap, FAB appearance, count updates, and navigation.
</architecture_patterns>

<validation_architecture>
## Validation Architecture

### Test Infrastructure
- **Framework**: `flutter_test` (built into Flutter SDK)
- **Config file**: `pubspec.yaml`
- **Quick run command**: `flutter test test/widgets/empty_queue_placeholder_test.dart`
- **Full suite command**: `flutter test`
- **Estimated runtime**: ~15 seconds

### Automated Verification Map
| Capability | Test File | Key Test Cases |
|------------|-----------|----------------|
| `EmptyQueuePlaceholder` | `test/widgets/empty_queue_placeholder_test.dart` | Renders icon + text; fires `onTap`; semantics correct; all 3 locales work |
| Search Focus Integration | `test/pages/home_page_test.dart` | Tapping empty placeholder requests focus on search bar input |
| Queue CrossFade | `test/pages/home_page_test.dart` | Displays placeholder when empty; transitions to carousel on symbol selection; transitions back on clear |
| Extended FAB | `test/pages/home_page_test.dart` | Hidden when empty; visible when items present; shows `"Näytä kuvajono (1)"`; navigates to viewer |

### Manual-Only Verifications
All phase behaviors have automated widget verification.
</validation_architecture>

<metadata>
**Research scope:**
- Core technology: Flutter widgets (`AnimatedCrossFade`, `FloatingActionButton.extended`, `FocusNode`)
- Ecosystem: Flutter i18n (`intl`, ARB)
- Patterns: Focus piping, zero-layout-shift placeholders, Material 3 extended FABs

**Confidence breakdown:**
- Standard stack: HIGH - Core Flutter SDK widgets
- Architecture: HIGH - Verified against existing `HomePage` and `SelectedImagesCarousel` code
- Pitfalls: HIGH - Height mismatch avoided by explicit 88–90px constraint
- Code examples: HIGH - Concrete implementations prepared

**Research date:** 2026-09-13
**Valid until:** 2026-10-13
</metadata>

---

*Phase: 02-home-guidance-collection-queue*
*Research completed: 2026-09-13*
*Ready for planning: yes*
