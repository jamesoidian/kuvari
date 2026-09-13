---
phase: 04-native-text-to-speech-ios-android
plan: 02
subsystem: services
tags: [flutter, tts, method-channel, unit-test, cleanup, pubspec]

requires:
  - phase: 04-native-text-to-speech-ios-android
    plan: 01
    provides: Native iOS and Android MethodChannel TTS bridges
provides:
  - Refactored Flutter TtsService communicating directly with io.github.jamesoidian.kuvari/tts MethodChannel
  - Complete removal of flutter_tts package from pubspec.yaml
  - 100% backward-compatible speak() and new stop() API
  - Comprehensive unit test suite in test/services/tts_service_test.dart
  - Updated FakeTtsService test doubles
affects: [tts_service, pubspec, tests]

actuals:
  tokens: 1600
  tasks: 3
  commits: 1

tech-stack:
  added: []
  patterns:
    - Dedicated Flutter MethodChannel communication with native platform handlers
    - MethodChannel test isolation with TestDefaultBinaryMessengerBinding
    - Graceful degradation catching PlatformException and MissingPluginException

key-files:
  created:
    - test/services/tts_service_test.dart
  modified:
    - lib/services/tts_service.dart
    - test/widgets/image_grid_test.dart
    - pubspec.yaml
    - pubspec.lock

key-decisions:
  - "D-01, D-05, TTS-03: Replaced flutter_tts with native MethodChannel('io.github.jamesoidian.kuvari/tts') and removed flutter_tts from pubspec.yaml."
  - "D-01: Maintained 100% backward compatibility for speak(String text, String languageCode, {double? rate, double? pitch}) and added stop()."
  - "D-04: Implemented normalizeLocale() to map fi/sv/se/en language codes to BCP-47 locale tags (fi-FI, sv-SE, en-US)."
  - "Handled PlatformException and MissingPluginException gracefully with logging so UI callers never throw unhandled exceptions."
  - "Updated FakeTtsService in test/widgets/image_grid_test.dart to conform to the new TtsService method signatures."

patterns-established:
  - "Unit tests for platform channels use TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler"

requirements-completed:
  - TTS-01
  - TTS-02
  - TTS-03

duration: 5 min
completed: 2026-09-13
---

# Phase 04 Plan 02 Summary: Flutter TtsService Refactor & Dependency Cleanup

`lib/services/tts_service.dart` has been refactored to communicate directly with the native `io.github.jamesoidian.kuvari/tts` `MethodChannel`, removing the external `flutter_tts` package and build dependencies completely while keeping the API 100% backward-compatible.

## Accomplishments

1. **Refactored `TtsService` (`lib/services/tts_service.dart`)**:
   - Dropped `import 'package:flutter_tts/flutter_tts.dart'`.
   - Wired `MethodChannel('io.github.jamesoidian.kuvari/tts')`.
   - Maintained identical `speak(text, languageCode, {rate, pitch})` signature and added `stop()`.
   - Normalizes language codes: `fi` -> `fi-FI`, `sv`/`se` -> `sv-SE`, `en` -> `en-US`.
   - Safely catches `PlatformException` and `MissingPluginException`.

2. **Unit Test Suite & Mock Updates**:
   - Authored `test/services/tts_service_test.dart` with 9 unit test cases verifying locale normalization, parameter passing, `stop` invocation, and error handling.
   - Updated `FakeTtsService` in `test/widgets/image_grid_test.dart`.

3. **Dependency Cleanup (`pubspec.yaml`)**:
   - Completely removed `flutter_tts: ^4.2.5`.
   - Ran `flutter pub get`.
   - Verified that all 65 tests in the test suite pass.
   - Verified that `flutter analyze` on touched files reports 0 issues.

Commit: `4f5cbe0`
