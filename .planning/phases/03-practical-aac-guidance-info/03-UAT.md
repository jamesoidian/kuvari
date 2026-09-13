---
status: complete
phase: 03-practical-aac-guidance-info
source:
  - .planning/phases/03-practical-aac-guidance-info/03-01-SUMMARY.md
started: 2026-09-13T19:37:00Z
updated: 2026-09-13T19:41:50Z
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
  artifacts:
    - lib/pages/info_page.dart
    - lib/l10n/intl_fi.arb
    - lib/l10n/intl_sv.arb
    - lib/l10n/intl_en.arb
  missing:
    - "Pikaoppaan askel jonon hallintaan (vieritys, poisto, pitkä painallus järjestämiseen)"
    - "Pikaoppaan askel tarinan tallentamiseen toistuvaa käyttöä varten"
    - "3. kohdan otsikon ja tekstin päivitys 'Näytä ja kuuntele' ('tai' -> 'ja')"
