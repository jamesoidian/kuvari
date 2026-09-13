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

  private func configureAudioSession() {
    do {
      let session = AVAudioSession.sharedInstance()
      try session.setCategory(.playback, mode: .spokenAudio, options: [.duckOthers])
      try session.setActive(true)
    } catch {
      print("Kuvari TTS: Failed to configure AVAudioSession: \(error)")
    }
  }

  private func speak(text: String, language: String, rate: Float?, pitch: Float?) {
    configureAudioSession()

    if speechSynthesizer.isSpeaking {
      speechSynthesizer.stopSpeaking(at: .immediate)
    }

    let utterance = AVSpeechUtterance(string: text)

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

    if let voice = AVSpeechSynthesisVoice(language: bcpLocale) {
      utterance.voice = voice
    } else if let defaultVoice = AVSpeechSynthesisVoice(language: AVSpeechSynthesisVoice.currentLanguageCode()) {
      utterance.voice = defaultVoice
    } else {
      utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
    }

    utterance.rate = rate ?? AVSpeechUtteranceDefaultSpeechRate
    utterance.pitchMultiplier = pitch ?? 1.0

    speechSynthesizer.speak(utterance)
  }

  private func stopSpeaking() {
    if speechSynthesizer.isSpeaking {
      speechSynthesizer.stopSpeaking(at: .immediate)
    }
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
