# Kuvari

## What This Is

Kuvari is an accessible Flutter application designed for image- and symbol-based communication (AAC - Augmentative and Alternative Communication). It allows individuals with speech, language, or communication challenges—and their caregivers, therapists, and educators—to search for symbols from Papunet and OpenSymbols, compose sequential communication stories, listen to speech synthesis pronunciation, and view or save stories for everyday communication routines and choice-making.

## Core Value

Providing a fast, simple, and intuitive visual communication tool that empowers users to express needs, understand daily structures, and make choices through symbols.

## Business / User Context

- **Primary Users**: Non-verbal or speech-impaired individuals who communicate using pictograms and symbols.
- **Support Users**: Speech therapists, special education teachers, caregivers, and family members.
- **Key Partners / Ecosystem**: Papunet (Finnish/Swedish symbol bank), OpenSymbols (international AAC symbols), Rinnekodit.

## Current Milestone: v1.5.0 — UX & AAC Communication Enhancements

Focusing on expert feedback from Papunet: improving initial discovery and guidance, refining terminology from "category" to "image type", enhancing search thumbnail resolution, adding side-by-side choice-making (image pairs) in the viewer, and providing concrete practical AAC examples on the info page.

## Requirements

### Validated

- ✓ Symbol search from Papunet API (FI/SV) — v1.0
- ✓ Symbol search from OpenSymbols API via Cloud Functions (EN) — v1.0
- ✓ Offline persistence of image stories using Hive — v1.1
- ✓ Fullscreen responsive image viewer (portrait and landscape) — v1.2
- ✓ Tagging and organizing saved stories with tag management — v1.3
- ✓ Text-to-Speech (TTS) voice synthesis for symbols across FI, SV, EN — v1.4
- ✓ Modernized build toolchain (KGP 2.2.21, Swift Package Manager) — v1.4

### Active

- [ ] **TERM-01**: Rename "Category" / "Kategoria" to "Image Type" / "Kuvatyyppi" in all UI texts and localization files.
- [ ] **IMG-01**: Improve image search result quality and sharpness on high-DPI Retina screens.
- [ ] **JONO-01**: Always display the selected images collection area on the home screen with a clear, helpful empty state.
- [ ] **JONO-02**: Add a prominent, intuitive action button to open the image viewer directly from the collection area.
- [ ] **VIEW-01**: Support side-by-side comparison / image pair display in ImageViewerPage for AAC choice-making situations.
- [ ] **GUIDE-01**: Upgrade InfoPage to include practical guidance and examples for AAC communication routines.

### Out of Scope

- **Full custom phrase building engine**: Kuvari focuses on sequential stories and choice pairs, not complex grammar composition.
- **Cloud synchronization of stories**: Local Hive offline storage remains the priority for privacy and offline reliability.
- **Complex multi-level folder hierarchies**: Flat tags remain the chosen approach for simplicity.

## Context

Feedback from a Papunet specialist highlighted that first-time users struggled to understand where selected images go and how to enter the viewer. Furthermore, the term "kategoria" caused confusion with topic-based categorization, and low-res thumbnails appeared blurry on phone screens. Additionally, two-choice selection is a foundational AAC interaction pattern that was difficult in single-image portrait view.

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
| Rename categories to image types | Aligns with standard AAC nomenclature (Arasaac, Sclera, photos are styles, not topics) | Pending |
| Empty state collection queue | Teaches app concept immediately on launch | Pending |
| Side-by-side choice mode in viewer | Critical AAC use case: choosing between 2 options | Pending |

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
