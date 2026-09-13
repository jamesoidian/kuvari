# Phase 4 Research Report: Native Text-to-Speech (iOS & Android)

**Phase Goal:** Replace the external `flutter_tts` package with clean, high-reliability native implementations on iOS (`AVSpeechSynthesizer`) and Android (`android.speech.tts.TextToSpeech`) communicating via a dedicated Flutter `MethodChannel`, ensuring zero third-party plugin bloat and 100% backward-compatible speech synthesis for AAC communicators.

---

## 1. User Constraints & Locked Decisions (04-CONTEXT.md)

| Decision | Summary | Details / Implementation Rules |
|:---------|:--------|:-------------------------------|
| **D-01** | **MethodChannel Architecture & API** | Channel name: `io.github.jamesoidian.kuvari/tts`.<br>Two methods:<br>1. `speak`: accepts `{'text': String, 'language': String, 'rate': double?, 'pitch': double?}`. Automatically stops any ongoing speech before starting the new utterance.<br>2. `stop`: immediately halts active speech synthesis. |
| **D-02** | **Speech Rate, Pitch & AAC Clarity** | Natural, clear AAC speech defaults:<br>• **iOS**: `AVSpeechUtteranceDefaultSpeechRate` (standard 0.50), pitch multiplier 1.0.<br>• **Android**: `setSpeechRate(1.0f)`, `setPitch(1.0f)`.<br>Native handlers accept optional override parameters from Flutter when provided. |
| **D-03** | **Audio Interruption & iOS Audio Session** | Immediate interruption upon symbol tap:<br>• **iOS**: `synthesizer.stopSpeaking(at: .immediate)` before starting new utterance.<br>• **Android**: `tts.speak(text, TextToSpeech.QUEUE_FLUSH, null, utteranceId)`.<br>• **iOS Audio Session**: Configure `AVAudioSession` with category `.playback`, mode `.spokenAudio`, and options `[.duckOthers]` so speech plays audibly even when the physical silent/mute switch is engaged. |
| **D-04** | **Supported Languages & Voice Fallback** | Map language codes to BCP-47 locale tags:<br>• `fi` / `fi-FI` → Finnish (`fi-FI`)<br>• `sv` / `se` / `sv-SE` → Swedish (`sv-SE`)<br>• `en` / `en-US` / default → English (`en-US`)<br>If a requested language voice is missing or unsupported on the device, fall back safely to system default or `en-US` without throwing fatal errors. |
| **D-05** | **Dependency Cleanup** | Completely remove `flutter_tts` from `pubspec.yaml`.<br>Refactor `lib/services/tts_service.dart` to use `MethodChannel` directly.<br>Clean `Podfile.lock` and run `flutter pub get`. |

---

## 2. Existing Code Architecture & Callers Analysis

### 2.1 Current `lib/services/tts_service.dart` Implementation
The existing implementation wraps `FlutterTts`:
```dart
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/foundation.dart';

class TtsService {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> speak(String text, String languageCode) async {
    String locale;
    switch (languageCode) {
      case 'fi': locale = 'fi-FI'; break;
      case 'sv':
      case 'se': locale = 'sv-SE'; break;
      case 'en':
      default: locale = 'en-US'; break;
    }
    try {
      await flutterTts.setLanguage(locale);
      await flutterTts.speak(text);
    } catch (e) {
      debugPrint('TTS Error: $e');
    }
  }
}
```

### 2.2 Callers Across the Codebase
Grep analysis across the entire project reveals four locations:
1. **`lib/pages/home_page.dart`**:
   - Line 42: `final TtsService _ttsService = TtsService();`
   - Line 377: passes `_ttsService` to `ImageGrid(..., ttsService: _ttsService)`
2. **`lib/pages/image_viewer_page.dart`**:
   - Line 24: `final TtsService _ttsService = TtsService();`
   - Line 124: `_ttsService.speak(img.name, Localizations.localeOf(context).languageCode);` (in horizontal reel item tap)
   - Line 195: `_ttsService.speak(img.name, Localizations.localeOf(context).languageCode);` (in single image view tap)
3. **`lib/widgets/image_grid.dart`**:
   - Line 13: `final TtsService ttsService;`
   - Line 74: `ttsService.speak(img.name, Localizations.localeOf(context).languageCode);` (in grid item tap)
4. **`test/widgets/image_grid_test.dart`**:
   - Line 12: `class FakeTtsService extends Fake implements TtsService { @override Future<void> speak(String text, String languageCode) async {} }`

### 2.3 Public API Backward Compatibility Requirement
To guarantee **100% backward compatibility** with zero changes required in `home_page.dart`, `image_viewer_page.dart`, and `image_grid.dart`:
- `speak` must accept `(String text, String languageCode, {double? rate, double? pitch})`.
- Positional parameters `(text, languageCode)` remain identical.
- In `test/widgets/image_grid_test.dart`, because `FakeTtsService implements TtsService`, Dart interface conformance requires matching optional named parameters:
  `Future<void> speak(String text, String languageCode, {double? rate, double? pitch}) async {}`.
- Add `Future<void> stop() async` to `TtsService`. Because `FakeTtsService extends Fake`, unimplemented methods fall through to `noSuchMethod` and won't break if omitted, but adding `stop()` completes the public interface.

---

## 3. iOS Native Implementation Details (`AppDelegate.swift`)

### 3.1 Frameworks & Architecture
- Uses `AVFoundation` (`AVSpeechSynthesizer`, `AVSpeechUtterance`, `AVSpeechSynthesisVoice`, `AVAudioSession`).
- Registered in `ios/Runner/AppDelegate.swift`.

### 3.2 MethodChannel Registration
In `AppDelegate.swift`, attach the channel handler after `super.application(...)` initializes the Flutter view controller:
```swift
import Flutter
import UIKit
import AVFoundation

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private let speechSynthesizer = AVSpeechSynthesizer()
  private let ttsChannelName = "io.github.jamesoidian.kuvari/tts"

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let result = super.application(application, didFinishLaunchingWithOptions: launchOptions)
    
    if let controller = window?.rootViewController as? FlutterViewController {
      let ttsChannel = FlutterMethodChannel(name: ttsChannelName, binaryMessenger: controller.binaryMessenger)
      ttsChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
        guard let self = self else { return }
        switch call.method {
        case "speak":
          guard let args = call.arguments as? [String: Any],
                let text = args["text"] as? String else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "text is required", details: nil))
            return
          }
          let language = args["language"] as? String ?? "en-US"
          let rate = (args["rate"] as? NSNumber)?.floatValue
          let pitch = (args["pitch"] as? NSNumber)?.floatValue
          self.speak(text: text, language: language, rate: rate, pitch: pitch)
          result(nil)
        case "stop":
          self.stopSpeaking()
          result(nil)
        default:
          result(FlutterMethodNotImplemented)
        }
      }
    }
    
    return result
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
```

### 3.3 Audio Session Configuration (`AVAudioSession`)
Critical for AAC communicators: speech must play even when the physical silent/mute switch is active!
```swift
private func configureAudioSession() {
  do {
    let session = AVAudioSession.sharedInstance()
    try session.setCategory(.playback, mode: .spokenAudio, options: [.duckOthers])
    try session.setActive(true)
  } catch {
    print("Kuvari TTS: Failed to configure AVAudioSession: \(error)")
  }
}
```

### 3.4 Utterance, Interruption & Language Fallback
```swift
private func speak(text: String, language: String, rate: Float?, pitch: Float?) {
  configureAudioSession()
  
  if speechSynthesizer.isSpeaking {
    speechSynthesizer.stopSpeaking(at: .immediate)
  }
  
  let utterance = AVSpeechUtterance(string: text)
  
  // Language locale mapping
  let bcpLocale: String
  switch language.lowercased() {
  case "fi", "fi-fi":
    bcpLocale = "fi-FI"
  case "sv", "se", "sv-se":
    bcpLocale = "sv-SE"
  case "en", "en-us":
    bcpLocale = "en-US"
  default:
    bcpLocale = language.contains("-") ? language : "en-US"
  }
  
  // Safe voice resolution with fallback
  if let voice = AVSpeechSynthesisVoice(language: bcpLocale) {
    utterance.voice = voice
  } else if let defaultVoice = AVSpeechSynthesisVoice(language: AVSpeechSynthesisVoice.currentLanguageCode()) {
    utterance.voice = defaultVoice
  } else {
    utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
  }
  
  // Rate & pitch (D-02: natural defaults)
  utterance.rate = rate ?? AVSpeechUtteranceDefaultSpeechRate // ~0.50
  utterance.pitchMultiplier = pitch ?? 1.0
  
  speechSynthesizer.speak(utterance)
}

private func stopSpeaking() {
  if speechSynthesizer.isSpeaking {
    speechSynthesizer.stopSpeaking(at: .immediate)
  }
}
```

---

## 4. Android Native Implementation Details (`MainActivity.kt`)

### 4.1 Manifest & Queries
In `android/app/src/main/AndroidManifest.xml`, the package visibility declaration for TTS is already in place:
```xml
<queries>
    <intent>
        <action android:name="android.intent.action.TTS_SERVICE" />
    </intent>
</queries>
```
No additional permissions (e.g. RECORD_AUDIO) are required.

### 4.2 Lifecycle & MethodChannel Implementation
In `android/app/src/main/kotlin/io/github/jamesoidian/kuvari/MainActivity.kt`:
```kotlin
package io.github.jamesoidian.kuvari

import android.os.Bundle
import android.speech.tts.TextToSpeech
import androidx.activity.enableEdgeToEdge
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.Locale

class MainActivity: FlutterFragmentActivity(), TextToSpeech.OnInitListener {
    private var tts: TextToSpeech? = null
    private var isTtsInitialized = false
    private var pendingUtterance: Runnable? = null
    private val channelName = "io.github.jamesoidian.kuvari/tts"

    override fun onCreate(savedInstanceState: Bundle?) {
        enableEdgeToEdge()
        super.onCreate(savedInstanceState)
        tts = TextToSpeech(this, this)
    }

    override fun onInit(status: Int) {
        if (status == TextToSpeech.SUCCESS) {
            isTtsInitialized = true
            tts?.setSpeechRate(1.0f)
            tts?.setPitch(1.0f)
            pendingUtterance?.run()
            pendingUtterance = null
        } else {
            isTtsInitialized = false
            pendingUtterance = null
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName).setMethodCallHandler { call, result ->
            when (call.method) {
                "speak" -> {
                    val text = call.argument<String>("text") ?: ""
                    val language = call.argument<String>("language") ?: "en-US"
                    val rate = (call.argument<Double>("rate"))?.toFloat() ?: 1.0f
                    val pitch = (call.argument<Double>("pitch"))?.toFloat() ?: 1.0f
                    
                    if (isTtsInitialized) {
                        speakText(text, language, rate, pitch)
                    } else {
                        // Queue in case invocation happens during early startup
                        pendingUtterance = Runnable {
                            speakText(text, language, rate, pitch)
                        }
                    }
                    result.success(null)
                }
                "stop" -> {
                    pendingUtterance = null
                    stopSpeaking()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun speakText(text: String, language: String, rate: Float, pitch: Float) {
        val ttsEngine = tts ?: return

        val locale = when (language.lowercase()) {
            "fi", "fi-fi" -> Locale("fi", "FI")
            "sv", "se", "sv-se" -> Locale("sv", "SE")
            "en", "en-us" -> Locale.US
            else -> if (language.contains("-")) {
                val parts = language.split("-")
                Locale(parts[0], parts[1])
            } else {
                Locale(language)
            }
        }

        // Safe language configuration without crashing
        val langResult = ttsEngine.setLanguage(locale)
        if (langResult == TextToSpeech.LANG_MISSING_DATA || langResult == TextToSpeech.LANG_NOT_SUPPORTED) {
            val fallbackResult = ttsEngine.setLanguage(Locale.US)
            if (fallbackResult == TextToSpeech.LANG_MISSING_DATA || fallbackResult == TextToSpeech.LANG_NOT_SUPPORTED) {
                ttsEngine.language = Locale.getDefault()
            }
        }

        ttsEngine.setPitch(pitch)
        ttsEngine.setSpeechRate(rate)

        val utteranceId = "kuvari_${System.currentTimeMillis()}"
        // QUEUE_FLUSH interrupts any active playback immediately
        ttsEngine.speak(text, TextToSpeech.QUEUE_FLUSH, null, utteranceId)
    }

    private fun stopSpeaking() {
        tts?.stop()
    }

    override fun onDestroy() {
        tts?.stop()
        tts?.shutdown()
        tts = null
        isTtsInitialized = false
        pendingUtterance = null
        super.onDestroy()
    }
}
```

---

## 5. Flutter `TtsService` Refactor & Dependency Cleanup

### 5.1 Refactored `lib/services/tts_service.dart`
```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class TtsService {
  @visibleForTesting
  static const MethodChannel defaultChannel = MethodChannel('io.github.jamesoidian.kuvari/tts');

  final MethodChannel _channel;

  TtsService({MethodChannel? channel}) : _channel = channel ?? defaultChannel;

  /// Normalizes language codes ('fi', 'sv', 'se', 'en') to BCP-47 locale tags.
  static String normalizeLocale(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'fi':
      case 'fi-fi':
        return 'fi-FI';
      case 'sv':
      case 'se':
      case 'sv-se':
        return 'sv-SE';
      case 'en':
      case 'en-us':
      default:
        return 'en-US';
    }
  }

  /// Speaks [text] in [languageCode] (e.g. 'fi', 'sv', 'en').
  /// Immediately interrupts any existing speech.
  Future<void> speak(
    String text,
    String languageCode, {
    double? rate,
    double? pitch,
  }) async {
    final locale = normalizeLocale(languageCode);
    try {
      await _channel.invokeMethod('speak', {
        'text': text,
        'language': locale,
        if (rate != null) 'rate': rate,
        if (pitch != null) 'pitch': pitch,
      });
    } on PlatformException catch (e) {
      debugPrint('Kuvari TTS PlatformException: ${e.message}');
    } on MissingPluginException catch (e) {
      debugPrint('Kuvari TTS MissingPluginException: ${e.message}');
    } catch (e) {
      debugPrint('Kuvari TTS Error: $e');
    }
  }

  /// Halts any active speech synthesis immediately.
  Future<void> stop() async {
    try {
      await _channel.invokeMethod('stop');
    } on PlatformException catch (e) {
      debugPrint('Kuvari TTS stop PlatformException: ${e.message}');
    } on MissingPluginException catch (e) {
      debugPrint('Kuvari TTS stop MissingPluginException: ${e.message}');
    } catch (e) {
      debugPrint('Kuvari TTS stop Error: $e');
    }
  }
}
```

### 5.2 `pubspec.yaml` & Podfile Cleanup
1. In `pubspec.yaml`:
   - Remove line 50: `flutter_tts: ^4.2.5`.
2. Run `flutter pub get`.
3. In `ios/`:
   - `ios/Podfile.lock` previously had `flutter_tts` as its sole third-party pod.
   - Run `cd ios && pod install` (or let Flutter auto-clean CocoaPods) to remove `flutter_tts` pod bindings cleanly.

---

## 6. Validation Architecture & Testing

### 6.1 MethodChannel Mocking Strategy
Flutter's standard modern testing pattern uses `TestDefaultBinaryMessengerBinding`:
```dart
TestWidgetsFlutterBinding.ensureInitialized();
final binding = TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

binding.setMockMethodCallHandler(TtsService.defaultChannel, (MethodCall call) async {
  // Inspect call.method and call.arguments, return null or throw PlatformException
});
```

### 6.2 Unit Test Plan (`test/services/tts_service_test.dart`)
1. **`speak` invokes channel with normalized parameters**:
   - Verify `call.method == 'speak'`.
   - Verify `call.arguments['text'] == 'kissa'`.
   - Verify `call.arguments['language'] == 'fi-FI'`.
2. **Language Code Normalization**:
   - `'fi'` → `'fi-FI'`
   - `'sv'` → `'sv-SE'`
   - `'se'` → `'sv-SE'`
   - `'en'` → `'en-US'`
   - `'unknown'` / fallback → `'en-US'`
3. **Optional Parameters Forwarding**:
   - When `rate: 0.8` and `pitch: 1.2` are provided, verify they are present in channel arguments.
   - When omitted, verify `rate` and `pitch` keys are absent.
4. **`stop` invokes channel**:
   - Verify `call.method == 'stop'`.
5. **Error Handling / Graceful Degradation**:
   - When channel throws `PlatformException`, `speak` and `stop` catch it and log without throwing unhandled exceptions.
   - When channel throws `MissingPluginException` (e.g. unhandled platform), `speak` and `stop` catch it safely.

### 6.3 Regression Verification Plan
1. **Widget Test Compatibility**:
   - Update `FakeTtsService` in `test/widgets/image_grid_test.dart` to match `speak(String text, String languageCode, {double? rate, double? pitch})`.
   - Run `flutter test test/widgets/image_grid_test.dart`.
2. **Full Project Test Suite**:
   - Run `flutter test` (all 56+ tests must pass).
3. **Static Analysis**:
   - Run `flutter analyze` (0 errors, 0 warnings).
4. **Native Compilation Checks**:
   - iOS: Dry-run / compile check with Xcode/simulator if available.
   - Android: Gradle compile check (`./gradlew compileDebugSources` or `flutter build apk --debug`).

---

## 7. Recommendations for Phase 4 Planning

1. **Split into 2 focused plans**:
   - **Plan 04-01**: Native TTS Implementation (iOS `AppDelegate.swift` + Android `MainActivity.kt`).
   - **Plan 04-02**: Flutter `TtsService` Refactor, `pubspec.yaml` dependency removal, unit tests (`test/services/tts_service_test.dart`), and regression test suite run.
2. **Zero Breaking Changes**: Retaining `speak(String text, String languageCode)` guarantees that none of the UI widgets (`HomePage`, `ImageViewerPage`, `ImageGrid`) require modification.
3. **Silent Switch Resilience**: Confirming `AVAudioSession` category `.playback` with `mode: .spokenAudio` on iOS ensures AAC accessibility even on silenced devices.
