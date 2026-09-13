# Phase 3: Practical AAC Guidance & Info - Context

**Gathered:** 2026-09-13
**Status:** Ready for planning

<domain>
## Phase Boundary

Redesign `InfoPage` from a basic text page into a practical, structured, and visually engaging AAC communication guide (`GUIDE-01`, `GUIDE-02`).
The page must provide concrete quick-start guidance, 3 real-world AAC interaction scenarios with step-by-step tips, and preserve all existing attributions and external links (Papunet, OpenSymbols, Rinnekodit, Creative Commons).

</domain>

<decisions>
## Implementation Decisions

### Page Layout & Structure
- **D-01:** `InfoPage` uses a unified scrollable layout (`ListView`) with three distinct Material 3 `Card` sections:
  1. **Pikaopas / Quick Start** (getting started, basic idea of symbol collections)
  2. **Käytännön tilanteet / Practical Use Cases** (concrete communication scenarios)
  3. **Tietoa ja lähteet / Attributions & Licensing** (origins, licensing, external links)
  — **Reversibility:** reversible

### Practical Use Cases Content
- **D-02:** Feature three core AAC scenarios with structured, actionable guidance:
  1. **Valinnan tekeminen (Making Choices):** Adding 2–3 symbols to the collection queue to present options (e.g. food, activities, clothing), giving the communicator time to point or select, and confirming.
  2. **Päiväjärjestys ja toimintaketjut (Daily Routines & Sequences):** Arranging consecutive actions (e.g. morning routine, therapy transitions) in chronological order to create predictability and structure.
  3. **Osoittaminen ja puhesynteesi (Pointing & Speech Modeling):** Using the speech synthesizer button to model spoken words alongside visual symbols, supporting receptive and expressive language.
  — **Reversibility:** reversible

### Visual Styling & Iconography
- **D-03:** Use Material 3 `Card` widgets with teal accent icons (`Icons.bolt_outlined`, `Icons.forum_outlined`, `Icons.info_outline`), rounded corners (`BorderRadius.circular(12)`), subtle elevation/padding, and clear typographical hierarchy (bold headers, bullet points, contrast text).
  — **Reversibility:** reversible

### Localization & Tone of Voice
- **D-04:** Complete localization in Finnish (`fi`), Swedish (`sv`), and English (`en`) via ARB files. The tone is encouraging, plain-language (selkokielinen), and accessible to individuals who use AAC, family members, and care professionals alike.
  — **Reversibility:** reversible

### Attribution & External Links
- **D-05:** Preserve all external links (Papunet kuvapankki, OpenSymbols, Rinnekodit Oy, Creative Commons BY-NC-SA 4.0) within the Attributions section, opened safely via `url_launcher` (`LaunchMode.externalApplication`).
  — **Reversibility:** reversible

### the agent's Discretion
- Exact card spacing and padding details.
- Minor icon choices for individual use case items.
- Structure of unit/widget test assertions for scrolling and card presence.

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Requirements & Roadmap
- `.planning/ROADMAP.md` §Phase 3 — Phase definition, requirements (`GUIDE-01`, `GUIDE-02`), success criteria
- `.planning/REQUIREMENTS.md` §v1.5.0 Requirements — Requirements traceability and scope boundaries

### Existing Implementation
- `lib/pages/info_page.dart` — Existing InfoPage widget and URL launch helpers
- `lib/l10n/intl_fi.arb` — Finnish localization dictionary
- `lib/l10n/intl_sv.arb` — Swedish localization dictionary
- `lib/l10n/intl_en.arb` — English localization dictionary

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- `url_launcher`: Already integrated and used in `InfoPage` for external URLs.
- `AppLocalizations`: Centralized localization pattern used across all screens.
- `Theme.of(context)` / `Colors.teal`: Primary color system across Kuvari.

### Established Patterns
- ARB strings with descriptive keys and clear comments.
- Scrollable pages wrapped in `SafeArea` and `Scaffold`.

### Integration Points
- `lib/pages/info_page.dart`: Primary file to refactor.
- `lib/l10n/intl_{fi,sv,en}.arb`: Add new keys for section headers, use cases, and tips.
- `test/pages/info_page_test.dart`: Widget test to verify all 3 sections, text contents, and link buttons.

</code_context>

<specifics>
## Specific Ideas

- Ensure text is easy to read with adequate line height and clear separation between steps.
- Make external links clear with link icon and underline styling.
- Keep the page fast and lightweight (no heavy assets or network dependencies).

</specifics>

<deferred>
## Deferred Ideas

- None — discussion stayed strictly within the phase scope.

</deferred>

---

*Phase: 03-practical-aac-guidance-info*
*Context gathered: 2026-09-13*
