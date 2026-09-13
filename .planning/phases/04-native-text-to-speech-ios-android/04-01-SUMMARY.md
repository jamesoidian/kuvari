---
phase: 04-native-text-to-speech-ios-android
plan: 01
subsystem: native-platform
tags: [ios, android, tts, swift, kotlin, method-channel, avspeechsynthesizer, texttospeech]

requires:
  - phase: 03-practical-aac-guidance-info
    provides: Practical AAC guidance and InfoPage
provides:
  - Native iOS AVSpeechSynthesizer TTS bridge on MethodChannel io.github.jamesoidian.kuvari/tts
  - Native iOS AVAudioSession playback configuration with duckOthers for audible speech on silent mode
  - Native Android TextToSpeech TTS bridge on MethodChannel io.github.jamesoidian.kuvari/tts
  - Safe language fallback (fi-FI, sv-SE, en-US) on both platforms
  - Immediate audio interruption on symbol selection via stopSpeaking(at: .immediate) and QUEUE_FLUSH
affects: [ios, android, native-bridge]

actuals:
  tokens: 1500
  tasks: 2
  commits: 1

tech-stack:
  added: []
  patterns:
    - Native FlutterMethodChannel registration on AppDelegate.swift and MainActivity.kt
    - AVAudioSession .playback mode .spokenAudio with .duckOthers for mute-switch override
    - Android TextToSpeech.OnInitListener with pending utterance queue and QUEUE_FLUSH interruption

key-files:
  created: []
  modified:
    - ios/Runner/AppDelegate.swift
    - android/app/src/main/kotlin/io/github/jamesoidian/kuvari/MainActivity.kt

key-decisions:
  - "D-01, TTS-01: Registered FlutterMethodChannel('io.github.jamesoidian.kuvari/tts') on iOS AppDelegate with speak and stop handlers."
  - "D-02, D-03: Used AVSpeechUtteranceDefaultSpeechRate and pitch 1.0 on iOS, immediately interrupting ongoing speech via stopSpeaking(at: .immediate)."
  - "D-03: Configured AVAudioSession with .playback category and .duckOthers option so speech plays audibly even when the physical silent switch is engaged."
  - "D-04: Implemented safe voice resolution on iOS with fallback to currentLanguageCode() or en-US without crashing."
  - "D-01, TTS-02: Registered MethodChannel('io.github.jamesoidian.kuvari/tts') on Android MainActivity implementing OnInitListener."
  - "D-02, D-03: Used TextToSpeech.QUEUE_FLUSH for immediate interruption and 1.0f natural pitch/rate defaults on Android."
  - "D-04: Implemented Android Locale resolution with fallback for LANG_MISSING_DATA / LANG_NOT_SUPPORTED."
  - "Safely shut down Android TextToSpeech in onDestroy() to prevent memory leaks."

patterns-established:
  - "Native platform bridges communicate over io.github.jamesoidian.kuvari/<feature> MethodChannels"
  - "AAC speech synthesis interrupts active speech immediately to support rapid symbol tapping"

requirements-completed:
  - TTS-01
  - TTS-02

duration: 5 min
completed: 2026-09-13
---

# Phase 04 Plan 01 Summary: Native TTS Implementations (iOS & Android)

Native Text-to-Speech handlers have been implemented on both iOS (`AppDelegate.swift`) and Android (`MainActivity.kt`) communicating via the dedicated Flutter `MethodChannel` (`io.github.jamesoidian.kuvari/tts`).

## Key Implementations

1. **iOS (`AppDelegate.swift`)**:
   - Registered `FlutterMethodChannel(name: "io.github.jamesoidian.kuvari/tts", binaryMessenger: controller.binaryMessenger)`.
   - Configured `AVAudioSession` with category `.playback`, mode `.spokenAudio`, and options `[.duckOthers]`, ensuring speech remains clearly audible even when the device silent switch is enabled.
   - Configured `AVSpeechSynthesizer` with immediate speech interruption (`stopSpeaking(at: .immediate)`), natural speech rate defaults, and graceful voice fallback for missing locales.

2. **Android (`MainActivity.kt`)**:
   - Registered `MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "io.github.jamesoidian.kuvari/tts")`.
   - Implemented `TextToSpeech.OnInitListener` with safe early-invocation queueing.
   - Used `TextToSpeech.QUEUE_FLUSH` for instant speech interruption upon symbol tap.
   - Handled `LANG_MISSING_DATA` and `LANG_NOT_SUPPORTED` with fallback to `Locale.US` and `Locale.getDefault()`.
   - Properly cleaned up and shut down TTS resources in `onDestroy()`.

## Verification

Both native files verified for channel name and native TTS classes.
Commit: `f6bbbb6`
