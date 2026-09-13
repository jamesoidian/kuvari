# Requirements: Kuvari

**Defined:** 2026-09-13
**Core Value:** Providing a fast, simple, and intuitive visual communication tool that empowers users to express needs, understand daily structures, and make choices through symbols.

## v1.5.0 Requirements

### Terminology & Search Quality

- [ ] **TERM-01**: Rename "Category" / "Kategoria" to "Image Type" / "Kuvatyyppi" across all UI labels, dialog headers, tooltips, and localization files (`fi`, `sv`, `en`).
- [ ] **IMG-01**: Search result image cards render crisp, high-resolution symbols on high-DPI displays without raster blurriness.

### Home Screen Guidance & Collection Queue

- [ ] **JONO-01**: Selected images collection area is always visible on `HomePage` with an instructive empty state that explains how images are collected into a story or board.
- [ ] **JONO-02**: A clear, prominent play/view action button is directly accessible from the collection area to open `ImageViewerPage` once images are selected.

### Viewer Choice Mode & Playback

- [ ] **VIEW-01**: `ImageViewerPage` supports a side-by-side comparison mode (image pair) to facilitate AAC choice-making interactions.
- [ ] **VIEW-02**: User can toggle between single-image storytelling view and side-by-side choice mode when viewing stories.

### Practical Communication Guides & Info

- [ ] **GUIDE-01**: `InfoPage` provides practical AAC communication guidance, including real-world examples for choice-making, daily routines, and symbol pointing with speech synthesis.
- [ ] **GUIDE-02**: `InfoPage` organizes content into distinct sections for Quick Start, Practical Use Cases, and Source & License Attributions.

---

## Out of Scope

| Feature | Reason |
|---------|--------|
| Multi-tier category taxonomy | Symbol databases like Papunet provide styles/sources (Arasaac, Sclera, photos), not nested topic hierarchies. |
| Complex phrase grammar generation | Kuvari's core value is simple visual sequencing and choice-making, not complex linguistic syntax. |
| Cloud account sync | Offline-first privacy and speed via Hive is the preferred architecture. |

---

## Traceability

| Requirement | Phase | Status |
|-------------|-------|--------|
| TERM-01 | Phase 1 | Pending |
| IMG-01 | Phase 1 | Pending |
| JONO-01 | Phase 2 | Pending |
| JONO-02 | Phase 2 | Pending |
| VIEW-01 | Phase 3 | Pending |
| VIEW-02 | Phase 3 | Pending |
| GUIDE-01 | Phase 4 | Pending |
| GUIDE-02 | Phase 4 | Pending |

**Coverage:**
- Milestone v1.5.0 requirements: 8 total
- Mapped to phases: 8
- Unmapped: 0 ✓

---
*Requirements defined: 2026-09-13 after Papunet feedback analysis*
