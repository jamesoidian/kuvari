---
gsd_state_version: "1.0"
milestone: v1.5.0
milestone_name: UX & AAC Communication Enhancements
status: complete
last_updated: "2026-09-13T19:36:00.000Z"
state_head: 64dd401
progress:
  total_phases: 4
  completed_phases: 4
  total_plans: 6
  completed_plans: 6
  percent: 100
current_phase: 4
current_phase_name: native-text-to-speech-ios-android
---

# State

> Last Updated: 2026-09-13

## Current Position

- **Milestone**: v1.5.0 — UX & AAC Communication Enhancements
- **Phase**: Phase 4: Native Text-to-Speech (iOS & Android)
- **Status**: Milestone complete — all 4 phases finished and verified
- **Last activity**: 2026-09-13 — Completed Phase 4 UAT verification (4 passed, 0 issues)

## Milestone v1.5.0 Summary

- **Phase 1: Terminology & Search Sharpness** (`TERM-01`, `IMG-01`):
  - Renamed "Category" to "Image Type" across FI, SV, EN.
  - Enabled high-resolution images in search grid for crisp Retina display rendering.
- **Phase 2: Home Guidance & Collection Queue** (`JONO-01`, `JONO-02`):
  - Added instructive empty state placeholder for the collection queue.
  - Added dynamic extended FAB displaying image count to launch story viewer.
- **Phase 3: Practical AAC Guidance & Info** (`GUIDE-01`, `GUIDE-02`):
  - Expanded InfoPage with 3 structured Material 3 sections: Quick Start, Practical AAC Scenarios (Choice-Making, Routines, Pointing & Modeling), and Attributions.
- **Phase 4: Native Text-to-Speech (iOS & Android)** (`TTS-01`, `TTS-02`, `TTS-03`):
  - Implemented native iOS `AVSpeechSynthesizer` with silent mode playback support and instant speech interruption.
  - Implemented native Android `TextToSpeech` with `QUEUE_FLUSH` interruption and lifecycle handling.
  - Refactored `TtsService` to communicate over `io.github.jamesoidian.kuvari/tts` MethodChannel.
  - Removed `flutter_tts` package and build dependencies completely.
  - Verified with 4/4 UAT manual tests passed.

## Accumulated Context

### Key Decisions

- Native iOS & Android TTS via MethodChannel replaces third-party plugin issues with swift/kotlin compatibility.
- AAC speech synthesis interrupts active utterances immediately on symbol selection to support fast non-verbal communication.

## Next Steps

1. Complete Milestone: `/gsd-complete-milestone v1.5.0`
