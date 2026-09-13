---
status: diagnosed
phase: 03-practical-aac-guidance-info
source:
  - .planning/phases/03-practical-aac-guidance-info/03-01-SUMMARY.md
started: 2026-09-13T19:37:00Z
updated: 2026-09-13T19:42:30Z
---

## Current Test

[testing complete]

## Tests

### 1. Info-näkymän rakenne ja korttiosiot (Pikaopas)
expected: Avaa Info-sivu yläpalkin infokuvakkeesta. Näkymä rullaa sujuvasti ja siinä näkyy kolme selkeää korttia: Pikaopas, Käytännön tilanteet sekä Tietoa ja lähteet.
result: issue
reported: "Pikaopas kaipaa parantamista: - Pikaoppaasta puuttuu tallentamisen opastaminen, kuvajonot voi tallentaa toistuvaa käyttöä varten; - Pikaoppaasta puuttuu kuvajonon vierittäminen vasemmalle ja oikealle, järjestyksen muuttaminen pitkään painamalla ja kuvien poistaminen; - 3. kohta pitäisi ennemmin olla 'Näytä ja kuuntele' samoin tekstissä tai -> ja"
severity: major

### 2. Käytännön AAC-tilanteet ja opastus
expected: "Käytännön tilanteet" -kortissa on kolme konkreettista AAC-tilannetta (Valintojen tekeminen, Päiväjärjestys ja rutiinit, Osoittaminen ja mallittaminen) vaiheittaisine ohjeineen.
result: pass

### 3. Lähteet ja linkkien avaaminen
expected: "Tietoa ja lähteet" -osiossa näkyvät linkit (Papunet, OpenSymbols, Rinnekodit, lisenssi). Linkkiä napautettaessa verkkosivu avautuu ulkoisessa selaimessa.
result: pass

### 4. Kielituki
expected: Vaihda sovelluksen kieli (suomi, ruotsi tai englanti). Koko Info-sivun otsikot, ohjeet ja linkkitekstit kääntyvät valitulle kielelle ilman puuttuvia käännöksiä.
result: pass

## Summary

total: 4
passed: 3
issues: 1
pending: 0
skipped: 0
blocked: 0

## Gaps

<!-- YAML format for plan-phase --gaps consumption -->
- gap_id: G-03-1
  truth: "Pikaoppaan tulee opastaa tallentaminen toistuvaa käyttöä varten, jonon vaakavieritys/järjestäminen/poisto sekä otsikoida ja kuvata 3. vaihe 'Näytä ja kuuntele' (ja-sanalla)."
  status: failed
  reason: "User reported: Pikaopas kaipaa parantamista: - Pikaoppaasta puuttuu tallentamisen opastaminen, kuvajonot voi tallentaa toistuvaa käyttöä varten; - Pikaoppaasta puuttuu kuvajonon vierittäminen vasemmalle ja oikealle, järjestyksen muuttaminen pitkään painamalla ja kuvien poistaminen; - 3. kohta pitäisi ennemmin olla 'Näytä ja kuuntele' samoin tekstissä tai -> ja"
  severity: major
  test: 1
  root_cause: "InfoPage hardcodes only 3 Quick Start steps and ARB copy omits queue scrolling/reordering/deletion, saving stories, and uses 'tai' instead of 'ja'."
  artifacts:
    - path: "lib/pages/info_page.dart"
      issue: "Only renders 3 Quick Start steps"
    - path: "lib/l10n/intl_fi.arb"
      issue: "Missing step 4 strings and step 2/3 copy lacks queue management and 'ja'"
    - path: "lib/l10n/intl_sv.arb"
      issue: "Missing step 4 strings and step 2/3 copy lacks queue management and 'och'"
    - path: "lib/l10n/intl_en.arb"
      issue: "Missing step 4 strings and step 2/3 copy lacks queue management and 'and'"
  missing:
    - "Add step 4 ARB strings for saving stories across fi, sv, en"
    - "Update step 2 to explain queue scrolling, long-press reorder, and delete"
    - "Update step 3 title and text to 'Näytä ja kuuntele' with 'ja'"
    - "Add step 4 widget rendering in InfoPage"
  debug_session: ".planning/debug/pikaopas-guidance-gaps.md"
