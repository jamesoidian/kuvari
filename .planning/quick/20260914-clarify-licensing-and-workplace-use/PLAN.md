---
task: clarify-licensing-and-workplace-use
date: 2026-09-14
type: execute
files_modified:
  - lib/l10n/intl_fi.arb
  - lib/l10n/intl_sv.arb
  - lib/l10n/intl_en.arb
  - docs/index.html
  - test/pages/info_page_test.dart
must_haves:
  truths:
    - "InfoPage paragraph 1 states the app was developed as a free assistive tool rather than for non-commercial purposes only."
    - "InfoPage paragraph 2 explicitly clarifies that the app and images may be used free of charge in everyday life, education, therapy, and workplaces to support communication, but images may not be sold or used in commercial products (Papunet CC BY-NC-SA)."
    - "All three locales (FI, SV, EN) and docs/index.html reflect these clarifications consistently."
    - "All test suite tests pass."
---

# Quick Plan: Clarify Licensing and Workplace Use

Clarify in InfoPage descriptions and website documentation that Kuvari is a free assistive tool that may be used freely in workplaces, education, and care work without restriction, while accurately reflecting Papunet's CC BY-NC-SA license (prohibiting resale or commercial product sales).

## Tasks

1. Update ARB files (`intl_fi.arb`, `intl_sv.arb`, `intl_en.arb`) for `infoPageParagraph1` and `infoPageParagraph2`.
2. Regenerate localizations (`flutter gen-l10n`).
3. Update `docs/index.html` to align with the revised description.
4. Verify with `test/pages/info_page_test.dart` and full `flutter test`.
