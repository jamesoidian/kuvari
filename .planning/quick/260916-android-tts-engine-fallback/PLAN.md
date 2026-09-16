---
quick_task: 260916-android-tts-engine-fallback
title: Prefer Google TTS engine on Android and guard missing language support
files_modified:
  - android/app/src/main/kotlin/io/github/jamesoidian/kuvari/MainActivity.kt
  - lib/services/tts_service.dart
  - lib/l10n/intl_fi.arb
  - lib/l10n/intl_sv.arb
  - lib/l10n/intl_en.arb
  - lib/pages/image_viewer_page.dart
  - lib/widgets/image_grid.dart
  - test/services/tts_service_test.dart
---

# Quick Task: Prefer Google TTS Engine on Android and Guard Missing Language Support

<objective>
Ensure Android devices (especially Samsung devices with default Samsung SMT engine) reliably use Google Speech Services (`com.google.android.tts`) when available for Finnish and Swedish symbol speech, and provide clear user guidance with direct settings navigation if a requested language is unsupported or missing voice data.
</objective>

<tasks>

<task type="auto">
  <name>Task 1: Android Native Google TTS Preference & Settings Intent</name>
  <files>
    android/app/src/main/kotlin/io/github/jamesoidian/kuvari/MainActivity.kt
  </files>
  <action>
    1. In `MainActivity.kt`:
       - Query installed TTS engines using `packageManager.queryIntentServices(Intent(TextToSpeech.Engine.INTENT_ACTION_TTS_SERVICE), 0)`.
       - If `com.google.android.tts` is installed, initialize `TextToSpeech(this, this, "com.google.android.tts")`.
       - If initialization with Google TTS fails or it is not installed, fall back to default `TextToSpeech(this, this)`.
       - In `speakText`: if `setLanguage(locale)` returns `LANG_MISSING_DATA` or `LANG_NOT_SUPPORTED`, return a PlatformException with error code `LANGUAGE_NOT_SUPPORTED` instead of falling back to English.
       - Add MethodChannel handler for `"openTtsSettings"` that launches `Intent("com.android.settings.TTS_SETTINGS")` (with fallback to `Settings.ACTION_SETTINGS`).
  </action>
  <verify>
    ./gradlew assembleDebug or flutter build apk --config-only
  </verify>
  <done>
    Android native implementation prefers Google TTS, handles missing languages cleanly, and can open TTS settings.
  </done>
</task>

<task type="auto">
  <name>Task 2: TtsService Error Handling, Settings Navigation & Localization</name>
  <files>
    lib/services/tts_service.dart
    lib/l10n/intl_fi.arb
    lib/l10n/intl_sv.arb
    lib/l10n/intl_en.arb
    lib/widgets/image_grid.dart
    lib/pages/image_viewer_page.dart
  </files>
  <action>
    1. Add localization strings across FI, SV, and EN:
       - `ttsLanguageNotSupported(String language)`
       - `openSettings`
    2. In `TtsService`:
       - Add `openTtsSettings()` calling method `openTtsSettings`.
       - Add a notification mechanism (e.g. `onLanguageUnavailable` callback or `ValueNotifier<String?> languageUnavailableNotifier`) when `LANGUAGE_NOT_SUPPORTED` occurs.
       - Add helper `showLanguageUnavailableSnackBar(BuildContext context, String languageCode)` to display an actionable SnackBar prompting the user to open settings.
    3. In `image_grid.dart` and `image_viewer_page.dart`:
       - Handle or listen for language unavailable events to show the helpful SnackBar with the "Asetukset" action.
  </action>
  <verify>
    flutter test
  </verify>
  <done>
    Flutter UI displays localized guidance with an action button to open TTS settings when language support is missing.
  </done>
</task>

<task type="auto">
  <name>Task 3: Unit Tests & Verification</name>
  <files>
    test/services/tts_service_test.dart
  </files>
  <action>
    1. In `test/services/tts_service_test.dart`:
       - Add unit test for `openTtsSettings()`.
       - Add unit test verifying `onLanguageUnavailable` triggers when `LANGUAGE_NOT_SUPPORTED` PlatformException is encountered.
    2. Run the entire test suite `flutter test`.
  </action>
  <verify>
    flutter test
  </verify>
  <done>
    All tests pass without regressions.
  </done>
</task>

</tasks>
