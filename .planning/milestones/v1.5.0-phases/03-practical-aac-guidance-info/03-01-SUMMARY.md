---
phase: 03-practical-aac-guidance-info
plan: 01
subsystem: ui
tags: [flutter, aac, info-page, material3, localization, widget-test]

requires:
  - phase: 02-home-guidance-collection-queue
    provides: Working home guidance and collection queue
provides:
  - Scrollable ListView layout on InfoPage preventing RenderFlex overflow
  - 3 themed Material 3 Cards for Quick Start, Practical Use Cases, and Attributions
  - Actionable AAC guidance for Choice-Making, Daily Routines, and Speech Modeling
  - Preserved and verified external links with dependency-injected urlLauncher for test isolation
  - Full localization in Finnish, Swedish, and English
affects: [info_page, l10n]

actuals:
  tokens: 1800
  tasks: 3
  commits: 1

tech-stack:
  added: []
  patterns:
    - Material 3 Card grouping with teal circle icon headers
    - Step and scenario row layouts for clear instructional AAC hierarchy
    - Optional callback injection (urlLauncher) for platform-safe widget testing

key-files:
  created:
    - test/pages/info_page_test.dart
  modified:
    - lib/l10n/intl_fi.arb
    - lib/l10n/intl_sv.arb
    - lib/l10n/intl_en.arb
    - lib/l10n/app_localizations*.dart
    - lib/pages/info_page.dart

key-decisions:
  - "D-01, GUIDE-02: Refactored InfoPage into a scrollable ListView containing three distinct Material 3 Cards: Quick Start, Practical Use Cases, and About & Attributions."
  - "D-02, GUIDE-01: Documented 3 core AAC scenarios with concrete step-by-step guidance: Making Choices, Daily Routines & Sequences, and Pointing & Speech Modeling."
  - "D-03: Used Material 3 Cards with rounded corners, subtle teal borders, teal accent icons (bolt_outlined, forum_outlined, info_outline), and clear typography."
  - "D-04: Provided complete, plain-language localization in Finnish, Swedish, and English via ARB files."
  - "D-05: Preserved and verified external link launching for Papunet, OpenSymbols, Rinnekodit, and Creative Commons via url_launcher."

patterns-established:
  - "Informational pages use structured Material 3 Cards within ListView to ensure smooth scrolling and accessibility"
  - "Link tiles use InkWell with link icon, underlined label, and open_in_new trailing indicator"

requirements-completed:
  - GUIDE-01
  - GUIDE-02

coverage:
  - id: D1_GUIDE02
    description: "InfoPage organized into 3 distinct Material 3 Card sections"
    requirement: GUIDE-02
    verification:
      - kind: widget
        ref: "test/pages/info_page_test.dart#Renders scrollable ListView with exactly three Material 3 Cards (D-01, D-03)"
        status: pass
  - id: D2_GUIDE01
    description: "Practical AAC use cases for choice-making, daily routines, and speech modeling"
    requirement: GUIDE-01
    verification:
      - kind: widget
        ref: "test/pages/info_page_test.dart#Displays all 3 core practical AAC use cases (GUIDE-01)"
        status: pass
  - id: D4_D5
    description: "Multi-locale rendering (fi, sv, en) and external URL link launching"
    requirement: GUIDE-02
    verification:
      - kind: widget
        ref: "test/pages/info_page_test.dart#Displays Attributions and launches external URLs correctly on tap (D-05)"
        status: pass
      - kind: widget
        ref: "test/pages/info_page_test.dart#Renders all sections in Swedish and English without missing keys (D-04)"
        status: pass
---

# Plan 03-01: Practical AAC Guidance & Info Page Refactor Summary

Refactored `InfoPage` from a static unscrollable screen into an accessible, structured, and practical AAC communication guide (`GUIDE-01`, `GUIDE-02`) organized into three Material 3 Cards, backed by comprehensive widget tests and full localization in Finnish, Swedish, and English.

## Accomplishments
1. **Localization Keys (`D-04`)**:
   - Added 15 new localization keys with descriptions across `intl_fi.arb`, `intl_sv.arb`, and `intl_en.arb`.
   - Regenerated `AppLocalizations` via `flutter gen-l10n`.
2. **Material 3 Multi-Card Layout (`D-01`, `D-03`, `GUIDE-02`)**:
   - Replaced static unscrollable `Column` with `ListView` in `SafeArea`, eliminating layout overflow risks on small screens and large text scales.
   - Organized content into three themed `Card` widgets with teal icon badges (`bolt_outlined`, `forum_outlined`, `info_outline`).
3. **Actionable AAC Guidance Content (`D-02`, `GUIDE-01`)**:
   - **Quick Start:** 3-step onboarding (1. Search symbols, 2. Add to queue, 3. View or listen).
   - **Practical Situations:** Concrete advice for:
     1. *Making Choices:* Queuing 2–3 symbols, providing response time, confirming choice.
     2. *Daily Routines & Sequences:* Structuring chronological transitions and daily activities.
     3. *Pointing & Speech Modeling:* Pairing spoken synthesis with visual symbol pointing.
4. **Attributions & Safe URL Launching (`D-05`)**:
   - Preserved origin story (Rinnekodit voluntary work) and licensing explanations (CC BY-NC-SA 4.0, OpenSymbols).
   - Structured interactive link tiles for Papunet, OpenSymbols, Rinnekodit, and Creative Commons.
   - Added optional `urlLauncher` parameter to `InfoPage` for robust, isolated testing.
5. **Automated Verification**:
   - Implemented `test/pages/info_page_test.dart` covering card rendering, quick start, practical use cases, link interaction dispatches, and multi-locale rendering (`fi`, `sv`, `en`).
   - All 56 project tests pass with 0 analyzer issues.
