---
phase: 4
plan: 1
wave: 1
---

# Plan 4.1: Edge Cases & Verification

## Objective
Handle edge cases in TTS playback and perform manual verification.

## Context
- lib/services/tts_service.dart

## Tasks

<task type="auto">
  <name>Handle TTS errors</name>
  <files>lib/services/tts_service.dart</files>
  <action>
    - Import `package:flutter/foundation.dart`.
    - Wrap the `setLanguage` and `speak` calls in a `try/catch` block.
    - In the `catch` block, use `debugPrint('TTS Error: $e');` to log any issues without crashing the app.
  </action>
  <verify>grep -q "try {" lib/services/tts_service.dart</verify>
  <done>try/catch block is present in the speak method.</done>
</task>

<task type="checkpoint:human-verify">
  <name>Manual TTS Verification</name>
  <files></files>
  <action>
    - Run the application (`flutter run`).
    - Navigate to the Home page and ensure images are visible.
    - Tap the speaker icon next to an image name.
    - Confirm that the word is spoken clearly.
    - Change the app language from the AppBar and confirm that the TTS accent/language changes accordingly.
  </action>
  <verify></verify>
  <done>User confirms TTS is working as expected across languages.</done>
</task>

## Success Criteria
- [ ] Error handling is implemented for TTS calls.
- [ ] User has manually verified audio playback and language switching.
