# Kuvari

## What This Is

Kuvari is an accessible Flutter application designed for image- and symbol-based communication (AAC - Augmentative and Alternative Communication). It allows individuals with speech, language, or communication challenges—and their caregivers, therapists, and educators—to search for symbols from Papunet and OpenSymbols, compose sequential communication stories, listen to speech synthesis pronunciation, and view or save stories for everyday communication routines and choice-making.

## Core Value

Providing a fast, simple, and intuitive visual communication tool that empowers users to express needs, understand daily structures, and make choices through symbols.

## Business / User Context

- **Primary Users**: Non-verbal or speech-impaired individuals who communicate using pictograms and symbols.
- **Support Users**: Speech therapists, special education teachers, caregivers, and family members.
- **Key Partners / Ecosystem**: Papunet (Finnish/Swedish symbol bank), OpenSymbols (international AAC symbols), Rinnekodit.

## Current Milestone: v1.6.0 — Story Editing & Safe Queue Management

**Goal:** Mahdollistaa tallennettujen kuvajonojen avaaminen ja muokkaaminen kotisivulla täysillä työkaluilla sekä suojata tallennetut jonot vahinkomuutoksilta.

**Target features:**
- Turvallinen selausnäkymä `SavedImageStoriesPage`-sivulla (estetään raahaaminen ja poistopainikkeet katselussa).
- "Muokkaa kotisivulla" -painike tallennettujen listaan, korvausvaroitusdialogi ja opastava siirtymä.
- Kotisivun muokkaustila (visuaalinen tilarivibanneri, tallenna muutokset / lopeta muokkaus, poistumisvarmistus).
- Joustava tallennusdialogi (päivitä olemassa oleva vs. tallenna uutena kuvajonona).

## Requirements

### Validated

- ✓ Symbol search from Papunet API (FI/SV) — v1.0
- ✓ Symbol search from OpenSymbols API via Cloud Functions (EN) — v1.0
- ✓ Offline persistence of image stories using Hive — v1.1
- ✓ Fullscreen responsive image viewer (portrait and landscape) — v1.2
- ✓ Tagging and organizing saved stories with tag management — v1.3
- ✓ Text-to-Speech (TTS) voice synthesis for symbols across FI, SV, EN — v1.4
- ✓ Modernized build toolchain (KGP 2.2.21, Swift Package Manager) — v1.4
- ✓ **TERM-01**: Rename "Category" / "Kategoria" to "Image Type" / "Kuvatyyppi" in all UI texts and localization files — Phase 1
- ✓ **IMG-01**: Improve image search result quality and sharpness on high-DPI Retina screens — Phase 1
- ✓ **JONO-01**: Always display the selected images collection area on the home screen with a clear, helpful empty state — Phase 2
- ✓ **JONO-02**: Add a prominent, intuitive action button to open the image viewer directly from the collection area — Phase 2
- ✓ **GUIDE-01**: Upgrade InfoPage to include practical guidance and examples for AAC communication routines — Phase 3
- ✓ **GUIDE-02**: Structure InfoPage into Quick Start, Practical Use Cases, and Attributions — Phase 3
- ✓ **TTS-01**: Implement native iOS speech channel using `AVSpeechSynthesizer` with language, rate, pitch, and silent mode playback — Phase 4
- ✓ **TTS-02**: Implement native Android speech channel using `TextToSpeech` with immediate interruption and lifecycle handling — Phase 4
- ✓ **TTS-03**: Refactor `TtsService` to communicate directly over `io.github.jamesoidian.kuvari/tts` and remove `flutter_tts` dependency — Phase 4

### Active

- [ ] **EDIT-01**: Disable drag reordering and deletion on `SavedImageStoriesPage` so it acts as a safe, pure browsing carousel.
- [ ] **EDIT-02**: Add "Muokkaa kotisivulla" action to saved story cards with replacement warning if home queue has items.
- [ ] **EDIT-03**: Implement HomePage Edit Mode banner with story title, Save changes, and Exit/Cancel actions.
- [ ] **EDIT-04**: Implement dual-mode save dialog in Edit Mode ("Päivitä olemassa oleva" vs "Tallenna uutena kuvajonona").
- [ ] **EDIT-05**: Implement unsaved changes confirmation on navigation or queue clearing in Edit Mode.

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

