---
phase: "04"
slug: "native-text-to-speech-ios-android"
status: draft
nyquist_compliant: true
wave_0_complete: false
created: "2026-09-13"
---

# Phase 04 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | Flutter Test / Dart test framework |
| **Config file** | `pubspec.yaml` |
| **Quick run command** | `flutter test test/services/tts_service_test.dart` |
| **Full suite command** | `flutter test` |
| **Estimated runtime** | ~10 seconds |

---

## Sampling Rate

- **After every task commit:** Run `flutter test test/services/tts_service_test.dart` (or `flutter test test/widgets/image_grid_test.dart`)
- **After every plan wave:** Run `flutter test`
- **Before `/gsd-verify-work`:** Full suite must be green (56+ tests passing)
- **Max feedback latency:** 15 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Threat Ref | Secure Behavior | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|------------|-----------------|-----------|-------------------|-------------|--------|
| 04-01-01 | 01 | 1 | TTS-01 | — | N/A | static / unit | `flutter analyze lib/services/tts_service.dart` | ✅ | ⬜ pending |
| 04-01-02 | 01 | 1 | TTS-02 | — | N/A | static / unit | `flutter analyze lib/services/tts_service.dart` | ✅ | ⬜ pending |
| 04-02-01 | 02 | 2 | TTS-01, TTS-02 | — | Graceful exception catch | unit | `flutter test test/services/tts_service_test.dart` | ❌ W0 | ⬜ pending |
| 04-02-02 | 02 | 2 | TTS-03 | — | N/A | unit / regression | `flutter pub get && flutter test` | ✅ | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `test/services/tts_service_test.dart` — comprehensive unit test suite mocking `io.github.jamesoidian.kuvari/tts` MethodChannel with `TestDefaultBinaryMessengerBinding`

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Real device audio playback on iOS with silent switch ON | TTS-01 | Physical hardware switch & audio session routing | Run on physical iOS device, turn mute switch on, tap symbols, verify audible speech output |
| Real device audio playback on Android | TTS-02 | Physical Android TTS engine voice availability | Run on Android device/emulator, tap symbols across fi/sv/en, verify spoken audio |

---

## Validation Sign-Off

- [x] All tasks have `<automated>` verify or Wave 0 dependencies
- [x] Sampling continuity: no 3 consecutive tasks without automated verify
- [x] Wave 0 covers all MISSING references
- [x] No watch-mode flags
- [x] Feedback latency < 15s
- [x] `nyquist_compliant: true` set in frontmatter

**Approval:** pending 2026-09-13
