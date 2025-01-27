// test/services/kuha_service_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:kuha_app/models/kuha_image.dart';
import 'package:kuha_app/services/kuha_service.dart';
import 'dart:convert';

// Määrittele mock-objekti
@GenerateMocks([http.Client])
import 'kuha_service_test.mocks.dart';

void main() {
  group('KuhaService Test', () {
    late KuhaService kuhaService;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      kuhaService = KuhaService(client: mockClient);
    });

    test('returns a list of KuhaImage if the http call completes successfully', () async {
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
      when(mockClient.get(Uri.parse('https://kuha.papunet.net/api/search/all/test?lang=fi')))
          .thenAnswer((_) async => http.Response(json.encode(mockResponse), 200));

      final images = await kuhaService.searchImages('test');

      expect(images, isA<List<KuhaImage>>());
      expect(images.length, 2);
      expect(images[0].author, 'John Doe');
      expect(images[1].uid, 102);
    });

    test('throws an exception if the http call completes with an error', () async {
      // Määritä mock-asiakas palauttamaan virheellinen vastaus
      when(mockClient.get(Uri.parse('https://kuha.papunet.net/api/search/all/test?lang=fi')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(kuhaService.searchImages('test'), throwsException);
    });

    test('returns empty list if images key is missing in response', () async {
      final mockResponse = {
        // 'images' avain puuttuu
      };

      // Määritä mock-asiakas palauttamaan onnistunut vastaus ilman 'images' avainta
      when(mockClient.get(Uri.parse('https://kuha.papunet.net/api/search/all/test?lang=fi')))
          .thenAnswer((_) async => http.Response(json.encode(mockResponse), 200));

      final images = await kuhaService.searchImages('test');

      expect(images, isA<List<KuhaImage>>());
      expect(images.length, 0);
    });

    test('handles malformed JSON gracefully', () async {
      final mockResponse = 'Invalid JSON';

      // Määritä mock-asiakas palauttamaan epäkelpo JSON
      when(mockClient.get(Uri.parse('https://kuha.papunet.net/api/search/all/test?lang=fi')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      expect(kuhaService.searchImages('test'), throwsException);
    });
  });
}
