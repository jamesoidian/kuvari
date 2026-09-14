---
status: resolved
date: 2026-09-14
---

# Debug Session: iOS TTS MissingPluginException

## Issue Description
When running Kuvari on iOS (device via TestFlight or iOS simulator), Text-to-Speech failed with:
`flutter: Kuvari TTS MissingPluginException: No implementation found for method speak on channel io.github.jamesoidian.kuvari/tts`

## Root Cause
1. In `ios/Runner/Info.plist`, Kuvari uses `UISceneDelegate` (`FlutterSceneDelegate` in `UIApplicationSceneManifest`).
2. In applications adopting `UISceneDelegate`, the `FlutterEngine` is created implicitly by `FlutterViewController` during scene setup, **after** `UIApplicationDelegate.application(_:didFinishLaunchingWithOptions:)` has finished executing.
3. In `ios/Runner/AppDelegate.swift`, the TTS method channel was being registered inside `application(_:didFinishLaunchingWithOptions:)`. At that moment, the implicit engine did not exist yet, so `self.registrar(forPlugin: "KuvariTts")` returned `nil`.
4. When the implicit engine was subsequently initialized, Flutter called `FlutterImplicitEngineDelegate.didInitializeImplicitFlutterEngine(_ engineBridge:)`.
5. However, `didInitializeImplicitFlutterEngine` only invoked `GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)`, leaving the custom `io.github.jamesoidian.kuvari/tts` channel unregistered on the active engine.

## Fix
In `ios/Runner/AppDelegate.swift`:
1. Extracted TTS channel registration to `setupTtsChannel(binaryMessenger: FlutterBinaryMessenger)`.
2. Hooked channel registration into `didInitializeImplicitFlutterEngine(_ engineBridge:)` using `engineBridge.applicationRegistrar.messenger()`:
   ```swift
   func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
     GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
     setupTtsChannel(binaryMessenger: engineBridge.applicationRegistrar.messenger())
   }
   ```
3. Retained fallback in `application(_:didFinishLaunchingWithOptions:)` for non-scene launch paths.

## Verification
- Built iOS app for simulator (`flutter build ios --simulator --debug`): Build succeeded cleanly in 27.7s.
- Installed and launched on booted iPhone 17 simulator (`xcrun simctl install` / `xcrun simctl launch`).
- All 94 automated unit and widget tests continue to pass (`flutter test`).
