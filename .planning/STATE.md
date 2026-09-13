---
gsd_state_version: "1.0"
milestone: v1.5.0
milestone_name: UX & AAC Communication Enhancements
status: ready_to_discuss
last_updated: "2026-09-13T16:17:35.986Z"
state_head: e2051f4223a2fbb6354fa23edd095a3ffb8bdef0
progress:
  total_phases: 4
  completed_phases: 1
  total_plans: 6
  completed_plans: 6
  percent: 25
current_phase: 4
current_phase_name: native-text-to-speech-ios-android
---

# State

> Last Updated: 2026-09-13

## Current Position

- **Milestone**: v1.5.0 — UX & AAC Communication Enhancements
- **Phase**: Phase 4: Native Text-to-Speech (iOS & Android)
- **Status**: Phase 3 complete; ready for Phase 4
- **Last activity**: 2026-09-13 — Completed Phase 3: Practical AAC Guidance & Info (`GUIDE-01`, `GUIDE-02`)

## Last Session Summary

- Completed Phase 1: Terminology & Search Sharpness (`TERM-01`, `IMG-01`).
- Completed Phase 2: Home Guidance & Collection Queue (`JONO-01`, `JONO-02`).
- Completed Phase 3: Practical AAC Guidance & Info (`GUIDE-01`, `GUIDE-02`):
  - Defined 15 localized strings across Finnish, Swedish, and English for Quick Start, Practical Situations, and Attributions.
  - Refactored `InfoPage` into a responsive, scrollable `ListView` with three Material 3 `Card` sections.
  - Implemented concrete AAC scenarios (Choice-Making, Daily Routines & Sequences, Pointing & Speech Modeling).
  - Preserved external URL launching with dependency-injected `urlLauncher` for isolated testing.
  - Verified with 56 unit and widget tests passing across all supported locales (0 analyzer warnings).

## Accumulated Context

### Roadmap Evolution

- Phase 4: Native Text-to-Speech (iOS & Android) — replace `flutter_tts` dependency with native iOS `AVSpeechSynthesizer` and Android `android.speech.tts.TextToSpeech`.

## Next Steps

1. Discuss or Plan Phase 4 (Native Text-to-Speech): `/gsd-discuss-phase 4` or `/gsd-plan-phase 4`
