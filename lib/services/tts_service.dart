import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kuvari_app/l10n/app_localizations.dart';

typedef TtsLanguageUnavailableCallback = void Function(String languageCode);

class TtsService {
  @visibleForTesting
  static const MethodChannel defaultChannel =
      MethodChannel('io.github.jamesoidian.kuvari/tts');

  final MethodChannel _channel;
  TtsLanguageUnavailableCallback? onLanguageUnavailable;

  TtsService({
    MethodChannel? channel,
    this.onLanguageUnavailable,
  }) : _channel = channel ?? defaultChannel;

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
      debugPrint('Kuvari TTS PlatformException: ${e.code} - ${e.message}');
      if (e.code == 'LANGUAGE_NOT_SUPPORTED' ||
          e.code == 'LANGUAGE_MISSING_DATA') {
        onLanguageUnavailable?.call(languageCode);
      }
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

  /// Opens the device TTS system settings.
  Future<void> openTtsSettings() async {
    try {
      await _channel.invokeMethod('openTtsSettings');
    } catch (e) {
      debugPrint('Kuvari TTS openTtsSettings Error: $e');
    }
  }

  /// Helper to display a user-friendly SnackBar when TTS lacks language support,
  /// with a direct action button to open settings.
  static void showLanguageUnavailableSnackBar(
    BuildContext context,
    String languageCode, {
    VoidCallback? onOpenSettings,
  }) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return;

    final langName = switch (languageCode.toLowerCase()) {
      'fi' || 'fi-fi' => 'suomi',
      'sv' || 'se' || 'sv-se' => 'svenska',
      _ => 'English',
    };

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.ttsLanguageNotSupported(langName)),
        duration: const Duration(seconds: 6),
        action: SnackBarAction(
          label: l10n.openSettings,
          onPressed: onOpenSettings ?? () => TtsService().openTtsSettings(),
        ),
      ),
    );
  }
}
