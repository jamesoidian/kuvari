# Requirements: Kuvari

**Defined:** 2026-09-13
**Core Value:** Providing a fast, simple, and intuitive visual communication tool that empowers users to express needs, understand daily structures, and make choices through symbols.

## v1.5.0 Requirements

### Terminology & Search Quality

- [x] **TERM-01**: Rename "Category" / "Kategoria" to "Image Type" / "Kuvatyyppi" across all UI labels, dialog headers, tooltips, and localization files (`fi`, `sv`, `en`).
- [x] **IMG-01**: Search result image cards render crisp, high-resolution symbols on high-DPI displays without raster blurriness.

### Home Screen Guidance & Collection Queue

- [x] **JONO-01**: Selected images collection area is always visible on `HomePage` with an instructive empty state that explains how images are collected into a story or board.
- [x] **JONO-02**: A clear, prominent play/view action button is directly accessible from the collection area to open `ImageViewerPage` once images are selected.

### Practical Communication Guides & Info

- [x] **GUIDE-01**: `InfoPage` provides practical AAC communication guidance, including real-world examples for choice-making, daily routines, and symbol pointing with speech synthesis.
- [x] **GUIDE-02**: `InfoPage` organizes content into distinct sections for Quick Start, Practical Use Cases, and Source & License Attributions.

### Native Text-to-Speech

- [x] **TTS-01**: Implement native iOS speech channel using `AVSpeechSynthesizer` with language, rate, and pitch control.
- [x] **TTS-02**: Implement native Android speech channel using `android.speech.tts.TextToSpeech` with language, rate, and pitch control.
- [x] **TTS-03**: Remove `flutter_tts` dependency from `pubspec.yaml` and update Flutter services.

---

## Out of Scope

| Feature | Reason |
|---------|--------|
| Multi-tier category taxonomy | Symbol databases like Papunet provide styles/sources (Arasaac, Sclera, photos), not nested topic hierarchies. |
| Complex phrase grammar generation | Kuvari's core value is simple visual sequencing and choice-making, not complex linguistic syntax. |
| Cloud account sync | Offline-first privacy and speed via Hive is the preferred architecture. |
| Side-by-side viewer choice mode | Kept viewer focused on single-image and horizontal reel storytelling for v1.5.0; choice boards are constructed on the home collection queue. |

---

## Traceability

| Requirement | Phase | Status |
|-------------|-------|--------|
| TERM-01 | Phase 1 | Complete |
| IMG-01 | Phase 1 | Complete |
| JONO-01 | Phase 2 | Complete |
| JONO-02 | Phase 2 | Complete |
| GUIDE-01 | Phase 3 | Complete |
| GUIDE-02 | Phase 3 | Complete |
| TTS-01 | Phase 4 | Complete |
| TTS-02 | Phase 4 | Complete |
| TTS-03 | Phase 4 | Complete |

**Coverage:**

- Milestone v1.5.0 requirements: 9 total
- Mapped to phases: 9
- Unmapped: 0 ✓

---
*Requirements defined: 2026-09-13 after Papunet feedback analysis and native TTS migration plan*
