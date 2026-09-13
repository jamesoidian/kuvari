import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class TtsService {
  @visibleForTesting
  static const MethodChannel defaultChannel =
      MethodChannel('io.github.jamesoidian.kuvari/tts');

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
