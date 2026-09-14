# Milestones

## v1.5.0 UX & AAC Communication Enhancements (Shipped: 2026-09-14)

**Phases completed:** 4 phases, 7 plans, 0 tasks

**Key accomplishments:**

- Aligned symbol set filtering terminology with AAC standards ("Image Type" / "Kuvatyyppi" / "Bildtyp") and replaced low-resolution grid thumbnails with full-resolution symbol URLs for crisp Retina rendering (Phase 1).
- Kept collection queue persistently visible with an instructive empty state and added an extended FAB with dynamic item count to launch the story viewer (Phase 2).
- Expanded InfoPage with 3 structured Material 3 sections: Quick Start (with queue editing and tagging instructions), Practical AAC Scenarios (Choice-Making, Routines, Pointing & Modeling), and Attributions (Phase 3).
- Replaced third-party `flutter_tts` dependency with robust native iOS `AVSpeechSynthesizer` (supporting silent mode playback) and Android `TextToSpeech` (with instant interruption) via direct `io.github.jamesoidian.kuvari/tts` MethodChannel communication (Phase 4).

---
