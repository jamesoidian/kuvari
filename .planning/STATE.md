---
gsd_state_version: "1.0"
milestone: v1.6.0
milestone_name: Story Editing & Safe Queue Management
status: planned
last_updated: "2026-09-14T06:10:00.000Z"
last_activity: 2026-09-14
progress:
  total_phases: 3
  completed_phases: 0
  total_plans: 1
  completed_plans: 0
  percent: 0
---

# State

> Last Updated: 2026-09-14

## Current Position

Phase: Phase 5: Safe Browsing & Carousel Protection
Plan: 05.01
Status: Phase 5 planned and ready to execute
Last activity: 2026-09-14 — Phase 5 plan 05.01 created (Safe Browsing & Carousel Protection)

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

## Quick Tasks Completed

| Task | Date | Status | Description |
|------|------|--------|-------------|
| `clarify-licensing-and-workplace-use` | 2026-09-14 | Complete ✓ | Clarify free assistive tool status and workplace/care usage in InfoPage and docs |
| [260914-bya](./quick/260914-bya-update-saved-stories-tag-terminology/) | 2026-09-14 | Complete ✓ | Update saved stories tag terminology ("Avainsana" -> "Tägi"), hints, and guidance |

## Next Steps
 
1. Execute Phase 5: `/gsd-execute-phase 5` (Safe Browsing & Carousel Protection)
