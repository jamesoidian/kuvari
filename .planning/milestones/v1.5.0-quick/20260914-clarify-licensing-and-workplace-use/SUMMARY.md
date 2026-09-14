---
task: clarify-licensing-and-workplace-use
date: 2026-09-14
status: complete
files_modified:
  - lib/l10n/intl_fi.arb
  - lib/l10n/intl_sv.arb
  - lib/l10n/intl_en.arb
  - docs/index.html
  - test/pages/info_page_test.dart
---

# Quick Task Summary: Clarify Licensing and Workplace Use

Clarified in InfoPage descriptions and website documentation that Kuvari is a free assistive tool that may be used freely in workplaces, education, and care work without restriction, while accurately reflecting Papunet's CC BY-NC-SA license (prohibiting resale or commercial product sales).

## Accomplishments

1. **InfoPage Paragraph 1**:
   - Replaced "kehitetty epäkaupallisiin tarkoituksiin" with "kehitetty ilmaiseksi apuvälineeksi, erityisesti vaihtoehtoisen kommunikoinnin tueksi" across FI, SV, and EN.
2. **InfoPage Paragraph 2**:
   - Explicitly clarified that the application and images may be used free of charge in everyday life, education, therapy, and workplaces to support communication, but images may not be sold or used in commercial products (complying with Papunet's CC BY-NC-SA license).
3. **Website Documentation (`docs/index.html`)**:
   - Aligned description paragraph to state that Kuvari is developed as a free assistive tool.
4. **Verification**:
   - Ran `flutter gen-l10n` to regenerate localizations.
   - Verified that `test/pages/info_page_test.dart` and the entire 65-test suite pass cleanly.
