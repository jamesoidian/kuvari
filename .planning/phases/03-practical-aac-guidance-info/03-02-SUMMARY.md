---
phase: 03-practical-aac-guidance-info
plan: 02
gap_closure: true
gap_ids:
  - G-03-1
subsystem: ui
tags: [flutter, aac, info-page, quick-start, localization, widget-test]

requires:
  - phase: 03-practical-aac-guidance-info
    plan: 01
    provides: Working InfoPage with 3 Material 3 Cards
provides:
  - 4-step Quick Start guidance on InfoPage
  - Clear queue management instructions (horizontal scroll, long-press reorder, deletion)
  - Updated "Näytä ja kuuntele" wording using "ja"
  - Instructions for saving assembled image sequences as stories for repeated use
  - Full localization in FI, SV, and EN
affects: [info_page, l10n]

actuals:
  tokens: 1200
  tasks: 3
  commits: 1

tech-stack:
  added: []
  patterns:
    - Expanded Quick Start step hierarchy with persistable stories instruction

key-files:
  created: []
  modified:
    - lib/l10n/intl_fi.arb
    - lib/l10n/intl_sv.arb
    - lib/l10n/intl_en.arb
    - lib/pages/info_page.dart
    - test/pages/info_page_test.dart

key-decisions:
  - "Updated Step 2 to explain queue scrolling, reordering by long-pressing, and deletion."
  - "Updated Step 3 title and text from 'Näytä tai kuuntele' to 'Näytä ja kuuntele' ('ja' instead of 'tai')."
  - "Added Step 4 to instruct saving assembled queues as stories for repeated communication routines."
  - "Preserved full localization across Finnish, Swedish, and English."

patterns-established:
  - "Quick Start covers end-to-end user journey: Search -> Queue & Edit -> View & Listen -> Save"

requirements-completed:
  - GUIDE-01
  - GUIDE-02

duration: 5 min
completed: 2026-09-13
---

# Plan 03-02 Summary: Quick Start Guidance Enhancements (Gap Closure G-03-1)

Closed UAT gap G-03-1 by expanding and refining the Pikaopas (Quick Start) card on `InfoPage` to cover the full communication lifecycle.

## Accomplishments

1. **Queue Management Instructions (Step 2)**:
   - Added guidance on horizontal scrolling (sivuttaisvieritys), reordering by long-pressing and dragging, and removing images.
2. **Integrated Viewing and Speech (Step 3)**:
   - Changed "Näytä tai kuuntele" to "Näytä ja kuuntele" with "ja" replacing "tai" in the description.
3. **Saving Stories for Repeated Use (Step 4)**:
   - Added Step 4 explaining how to save the assembled queue as a story using the bookmark icon for recurring routines.
4. **Full Multi-Locale & Test Coverage**:
   - Updated ARB files (`intl_fi.arb`, `intl_sv.arb`, `intl_en.arb`) and regenerated localizations.
   - Updated `test/pages/info_page_test.dart` to verify all 4 steps in Finnish, Swedish, and English.
   - Verified that all 65 tests in the test suite pass.
