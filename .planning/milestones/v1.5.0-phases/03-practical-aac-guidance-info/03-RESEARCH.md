# Phase 3: Practical AAC Guidance & Info - Research

**Researched:** 2026-09-13
**Domain:** Flutter UI, AAC Communication Best Practices, Material 3, Localization, Widget Testing
**Confidence:** HIGH

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- **D-01:** `InfoPage` uses a unified scrollable layout (`ListView`) with three distinct Material 3 `Card` sections:
  1. Quick Start (`Pikaopas`)
  2. Practical Use Cases (`Käytännön tilanteet`)
  3. About & Attributions (`Tietoa ja lähteet`)
- **D-02:** Feature three core AAC scenarios with structured, actionable guidance:
  1. *Valinnan tekeminen (Making Choices):* Adding 2–3 symbols to the queue, giving response time, confirming choice.
  2. *Päiväjärjestys ja toimintaketjut (Daily Routines & Sequences):* Consecutive actions in chronological order to create predictability.
  3. *Osoittaminen ja puhesynteesi (Pointing & Speech Modeling):* Speech synthesizer button + pointing to reinforce auditory and visual language.
- **D-03:** Material 3 `Card` widgets with teal accent icons (`Icons.bolt_outlined`, `Icons.forum_outlined`, `Icons.info_outline`), rounded corners (`BorderRadius.circular(12)`), subtle elevation/padding, and clear typographical hierarchy.
- **D-04:** Complete localization in Finnish (`fi`), Swedish (`sv`), and English (`en`) via ARB files with warm, encouraging, plain-language (*selkokieli*) tone.
- **D-05:** Preserve all external links (Papunet kuvapankki, OpenSymbols, Rinnekodit Oy, Creative Commons BY-NC-SA 4.0) within the Attributions section, opened safely via `url_launcher` (`LaunchMode.externalApplication`).

### The Agent's Discretion
- Exact card spacing and padding details.
- Minor icon choices for individual use case items.
- Optional `urlLauncher` parameter injection on `InfoPage` for reliable, isolated widget testing without platform channel mocking.

### Deferred Ideas (OUT OF SCOPE)
None — discussion stayed strictly within Phase 3 scope.
</user_constraints>

<architectural_responsibility_map>
## Architectural Responsibility Map
Single-tier Flutter client application — all capabilities reside in Flutter Client UI & Presentation layer.
</architectural_responsibility_map>

<research_summary>
## Summary

Phase 3 transitions `InfoPage` (`lib/pages/info_page.dart`) from a static, unscrollable text screen into a structured, accessible, and practical AAC communication guide (`GUIDE-01`, `GUIDE-02`).
The new design organizes content into three distinct Material 3 `Card` sections:
1. **Pikaopas / Quick Start:** Immediate 3-step onboarding on finding symbols, queuing them, and viewing/listening.
2. **Käytännön tilanteet / Practical Use Cases:** Actionable scenarios for Choice-Making (2–3 options), Daily Routines & Sequences (chronological steps), and Pointing & Speech Modeling (verbal scaffolding).
3. **Tietoa ja lähteet / Attributions & Licensing:** Transparent origins (Rinnekodit voluntary initiative), image sources (Papunet, OpenSymbols), and CC BY-NC-SA 4.0 licensing links.

To prevent overflow on small screens and large accessibility font scales, `InfoPage` is refactored into a `ListView`. For testability, `InfoPage` accepts an optional `urlLauncher` callback defaulting to `launchUrl(uri, mode: LaunchMode.externalApplication)`.
</research_summary>

<standard_stack>
## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| flutter | SDK | UI framework | Core application framework |
| flutter_localizations | SDK | Localization | Official Flutter localization support |
| intl | ^0.20.2 | Text formatting / pluralization | Standard Dart i18n package |
| url_launcher | ^6.3.1 | Opening external web links | Standard Flutter package for external URL handling |

### Supporting
| Component | Purpose | When to Use |
|-----------|---------|-------------|
| `ListView` | Scrollable vertical layout | Hosting cards and preventing RenderFlex overflow |
| `Card` | Material 3 surface container | Grouping content into distinct thematic sections |
| `InkWell` | Accessible tap target | Tapping external links with visual feedback |
</standard_stack>

<architecture_patterns>
## Architecture Patterns

### Component Layout Flow

```
Scaffold
└── AppBar(title: Text(l10n.infoPageTitle))
    └── SafeArea
        └── ListView(padding: 16)
            ├── Card: Quick Start (Icons.bolt_outlined)
            │   ├── Card Header (Icon badge + Title)
            │   ├── Intro text
            │   └── 3 Step Rows (Numbered circles + title + description)
            ├── SizedBox(height: 16)
            ├── Card: Practical Situations (Icons.forum_outlined)
            │   ├── Card Header (Icon badge + Title)
            │   ├── Intro text
            │   ├── Scenario 1: Making Choices (Icons.check_circle_outline)
            │   ├── Divider
            │   ├── Scenario 2: Daily Routines (Icons.schedule_outlined)
            │   ├── Divider
            │   └── Scenario 3: Pointing & Speech (Icons.record_voice_over_outlined)
            ├── SizedBox(height: 16)
            └── Card: About & Attributions (Icons.info_outline)
                ├── Card Header (Icon badge + Title)
                ├── App Origins narrative (Rinnekodit voluntary project)
                ├── Licensing details (CC BY-NC-SA 4.0 & OpenSymbols)
                └── Link Action List (Icon + Underlined Label + Launch Icon)
```

### File Responsibilities
- `lib/l10n/intl_{fi,sv,en}.arb`: Add new keys for quick start, use cases, and attribution titles.
- `lib/pages/info_page.dart`: Refactor to `ListView` with three Material 3 `Card`s, themed icons, and optional `urlLauncher` parameter.
- `test/pages/info_page_test.dart`: Isolated widget test verifying layout, card presence, localized text across `fi`/`sv`/`en`, and URL link dispatching.
</architecture_patterns>

<validation_architecture>
## Validation Architecture

### Test Infrastructure
- **Framework**: `flutter_test` (built into Flutter SDK)
- **Config file**: `pubspec.yaml`
- **Quick run command**: `flutter test test/pages/info_page_test.dart`
- **Full suite command**: `flutter test`
- **Estimated runtime**: ~15 seconds

### Automated Verification Map
| Capability | Test File | Key Test Cases |
|------------|-----------|----------------|
| Card & Scroll Structure | `test/pages/info_page_test.dart` | Renders `ListView`, three `Card` widgets, and section icons without overflow |
| Quick Start Content | `test/pages/info_page_test.dart` | Displays 3 steps (search, add to queue, view/listen) |
| Practical Use Cases | `test/pages/info_page_test.dart` | Displays choice-making, daily routines, and speech modeling |
| Attributions & Links | `test/pages/info_page_test.dart` | Displays Papunet, OpenSymbols, Rinnekodit, and CC license links; taps invoke `urlLauncher` with correct URIs |
| Multi-Locale Support | `test/pages/info_page_test.dart` | Renders correctly in `fi`, `sv`, and `en` |

### Manual-Only Verifications
All phase behaviors have automated widget verification.
</validation_architecture>

<metadata>
**Research scope:**
- Core technology: Flutter widgets (`ListView`, `Card`, `Theme`)
- Ecosystem: Flutter i18n (`intl`, ARB)
- Patterns: Accessible AAC instruction, Material 3 card grouping, dependency injection for testability

**Confidence breakdown:**
- Standard stack: HIGH - Core Flutter SDK widgets & url_launcher
- Architecture: HIGH - Fully aligned with existing codebase patterns
- Localization: HIGH - Complete ARB key dictionaries specified for fi, sv, en
- Verification: HIGH - Isolated widget tests using callback injection

**Research date:** 2026-09-13
**Valid until:** 2026-10-13
</metadata>

---

*Phase: 03-practical-aac-guidance-info*
*Research completed: 2026-09-13*
*Ready for planning: yes*
