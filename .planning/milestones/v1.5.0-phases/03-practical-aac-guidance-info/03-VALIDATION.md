---
phase: "03"
slug: "practical-aac-guidance-info"
status: draft
nyquist_compliant: true
wave_0_complete: false
created: "2026-09-13"
---

# Phase 03 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | flutter_test (Flutter SDK) |
| **Config file** | pubspec.yaml |
| **Quick run command** | `flutter test test/pages/info_page_test.dart` |
| **Full suite command** | `flutter test` |
| **Estimated runtime** | ~15 seconds |

---

## Sampling Rate

- **After every task commit:** Run `flutter test test/pages/info_page_test.dart`
- **After every plan wave:** Run `flutter test`
- **Before `/gsd-verify-work`:** Full suite must be green
- **Max feedback latency:** 15 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Threat Ref | Secure Behavior | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|------------|-----------------|-----------|-------------------|-------------|--------|
| 03-01-01 | 01 | 1 | GUIDE-01, GUIDE-02 | — | N/A | codegen | `flutter gen-l10n && flutter test` | ✅ | ⬜ pending |
| 03-01-02 | 01 | 1 | GUIDE-01, GUIDE-02 | — | N/A | widget | `flutter analyze lib/pages/info_page.dart` | ✅ | ⬜ pending |
| 03-01-03 | 01 | 1 | GUIDE-01, GUIDE-02 | — | Safe external URL dispatching | widget | `flutter test test/pages/info_page_test.dart` | ❌ W0 | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `test/pages/info_page_test.dart` — widget tests for cards, guidance, links, and multi-locale rendering (GUIDE-01, GUIDE-02)

---

## Manual-Only Verifications

All phase behaviors have automated verification.

---

## Validation Sign-Off

- [x] All tasks have `<automated>` verify or Wave 0 dependencies
- [x] Sampling continuity: no 3 consecutive tasks without automated verify
- [x] Wave 0 covers all MISSING references
- [x] No watch-mode flags
- [x] Feedback latency < 15s
- [x] `nyquist_compliant: true` set in frontmatter

**Approval:** approved 2026-09-13
