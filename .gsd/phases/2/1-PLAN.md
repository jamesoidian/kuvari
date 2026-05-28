---
phase: 2
plan: 1
wave: 1
---

# Plan 2.1: TTS Service

## Objective
Create a `TtsService` to initialize TTS and handle language selection.

## Context
- .gsd/SPEC.md
- lib/services/tts_service.dart (new file)
- lib/main.dart

## Tasks

<task type="auto">
  <name>Create TtsService class</name>
  <files>lib/services/tts_service.dart</files>
  <action>
    - Create a new file `lib/services/tts_service.dart`.
    - Implement a `TtsService` class with a `FlutterTts` instance (`final FlutterTts flutterTts = FlutterTts();`).
    - Implement a method `Future<void> speak(String text, String languageCode)`.
    - In the `speak` method, map languageCode ('fi', 'sv', 'en') to TTS locales ('fi-FI', 'sv-SE', 'en-US' respectively), call `await flutterTts.setLanguage(locale)`, and then call `await flutterTts.speak(text)`.
    - Make sure to import `package:flutter_tts/flutter_tts.dart`.
  </action>
  <verify>grep -q "class TtsService" lib/services/tts_service.dart</verify>
  <done>TtsService class exists and has a speak method that takes text and language code.</done>
</task>

## Success Criteria
- [ ] `TtsService` is created.
- [ ] Service maps app language codes to TTS locales correctly.
- [ ] The `speak` method can be called to trigger text-to-speech.
