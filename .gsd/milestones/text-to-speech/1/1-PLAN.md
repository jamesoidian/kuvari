---
phase: 1
plan: 1
wave: 1
---

# Plan 1.1: Setup & Configuration

## Objective
Add the `flutter_tts` package and update platform configurations to support text-to-speech.

## Context
- .gsd/SPEC.md
- pubspec.yaml
- android/app/src/main/AndroidManifest.xml

## Tasks

<task type="auto">
  <name>Add flutter_tts dependency</name>
  <files>pubspec.yaml</files>
  <action>
    - Run `flutter pub add flutter_tts` to add the dependency to pubspec.yaml.
  </action>
  <verify>grep -q "flutter_tts" pubspec.yaml</verify>
  <done>flutter_tts is listed in pubspec.yaml.</done>
</task>

<task type="auto">
  <name>Update Android Manifest for TTS</name>
  <files>android/app/src/main/AndroidManifest.xml</files>
  <action>
    - Add an intent query for `android.intent.action.TTS_SERVICE` inside the existing `<queries>` block.
    - Ensure it is structured as:
      `<intent><action android:name="android.intent.action.TTS_SERVICE" /></intent>`
  </action>
  <verify>grep -q "android.intent.action.TTS_SERVICE" android/app/src/main/AndroidManifest.xml</verify>
  <done>The TTS_SERVICE intent query is present in AndroidManifest.xml.</done>
</task>

## Success Criteria
- [ ] flutter_tts package is installed and verifiable in pubspec.yaml.
- [ ] Android application is correctly configured to query the TTS service for Android 11+.
