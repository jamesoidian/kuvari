# Phase 4: Native Text-to-Speech (iOS & Android) - Context

**Gathered:** 2026-09-13
**Status:** Ready for planning

<domain>
## Phase Boundary

Replace the external `flutter_tts` package with clean, native platform implementations on iOS (`AVSpeechSynthesizer`) and Android (`android.speech.tts.TextToSpeech`), communicating over a lightweight Flutter `MethodChannel` (`TTS-01`, `TTS-02`, `TTS-03`).
Remove `flutter_tts` dependency from `pubspec.yaml`, simplifying native builds and eliminating third-party Pod/Gradle plugin issues while ensuring high-reliability speech synthesis for AAC communicators.

</domain>

<decisions>
## Implementation Decisions

### MethodChannel Architecture & API
- **D-01:** Implement a dedicated Flutter `MethodChannel` with channel name `io.github.jamesoidian.kuvari/tts`.
  Expose two core methods:
  1. `speak`: accepts `{'text': String, 'language': String, 'rate': double?, 'pitch': double?}`. Automatically stops any ongoing speech before starting the new utterance.
  2. `stop`: immediately halts any active speech synthesis.
  — **Reversibility:** reversible

### Speech Rate, Pitch & AAC Clarity
- **D-02:** Use natural, clear AAC speech rates:
  - iOS: `AVSpeechUtteranceDefaultSpeechRate` (or standard 0.50), pitch 1.0.
  - Android: `setSpeechRate(1.0f)`, `setPitch(1.0f)`.
  - Natiivikoodi accepts optional override parameters from Flutter if passed.
  — **Reversibility:** reversible

### Audio Interruption & iOS Audio Session
- **D-03:** When a user taps a symbol, any previous utterance is interrupted immediately:
  - iOS: `synthesizer.stopSpeaking(at: .immediate)`
  - Android: `tts.speak(text, TextToSpeech.QUEUE_FLUSH, null, utteranceId)`
  - On iOS, configure `AVAudioSession` with category `.playback` (and options `.duckOthers`) so AAC speech output plays audibly even when the physical mute/silent switch is turned on.
  — **Reversibility:** reversible

### Supported Languages & Voice Fallback
- **D-04:** Map language codes to BCP-47 locale tags:
  - `fi` / `fi-FI` -> Finnish (`fi-FI`)
  - `sv` / `se` / `sv-SE` -> Swedish (`sv-SE`)
  - `en` / `en-US` / default -> English (`en-US`)
  If a requested language voice is missing or unsupported on the device, fall back safely to the system default voice or `en-US` without throwing fatal errors.
  — **Reversibility:** reversible

### Dependency Cleanup
- **D-05:** Completely remove `flutter_tts` from `pubspec.yaml` dependencies.
  - Update `lib/services/tts_service.dart` to use `MethodChannel` directly with zero third-party plugin imports.
  - Clean `Podfile.lock` and run `flutter pub get`.
  — **Reversibility:** reversible

### the agent's Discretion
- Exact iOS Swift helper class structure (e.g. extending `FlutterAppDelegate` or separate `TtsPlugin` / handler class in `ios/Runner/AppDelegate.swift`).
- Exact Android Kotlin helper structure in `MainActivity.kt`.
- Unit test mocking pattern for `MethodChannel` in Dart tests.

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Requirements & Roadmap
- `.planning/ROADMAP.md` §Phase 4 — Phase goal, requirements (`TTS-01`, `TTS-02`, `TTS-03`), success criteria
- `.planning/REQUIREMENTS.md` §Native Text-to-Speech — Requirement IDs and verification mapping

### Existing Native Entrypoints
- `ios/Runner/AppDelegate.swift` — iOS Flutter app delegate entry point
- `android/app/src/main/kotlin/io/github/jamesoidian/kuvari/MainActivity.kt` — Android Flutter activity entry point
- `lib/services/tts_service.dart` — Existing Flutter TTS service wrapper

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- `lib/services/tts_service.dart`: Already called by `HomePage`, `ImageViewerPage`, and `ImageGrid`. The public interface `Future<void> speak(String text, String languageCode)` and `stop()` can be preserved so no call sites need rewriting!

### Established Patterns
- `FlutterMethodChannel` in iOS Swift and `MethodChannel` in Android Kotlin.
- Clean platform error handling returning `result(nil)` or `result(FlutterError)`.

### Integration Points
- `ios/Runner/AppDelegate.swift`: Setup `FlutterMethodChannel` and `AVSpeechSynthesizer`.
- `android/app/src/main/kotlin/io/github/jamesoidian/kuvari/MainActivity.kt`: Setup `MethodChannel` and `android.speech.tts.TextToSpeech`.
- `lib/services/tts_service.dart`: Replace `flutter_tts` with `const MethodChannel('io.github.jamesoidian.kuvari/tts')`.
- `pubspec.yaml`: Remove `flutter_tts: ^4.2.5`.
- `test/services/tts_service_test.dart`: Unit test `TtsService` with `TestDefaultBinaryMessengerBinding`.

</code_context>

<specifics>
## Specific Ideas

- Keeping `TtsService` API signature identical avoids touching `home_page.dart`, `image_viewer_page.dart`, or `image_grid.dart`.
- Configuring `AVAudioSession.sharedInstance().setCategory(.playback)` on iOS is critical for AAC users who might have their device on silent mode.
- In Android, initialize `TextToSpeech` in `onCreate` / `configureFlutterEngine` and shutdown in `onDestroy`.

</specifics>

<deferred>
## Deferred Ideas

- None — discussion stayed strictly within Phase 4 scope.

</deferred>

---

*Phase: 04-native-text-to-speech-ios-android*
*Context gathered: 2026-09-13*
