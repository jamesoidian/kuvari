import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/foundation.dart';

class TtsService {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> speak(String text, String languageCode) async {
    String locale;
    switch (languageCode) {
      case 'fi':
        locale = 'fi-FI';
        break;
      case 'sv':
      case 'se': // Sometimes 'se' is used in the app for Swedish API requests
        locale = 'sv-SE';
        break;
      case 'en':
      default:
        locale = 'en-US';
        break;
    }

    try {
      await flutterTts.setLanguage(locale);
      await flutterTts.speak(text);
    } catch (e) {
      debugPrint('TTS Error: $e');
    }
  }
}
