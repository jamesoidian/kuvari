---
quick_task: 260916-android-tts-engine-fallback
status: complete
completed_date: "2026-09-16"
files_modified:
  - android/app/src/main/kotlin/io/github/jamesoidian/kuvari/MainActivity.kt
  - ios/Runner/AppDelegate.swift
  - lib/l10n/intl_fi.arb
  - lib/l10n/intl_sv.arb
  - lib/l10n/intl_en.arb
  - lib/services/tts_service.dart
  - lib/pages/home_page.dart
  - lib/pages/image_viewer_page.dart
  - test/services/tts_service_test.dart
---

# Quick Task Summary: Prefer Google TTS Engine on Android & Guard Missing Language Support

## Overview
Addressed an issue observed on devices (such as Samsung Galaxy devices running older Android versions) where the system default TTS engine (e.g. Samsung TTS / `com.samsung.SMT`) lacks Finnish and Swedish speech synthesis data. The app now proactively detects and initializes Google Speech Services (`com.google.android.tts`) when available, and displays an actionable SnackBar with a direct shortcut to system Text-to-Speech settings when a language is unsupported or missing.

## Key Changes
1. **Android Native (`MainActivity.kt`)**:
   - `initTtsEngine()` queries available TTS service intents; prefers `com.google.android.tts` if installed, falling back to system default.
   - Fallback in `onInit` to default engine if initializing with Google TTS fails.
   - In `speakText`, checks `setLanguage(locale)`: if it returns `LANG_MISSING_DATA` or `LANG_NOT_SUPPORTED`, returns `result.error("LANGUAGE_NOT_SUPPORTED", ...)`.
   - Added `openTtsSettings` channel handler launching `com.android.settings.TTS_SETTINGS` (with fallback to `ACTION_SETTINGS`).
2. **iOS Native (`AppDelegate.swift`)**:
   - Added `openTtsSettings` channel handler opening `UIApplication.openSettingsURLString`.
3. **Localization (`intl_fi.arb`, `intl_sv.arb`, `intl_en.arb`)**:
   - Added localized messages for `ttsLanguageNotSupported(language)` and action button `openSettings`.
4. **Flutter Service & UI (`TtsService`, `HomePage`, `ImageViewerPage`)**:
   - `TtsService` introduces `onLanguageUnavailable` callback and `showLanguageUnavailableSnackBar(...)`.
   - Added `openTtsSettings()` method on `TtsService`.
   - Connected `onLanguageUnavailable` in `HomePage` and `ImageViewerPage` to guide users directly to TTS settings.
5. **Quality & Lints**:
   - Cleaned up analyzer warnings and infos across `dialog_service.dart`, `tag_management_dialog.dart`, `home_page.dart`, `analytics_service.dart`, and `smoke_test.dart`.

## Verification
- `JAVA_HOME="..." ./android/gradlew -p android compileDebugKotlin`: BUILD SUCCESSFUL (0 errors).
- `flutter analyze`: No issues found!
- `flutter test`: 98/98 tests passed.
