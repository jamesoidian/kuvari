---
status: resolved
---

# Debug Session: Pikaopas (Quick Start) Guidance Gaps

## Issue Description
User reported during UAT of Phase 3 that the Pikaopas (Quick Start) card on `InfoPage` is incomplete:
1. Missing instruction on queue management: horizontal scrolling (vierittäminen vasemmalle ja oikealle), reordering by long-pressing and dragging (järjestyksen muuttaminen pitkään painamalla), and removing images.
2. Step 3 title & text wording: should be "Näytä ja kuuntele" instead of "Näytä tai kuuntele", and the description should use "ja" instead of "tai".
3. Missing instruction on saving queues: saving image stories/sequences for repeated daily use (tallentaminen toistuvaa käyttöä varten).

## Root Cause
`lib/pages/info_page.dart` hardcodes exactly 3 steps for Quick Start using ARB keys `infoQuickStartStep1*`, `infoQuickStartStep2*`, and `infoQuickStartStep3*`.
The current copy in `intl_fi.arb`, `intl_sv.arb`, and `intl_en.arb` only describes adding images to the queue and viewing them, omitting:
- Horizontal scrolling, long-press drag-to-reorder, and deleting items from the active queue.
- The distinction and combination of viewing and listening ("ja" instead of "tai").
- Saving the assembled queue to local storage as a reusable story via the bookmark/save button.

## Files Involved
- `lib/pages/info_page.dart`: Quick Start card steps layout (update to 4 structured steps).
- `lib/l10n/intl_fi.arb`: Finnish copy for Quick Start steps 1–4.
- `lib/l10n/intl_sv.arb`: Swedish copy for Quick Start steps 1–4.
- `lib/l10n/intl_en.arb`: English copy for Quick Start steps 1–4.
- `test/pages/info_page_test.dart`: Widget tests verifying updated steps and copy.

## Suggested Fix
1. Update ARB files (`intl_fi.arb`, `intl_sv.arb`, `intl_en.arb`):
   - Update Step 2: "Kokoa ja muokkaa jonoa" / "Bygg och ändra i kön" / "Assemble and edit the queue" describing horizontal scrolling, reordering by long press, and deletion.
   - Update Step 3: Title "3. Näytä ja kuuntele" / "3. Visa och lyssna" / "3. View and listen" with "ja" / "och" / "and" in copy.
   - Add Step 4: "4. Tallenna toistuvaa käyttöä varten" / "4. Spara för återkommande användning" / "4. Save for repeated use" explaining how to save the queue as a story for future communication routines.
2. In `lib/pages/info_page.dart`:
   - Render `_buildQuickStartStep` for step 4.
3. Run `flutter gen-l10n` to regenerate localizations.
4. Update and run `test/pages/info_page_test.dart` to verify all 4 steps render correctly across FI, SV, and EN.
