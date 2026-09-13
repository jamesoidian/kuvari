import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kuvari_app/services/tts_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TtsService Unit Tests', () {
    late TtsService ttsService;
    late List<MethodCall> methodCalls;
    bool shouldThrowPlatformException = false;
    bool shouldThrowMissingPluginException = false;

    setUp(() {
      methodCalls = <MethodCall>[];
      shouldThrowPlatformException = false;
      shouldThrowMissingPluginException = false;

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(TtsService.defaultChannel,
              (MethodCall methodCall) async {
        methodCalls.add(methodCall);

        if (shouldThrowPlatformException) {
          throw PlatformException(
              code: 'TTS_ERROR', message: 'Simulated TTS failure');
        }
        if (shouldThrowMissingPluginException) {
          throw MissingPluginException('No channel implementation');
        }
        return null;
      });

      ttsService = TtsService();
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(TtsService.defaultChannel, null);
    });

    test('normalizeLocale returns correct BCP-47 locale tags', () {
      expect(TtsService.normalizeLocale('fi'), equals('fi-FI'));
      expect(TtsService.normalizeLocale('fi-FI'), equals('fi-FI'));
      expect(TtsService.normalizeLocale('sv'), equals('sv-SE'));
      expect(TtsService.normalizeLocale('se'), equals('sv-SE'));
      expect(TtsService.normalizeLocale('sv-SE'), equals('sv-SE'));
      expect(TtsService.normalizeLocale('en'), equals('en-US'));
      expect(TtsService.normalizeLocale('en-US'), equals('en-US'));
      expect(TtsService.normalizeLocale('de'), equals('en-US'));
    });

    test('speak sends correct method and arguments for Finnish', () async {
      await ttsService.speak('kissa', 'fi');

      expect(methodCalls.length, equals(1));
      expect(methodCalls.first.method, equals('speak'));
      expect(
        methodCalls.first.arguments,
        equals({
          'text': 'kissa',
          'language': 'fi-FI',
        }),
      );
    });

    test('speak normalizes Swedish codes (sv and se) to sv-SE', () async {
      await ttsService.speak('katt', 'sv');
      await ttsService.speak('hund', 'se');

      expect(methodCalls.length, equals(2));
      expect(methodCalls[0].arguments['language'], equals('sv-SE'));
      expect(methodCalls[1].arguments['language'], equals('sv-SE'));
    });

    test('speak forwards optional rate and pitch when provided', () async {
      await ttsService.speak(
        'hello',
        'en',
        rate: 0.8,
        pitch: 1.2,
      );

      expect(methodCalls.length, equals(1));
      expect(
        methodCalls.first.arguments,
        equals({
          'text': 'hello',
          'language': 'en-US',
          'rate': 0.8,
          'pitch': 1.2,
        }),
      );
    });

    test('stop invokes stop method on channel', () async {
      await ttsService.stop();

      expect(methodCalls.length, equals(1));
      expect(methodCalls.first.method, equals('stop'));
      expect(methodCalls.first.arguments, isNull);
    });

    test('speak catches PlatformException gracefully without rethrowing',
        () async {
      shouldThrowPlatformException = true;
      expect(() async => await ttsService.speak('test', 'fi'), returnsNormally);
    });

    test('speak catches MissingPluginException gracefully without rethrowing',
        () async {
      shouldThrowMissingPluginException = true;
      expect(() async => await ttsService.speak('test', 'fi'), returnsNormally);
    });

    test('stop catches PlatformException gracefully without rethrowing',
        () async {
      shouldThrowPlatformException = true;
      expect(() async => await ttsService.stop(), returnsNormally);
    });

    test('stop catches MissingPluginException gracefully without rethrowing',
        () async {
      shouldThrowMissingPluginException = true;
      expect(() async => await ttsService.stop(), returnsNormally);
    });
  });
}
