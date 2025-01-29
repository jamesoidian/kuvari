// test/services/kuvari_service_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:kuvari_app/models/kuvari_image.dart';
import 'package:kuvari_app/services/kuvari_service.dart';
import 'dart:convert';

// Määrittele mock-objekti
@GenerateMocks([http.Client])
import 'kuvari_service_test.mocks.dart';

void main() {
  group('KuvariService Test', () {
    late KuvariService KuvariService;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      KuvariService = KuvariService(client: mockClient);
    });

    test('returns a list of KuvariImage if the http call completes successfully', () async {
      final mockResponse = {
        'images': [
          {
            'author': 'John Doe',
            'name': 'Sunset',
            'thumb': 'https://example.com/thumb/sunset.png',
            'url': 'https://example.com/images/sunset.png',
            'uid': 101,
          },
          {
            'author': 'Jane Smith',
            'name': 'Mountain',
            'thumb': 'https://example.com/thumb/mountain.png',
            'url': 'https://example.com/images/mountain.png',
            'uid': 102,
          },
        ]
      };

      // Määritä mock-asiakas palauttamaan onnistunut vastaus
      when(mockClient.get(Uri.parse('https://kuvari.papunet.net/api/search/all/test?lang=fi')))
          .thenAnswer((_) async => http.Response(json.encode(mockResponse), 200));

      final images = await KuvariService.searchImages('test');

      expect(images, isA<List<KuvariImage>>());
      expect(images.length, 2);
      expect(images[0].author, 'John Doe');
      expect(images[1].uid, 102);
    });

    test('throws an exception if the http call completes with an error', () async {
      // Määritä mock-asiakas palauttamaan virheellinen vastaus
      when(mockClient.get(Uri.parse('https://kuvari.papunet.net/api/search/all/test?lang=fi')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(KuvariService.searchImages('test'), throwsException);
    });

    test('returns empty list if images key is missing in response', () async {
      final mockResponse = {
        // 'images' avain puuttuu
      };

      // Määritä mock-asiakas palauttamaan onnistunut vastaus ilman 'images' avainta
      when(mockClient.get(Uri.parse('https://kuvari.papunet.net/api/search/all/test?lang=fi')))
          .thenAnswer((_) async => http.Response(json.encode(mockResponse), 200));

      final images = await KuvariService.searchImages('test');

      expect(images, isA<List<KuvariImage>>());
      expect(images.length, 0);
    });

    test('handles malformed JSON gracefully', () async {
      final mockResponse = 'Invalid JSON';

      // Määritä mock-asiakas palauttamaan epäkelpo JSON
      when(mockClient.get(Uri.parse('https://kuvari.papunet.net/api/search/all/test?lang=fi')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      expect(KuvariService.searchImages('test'), throwsException);
    });
  });
}
