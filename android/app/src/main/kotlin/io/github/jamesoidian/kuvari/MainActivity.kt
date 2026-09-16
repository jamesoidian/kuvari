package io.github.jamesoidian.kuvari

import android.content.Intent
import android.os.Bundle
import android.provider.Settings
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
    private var triedGoogleEngine = false

    override fun onCreate(savedInstanceState: Bundle?) {
        enableEdgeToEdge()
        super.onCreate(savedInstanceState)
        initTtsEngine()
    }

    private fun initTtsEngine() {
        val googleEngine = "com.google.android.tts"
        val ttsIntent = Intent(TextToSpeech.Engine.INTENT_ACTION_TTS_SERVICE)
        val hasGoogleTts = packageManager.queryIntentServices(ttsIntent, 0)
            .any { it.serviceInfo?.packageName == googleEngine }

        if (hasGoogleTts) {
            triedGoogleEngine = true
            tts = TextToSpeech(this, this, googleEngine)
        } else {
            triedGoogleEngine = false
            tts = TextToSpeech(this, this)
        }
    }

    override fun onInit(status: Int) {
        if (status == TextToSpeech.SUCCESS) {
            isTtsInitialized = true
            tts?.setSpeechRate(1.0f)
            tts?.setPitch(1.0f)
            pendingUtterance?.run()
            pendingUtterance = null
        } else {
            // Fallback to default engine if Google TTS failed to initialize
            if (triedGoogleEngine) {
                triedGoogleEngine = false
                tts?.shutdown()
                tts = TextToSpeech(this, this)
            } else {
                isTtsInitialized = false
                pendingUtterance = null
            }
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
                        speakText(text, language, rate, pitch, result)
                    } else {
                        pendingUtterance = Runnable {
                            speakText(text, language, rate, pitch, result)
                        }
                    }
                }
                "stop" -> {
                    pendingUtterance = null
                    stopSpeaking()
                    result.success(null)
                }
                "openTtsSettings" -> {
                    openTtsSettings(result)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun openTtsSettings(result: MethodChannel.Result) {
        try {
            val intent = Intent("com.android.settings.TTS_SETTINGS")
            intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
            startActivity(intent)
            result.success(true)
        } catch (e: Exception) {
            try {
                val intent = Intent(Settings.ACTION_SETTINGS)
                intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                startActivity(intent)
                result.success(true)
            } catch (e2: Exception) {
                result.error("CANNOT_OPEN_SETTINGS", e2.message, null)
            }
        }
    }

    private fun speakText(text: String, language: String, rate: Float, pitch: Float, result: MethodChannel.Result? = null) {
        val ttsEngine = tts
        if (ttsEngine == null) {
            result?.error("TTS_NOT_INITIALIZED", "TTS engine is null", null)
            return
        }

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
            result?.error(
                "LANGUAGE_NOT_SUPPORTED",
                "Language '$language' is not supported by the active TTS engine.",
                mapOf("language" to language, "missingData" to (langResult == TextToSpeech.LANG_MISSING_DATA))
            )
            return
        }

        ttsEngine.setPitch(pitch)
        ttsEngine.setSpeechRate(rate)

        val utteranceId = "kuvari_${System.currentTimeMillis()}"
        ttsEngine.speak(text, TextToSpeech.QUEUE_FLUSH, null, utteranceId)
        result?.success(null)
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
