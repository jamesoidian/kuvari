---
phase: "2"
slug: "home-guidance-collection-queue"
status: draft
nyquist_compliant: true
wave_0_complete: false
created: "2026-09-13"
---

# Phase 2 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | flutter_test (Flutter SDK) |
| **Config file** | pubspec.yaml |
| **Quick run command** | `flutter test test/widgets/empty_queue_placeholder_test.dart` |
| **Full suite command** | `flutter test` |
| **Estimated runtime** | ~15 seconds |

---

## Sampling Rate

- **After every task commit:** Run quick run command or affected test file
- **After every plan wave:** Run `flutter test`
- **Before `/gsd-verify-work`:** Full suite must be green
- **Max feedback latency:** 15 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Threat Ref | Secure Behavior | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|------------|-----------------|-----------|-------------------|-------------|--------|
| 02-01-01 | 01 | 1 | JONO-01 | — | N/A | unit | `flutter gen-l10n && flutter test test/widgets/empty_queue_placeholder_test.dart` | ❌ W0 | ⬜ pending |
| 02-01-02 | 01 | 1 | JONO-01 | — | N/A | widget | `flutter test test/widgets/empty_queue_placeholder_test.dart` | ❌ W0 | ⬜ pending |
| 02-02-01 | 02 | 2 | JONO-01, JONO-02 | — | N/A | widget | `flutter test test/pages/home_page_test.dart` | ✅ | ⬜ pending |
| 02-02-02 | 02 | 2 | JONO-02 | — | N/A | widget | `flutter test test/pages/home_page_test.dart` | ✅ | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `test/widgets/empty_queue_placeholder_test.dart` — stubs for JONO-01 placeholder widget
- [ ] Existing infrastructure covers all other phase requirements.

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Visual polish & smoothness | JONO-01, JONO-02 | Visual animation smoothness cannot be evaluated solely by headless tests | Run app on simulator/device; pick an image; observe smooth CrossFade and extended FAB appearance |

---

## Validation Sign-Off

- [x] All tasks have `<automated>` verify or Wave 0 dependencies
- [x] Sampling continuity: no 3 consecutive tasks without automated verify
- [x] Wave 0 covers all MISSING references
- [x] No watch-mode flags
- [x] Feedback latency < 15s
- [x] `nyquist_compliant: true` set in frontmatter

**Approval:** pending 2026-09-13
