# ROADMAP.md — Milestone v1.5.0: UX & AAC Communication Enhancements

> **Current Milestone**: v1.5.0 — UX & AAC Communication Enhancements  
> **Goal**: Refine onboarding guidance, terminology, image clarity, AAC choice-making capabilities, and practical communication documentation based on Papunet feedback.

## Phases

| # | Phase | Status | Goal | Requirements | Success Criteria |
|---|-------|--------|------|--------------|------------------|
| 1 | **Terminology & Search Sharpness** | [x] Complete | Correct "Category" to "Image Type" across languages and ensure search images render with high clarity. | TERM-01, IMG-01 | 2 criteria |
| 2 | **Home Guidance & Collection Queue** | [ ] Ready | Keep collection queue visible with instructive empty state and prominent viewer launch action. | JONO-01, JONO-02 | 2 criteria |
| 3 | **Viewer Choice Mode (Image Pairs)** | [ ] Planned | Enable side-by-side comparison in viewer for two-choice AAC interactions. | VIEW-01, VIEW-02 | 2 criteria |
| 4 | **Practical AAC Guidance & Info** | [ ] Planned | Expand InfoPage with practical AAC communication examples and structured guides. | GUIDE-01, GUIDE-02 | 2 criteria |

---

### Phase 1: Terminology & Search Sharpness (Completed: 2026-09-13)
**Goal:** Align UI nomenclature with AAC standards and fix blurry search thumbnails.
- **Requirements:**
  - `TERM-01`: Rename "Category" / "Kategoria" to "Image Type" / "Kuvatyyppi" in UI dialogs, tooltips, and ARB localization files.
  - `IMG-01`: Render high-resolution images in `ImageGrid` to eliminate pixelation on high-DPI displays.
- **Success Criteria:**
  1. Filter button and selection dialog display "Kuvatyypit" / "Valitse kuvatyypit" (FI), "Bildtyper" (SV), and "Image types" (EN).
  2. Search symbols in the grid appear sharp and clear on mobile Retina screens.

### Phase 2: Home Guidance & Collection Queue
**Goal:** Provide clear mental model of how images are collected and played.
- **Requirements:**
  - `JONO-01`: Display collection area on `HomePage` even when empty, using an instructive empty state.
  - `JONO-02`: Provide an intuitive, obvious action button to view the collected story.
- **Success Criteria:**
  1. Empty state tells user: "Valitsemasi kuvat tulevat tähän jonoon. Voit koota viestin, päiväjärjestyksen tai valintataulun."
  2. Action button to view/play the story is clearly visible and accessible when images are added.

### Phase 3: Viewer Choice Mode (Image Pairs)
**Goal:** Support two-choice AAC decision making directly in `ImageViewerPage`.
- **Requirements:**
  - `VIEW-01`: Support side-by-side image pair layout in `ImageViewerPage`.
  - `VIEW-02`: Toggle between sequential single-image paging and side-by-side choice view.
- **Success Criteria:**
  1. When viewing 2 images, user can view both images simultaneously side-by-side with individual TTS triggers.
  2. User can toggle between single-image paging and side-by-side mode.

### Phase 4: Practical AAC Guidance & Info
**Goal:** Offer concrete, actionable AAC communication examples on the Info page.
- **Requirements:**
  - `GUIDE-01`: Provide real-world examples (choice-making, daily routine, TTS pointing).
  - `GUIDE-02`: Separate content into Quick Start, Practical Use Cases, and Attributions.
- **Success Criteria:**
  1. `InfoPage` explains concrete AAC communication scenarios with step-by-step tips.
  2. External links to Papunet, OpenSymbols, and Rinnekodit remain clearly accessible alongside licensing info.
