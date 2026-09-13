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
