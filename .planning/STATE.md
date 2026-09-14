---
gsd_state_version: "1.0"
milestone: v1.6.0
milestone_name: Story Editing & Safe Queue Management
status: planned
last_updated: "2026-09-14T06:27:00.000Z"
last_activity: 2026-09-14
progress:
  total_phases: 3
  completed_phases: 3
  total_plans: 5
  completed_plans: 5
  percent: 100
---

# State

> Last Updated: 2026-09-14

## Current Position

Phase: Phase 7: Dual-Mode Save Logic & Localization (Completed)
Plan: 07.02
Status: Milestone v1.6.0 all phases and plans completed and verified (5/5 plans)
Last activity: 2026-09-14 — Phase 7 completed (Dual-Mode Save Logic & Localization)

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
 
- SelectedImagesCarousel supports isReorderable: false, rendering standard ListView without drag reorder gestures to protect saved stories browsing.
- SavedImageStoriesPage disables symbol dragging and deletion buttons to eliminate accidental mutations during scrolling and navigation.
- Native iOS & Android TTS via MethodChannel replaces third-party plugin issues with swift/kotlin compatibility.
- AAC speech synthesis interrupts active utterances immediately on symbol selection to support fast non-verbal communication.

## Quick Tasks Completed

| Task | Date | Status | Description |
|------|------|--------|-------------|
| `clarify-licensing-and-workplace-use` | 2026-09-14 | Complete ✓ | Clarify free assistive tool status and workplace/care usage in InfoPage and docs |
| [260914-bya](./quick/260914-bya-update-saved-stories-tag-terminology/) | 2026-09-14 | Complete ✓ | Update saved stories tag terminology ("Avainsana" -> "Tägi"), hints, and guidance |
| [260914-update-saved-stories-tag-hint](./quick/260914-update-saved-stories-tag-hint/) | 2026-09-14 | Complete ✓ | Update tag hint copy on saved stories page ("...kuvajonoa pitkään") |
| [260914-stack-saved-stories-action-icons](./quick/260914-stack-saved-stories-action-icons/) | 2026-09-14 | Complete ✓ | Stack edit and play icons vertically on saved stories cards |

## Next Steps
 
1. Milestone Audit / Complete Milestone: `/gsd-complete-milestone`
