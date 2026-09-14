# Kuvari

## What This Is

Kuvari is an accessible Flutter application designed for image- and symbol-based communication (AAC - Augmentative and Alternative Communication). It allows individuals with speech, language, or communication challenges—and their caregivers, therapists, and educators—to search for symbols from Papunet and OpenSymbols, compose sequential communication stories, listen to speech synthesis pronunciation, and view or save stories for everyday communication routines and choice-making.

## Core Value

Providing a fast, simple, and intuitive visual communication tool that empowers users to express needs, understand daily structures, and make choices through symbols.

## Business / User Context

- **Primary Users**: Non-verbal or speech-impaired individuals who communicate using pictograms and symbols.
- **Support Users**: Speech therapists, special education teachers, caregivers, and family members.
- **Key Partners / Ecosystem**: Papunet (Finnish/Swedish symbol bank), OpenSymbols (international AAC symbols), Rinnekodit.

## Current State: v1.6.0 (Shipped: 2026-09-14)

**Latest Milestone Shipped:** v1.6.0 — Story Editing & Safe Queue Management  
**Status:** All v1.6.0 phases and requirements validated. Ready for `/gsd-new-milestone`.

## Requirements

### Validated

- ✓ Symbol search from Papunet API (FI/SV) — v1.0
- ✓ Symbol search from OpenSymbols API via Cloud Functions (EN) — v1.0
- ✓ Offline persistence of image stories using Hive — v1.1
- ✓ Fullscreen responsive image viewer (portrait and landscape) — v1.2
- ✓ Tagging and organizing saved stories with tag management — v1.3
- ✓ Text-to-Speech (TTS) voice synthesis for symbols across FI, SV, EN — v1.4
- ✓ Modernized build toolchain (KGP 2.2.21, Swift Package Manager) — v1.4
- ✓ **TERM-01**: Rename "Category" / "Kategoria" to "Image Type" / "Kuvatyyppi" in all UI texts and localization files — v1.5.0
- ✓ **IMG-01**: Improve image search result quality and sharpness on high-DPI Retina screens — v1.5.0
- ✓ **JONO-01**: Always display the selected images collection area on the home screen with a clear, helpful empty state — v1.5.0
- ✓ **JONO-02**: Add a prominent, intuitive action button to open the image viewer directly from the collection area — v1.5.0
- ✓ **GUIDE-01**: Upgrade InfoPage to include practical guidance and examples for AAC communication routines — v1.5.0
- ✓ **GUIDE-02**: Structure InfoPage into Quick Start, Practical Use Cases, and Attributions — v1.5.0
- ✓ **TTS-01**: Implement native iOS speech channel using `AVSpeechSynthesizer` with language, rate, pitch, and silent mode playback — v1.5.0
- ✓ **TTS-02**: Implement native Android speech channel using `TextToSpeech` with immediate interruption and lifecycle handling — v1.5.0
- ✓ **TTS-03**: Refactor `TtsService` to communicate directly over `io.github.jamesoidian.kuvari/tts` and remove `flutter_tts` dependency — v1.5.0
- ✓ **SAFE-01**: Disable drag reordering on `SavedImageStoriesPage` carousel (`isReorderable: false`) — v1.6.0
- ✓ **SAFE-02**: Ensure individual image delete buttons are absent in saved stories carousel — v1.6.0
- ✓ **EDIT-01**: Provide explicit "Muokkaa kotisivulla" action button on saved story cards — v1.6.0
- ✓ **EDIT-02**: Show confirmation warning dialog when opening story if home queue has items — v1.6.0
- ✓ **EDIT-03**: Transition to `HomePage` in Edit Mode, populating queue with feedback SnackBar — v1.6.0
- ✓ **MODE-01**: Persistent `EditModeBanner` above collection queue with story name, save, and exit actions — v1.6.0
- ✓ **MODE-02**: Guard against data loss on queue clear or navigation with unsaved modifications — v1.6.0
- ✓ **SAVE-01**: Dual-mode save dialog offering "Päivitä olemassa oleva" vs "Tallenna uutena..." — v1.6.0
- ✓ **SAVE-02**: Clean exit from Edit Mode upon saving or cancellation, returning queue to clean state — v1.6.0

### Active

*(None — define next milestone with `/gsd-new-milestone`)*

### Out of Scope

- **Full custom phrase building engine**: Kuvari focuses on sequential stories and choice pairs, not complex grammar composition.
- **Cloud synchronization of stories**: Local Hive offline storage remains the priority for privacy and offline reliability.
- **Complex multi-level folder hierarchies**: Flat tags remain the chosen approach for simplicity.


## Context

Feedback from a Papunet specialist highlighted that first-time users struggled to understand where selected images go and how to enter the viewer. Furthermore, the term "kategoria" caused confusion with topic-based categorization, and low-res thumbnails appeared blurry on phone screens. All four phases of Milestone v1.5.0 addressed these points along with replacing the legacy `flutter_tts` plugin with robust native iOS and Android speech synthesis.

## Constraints

- **Framework**: Flutter 3.47.4 / Dart 3.13.3.
- **Platforms**: iOS, Android, macOS, Web.
- **Persistence**: Hive (local offline NoSQL).
- **Languages**: Finnish (default), Swedish, English.
- **Accessibility**: High contrast, clear touch targets, screen reader & TTS compatibility.

## Key Decisions

| Decision | Rationale | Outcome |
|----------|-----------|---------|
| Flat tags over hierarchical folders | Simpler for caregivers to manage; covers 90% of use cases | ✓ Good |
| Papunet direct HTTP + OpenSymbols via Cloud Function | Keep OpenSymbols secret key secure on server while keeping Papunet fast and direct | ✓ Good |
| Rename categories to image types | Aligns with standard AAC nomenclature (Arasaac, Sclera, photos are styles, not topics) | ✓ Good |
| Empty state collection queue | Teaches app concept immediately on launch | ✓ Good |
| Structured AAC InfoPage | Practical everyday AAC communication scenarios with step-by-step guidance | ✓ Good |
| Native iOS & Android TTS MethodChannel | Replaced buggy flutter_tts, supports iOS silent mode playback and instant interruption | ✓ Good |

## Evolution

This document evolves at phase transitions and milestone boundaries.

**After each phase transition** (via `/gsd-transition`):
1. Requirements invalidated? → Move to Out of Scope with reason
2. Requirements validated? → Move to Validated with phase reference
3. New requirements emerged? → Add to Active
4. Decisions to log? → Add to Key Decisions
5. "What This Is" still accurate? → Update if drifted

**After each milestone** (via `/gsd-complete-milestone`):
1. Full review of all sections
2. Core Value check — still the right priority?
3. Audit Out of Scope — reasons still valid?
4. Update Context with current state

---
*Last updated: 2026-09-14 after v1.5.0 milestone*

