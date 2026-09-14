# Phase 2: Home Guidance & Collection Queue - Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.
> Decisions are captured in CONTEXT.md — this log preserves the alternatives considered.

**Date:** 2026-09-13
**Phase:** 02-home-guidance-collection-queue
**Areas discussed:** Empty queue container design, Story playback / view action trigger, Queue controls & header integration, Localization & AAC instructional copy

---

## Empty Queue Container Design

| Option | Description | Selected |
|--------|-------------|----------|
| Bordered placeholder card | A dashed/rounded card (~80-90px high) with subtle icon and clear guidance text, preserving carousel space | ✓ |
| Empty slots row | Row of faint dashed empty image frames/boxes showing where symbols will appear, with guidance text | |
| Minimal guidance banner | A slim info strip above the search field without a full placeholder card | |

**User's choice:** Bordered placeholder card (~80-90px high)
**Notes:** Matches carousel height (~80-84px) to avoid content jump.

---

## Icon and Tap Interaction

| Option | Description | Selected |
|--------|-------------|----------|
| Symbol collection icon | Icons.collections_bookmark_outlined or Icons.add_photo_alternate_outlined in teal with gentle background tint | ✓ |
| Instructional tip icon | Icons.lightbulb_outline or Icons.info_outline to emphasize guidance | |
| Text only | Centered, clear typography without an icon | |

| Option | Description | Selected |
|--------|-------------|----------|
| Focus search input | Tapping anywhere on the empty card focuses the search text field to encourage symbol search | ✓ |
| TTS speech prompt | Tapping speaks the guidance text using speech synthesis | |
| Passive display | Non-interactive placeholder | |

| Option | Description | Selected |
|--------|-------------|----------|
| Always pinned at top | Remains visible above the search results grid so the user always sees the queue area and mental model | ✓ |
| Scrollable with results | Scrolls off screen with the search results if the page is scrolled down | |

**User's choice:** Collection icon in teal, focus search input on tap, always pinned at top.

---

## Story Playback / View Action Trigger

| Option | Description | Selected |
|--------|-------------|----------|
| Extended FloatingActionButton only | Expand the existing FAB to show both play icon and text label ('Näytä kuvajono' / 'View story') in the bottom corner | ✓ |
| Both in-queue button & FloatingActionButton | Prominent 'View story' button right above/beside carousel AND bottom FAB | |
| In-queue button only | Place the view/play button exclusively next to the collection carousel, removing FAB | |

| Option | Description | Selected |
|--------|-------------|----------|
| Theme Teal with white icon and bold label | High contrast, clean Material 3 extended FAB in Colors.teal matching app identity | ✓ |
| High-visibility Accent color | Bold vibrant color (e.g. Amber or Emerald Green) | |
| Layered icon with label | Retain the double-border play icon alongside label on teal background | |

| Option | Description | Selected |
|--------|-------------|----------|
| Include image count | Label displays count: 'Näytä kuvajono (3)' / 'View story (3)' to confirm exact number of queued images | ✓ |
| Standard label without count | Fixed label 'Näytä kuvajono' / 'View story' without a number | |

| Option | Description | Selected |
|--------|-------------|----------|
| Hide FAB when queue is empty | FAB only appears once at least one symbol is selected, keeping home screen clean | ✓ |
| Show disabled FAB | Keep disabled, muted FAB visible even when empty | |

**User's choice:** Extended FAB in Theme Teal, includes image count, hidden when queue is empty.

---

## Queue Controls & Header Integration

| Option | Description | Selected |
|--------|-------------|----------|
| Smooth AnimatedCrossFade | Gracefully crossfades between the empty placeholder and active carousel with ease-in animation | ✓ |
| Instant conditional switch | Standard if/else swap without animation | |

| Option | Description | Selected |
|--------|-------------|----------|
| Clean and self-contained | No redundant header text above queue; keep maximum vertical space for search results | ✓ |
| Section header | Add a small label 'Kuvajono' / 'Valitut kuvat' above queue container | |

| Option | Description | Selected |
|--------|-------------|----------|
| Matching height (~80-84px) | Matches carousel height so there is zero layout jump or content reflow | ✓ |
| Slightly taller (~96px) | Gives more room for multi-line instructional text on narrow phones | |

| Option | Description | Selected |
|--------|-------------|----------|
| Dedicated widget (lib/widgets/empty_queue_placeholder.dart) | Modular, clean separation of concerns, independently unit/widget-testable | ✓ |
| Integrated inside SelectedImagesCarousel | SelectedImagesCarousel handles its own empty state internally | |

**User's choice:** AnimatedCrossFade, clean and self-contained, matching height (~80-84px), dedicated widget.

---

## Localization & AAC Instructional Copy

| Option | Description | Selected |
|--------|-------------|----------|
| Canonical AAC guidance copy | "Valitsemasi kuvat tulevat tähän jonoon. Voit koota viestin, päiväjärjestyksen tai valintataulun." (SV: "Dina valda bilder hamnar i denna sekvens. Du kan skapa ett meddelande, en dagsordning eller en valbricka." / EN: "Your selected images appear in this queue. You can compose a message, daily schedule, or choice board.") | ✓ |
| Shorter two-sentence phrasing | "Valitsemasi kuvat tulevat tähän. Voit luoda viestin tai päiväjärjestyksen." | |

| Option | Description | Selected |
|--------|-------------|----------|
| Parametric count label | "Näytä kuvajono ({count})" / "Visa bildsekvens ({count})" / "View story ({count})" using ARB plural/placeholders | ✓ |
| Consistent story terminology | "Näytä kuvatarina ({count})" / "Visa bildberättelse ({count})" / "View image story ({count})" | |

| Option | Description | Selected |
|--------|-------------|----------|
| Explicit accessibility semantics | Provide semantic label and hint ("Kuvajono on tyhjä. Valitsemasi kuvat tulevat tähän.") so screen readers announce it clearly | ✓ |
| Default text semantics | Let Flutter read visible instructional text without extra custom semantics wrapper | |

**User's choice:** Canonical AAC guidance copy, parametric count label, explicit accessibility semantics.

---

## The Agent's Discretion
- Visual subtleties of the empty container border (subtle dashed/border outline, rounded corners).
- Crossfade animation curve and duration (250-300ms).

## Deferred Ideas
None — discussion stayed within Phase 2 scope.

---

*Phase: 02-home-guidance-collection-queue*
*Discussion log generated: 2026-09-13*
