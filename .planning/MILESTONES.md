# Milestones

## v1.6.0 Story Editing & Safe Queue Management (Shipped: 2026-09-14)

**Phases completed:** 3 phases, 5 plans, 11 tasks

**Key accomplishments:**

- Locked down the carousel on `SavedImageStoriesPage` to prevent accidental drag-to-reorder (`isReorderable: false`) and suppressed symbol delete buttons during browsing (Phase 5).
- Implemented an intuitive "Muokkaa kotisivulla" transition from saved story cards to `HomePage`, including an active queue replacement warning dialog (Phase 6).
- Built a persistent, amber `EditModeBanner` above the collection queue with live title editing, quick-save, and exit actions, backed by `PopScope` unsaved modification guards (Phase 6).
- Developed a dual-mode save dialog allowing caregivers and therapists to either update the existing story in Hive (preserving ID and tags) or save as a new independent story (`[Name] (kopio)`) with full trilingual localization (Phase 7).
- Re-architected saved story card actions into vertically stacked right-edge buttons, maximizing horizontal queue display width and maintaining 100% pass rate across 94 automated tests.

---

## v1.5.0 UX & AAC Communication Enhancements (Shipped: 2026-09-14)

**Phases completed:** 4 phases, 7 plans, 0 tasks

**Key accomplishments:**

- Aligned symbol set filtering terminology with AAC standards ("Image Type" / "Kuvatyyppi" / "Bildtyp") and replaced low-resolution grid thumbnails with full-resolution symbol URLs for crisp Retina rendering (Phase 1).
- Kept collection queue persistently visible with an instructive empty state and added an extended FAB with dynamic item count to launch the story viewer (Phase 2).
- Expanded InfoPage with 3 structured Material 3 sections: Quick Start (with queue editing and tagging instructions), Practical AAC Scenarios (Choice-Making, Routines, Pointing & Modeling), and Attributions (Phase 3).
- Replaced third-party `flutter_tts` dependency with robust native iOS `AVSpeechSynthesizer` (supporting silent mode playback) and Android `TextToSpeech` (with instant interruption) via direct `io.github.jamesoidian.kuvari/tts` MethodChannel communication (Phase 4).

---
