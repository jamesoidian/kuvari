// test/models/kuha_image_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:kuha_app/models/kuha_image.dart';

void main() {
  group('KuhaImage Model Test', () {
    test('fromJson creates a valid KuhaImage object', () {
      final json = {
        'author': 'John Doe',
        'name': 'Sunset',
        'thumb': 'https://example.com/thumb/sunset.png',
        'url': 'https://example.com/images/sunset.png',
        'uid': 101,
      };

      final kuva = KuhaImage.fromJson(json);

      expect(kuva.author, 'John Doe');
      expect(kuva.name, 'Sunset');
      expect(kuva.thumb, 'https://example.com/thumb/sunset.png');
      expect(kuva.url, 'https://example.com/images/sunset.png');
      expect(kuva.uid, 101);
    });

    test('fromJson assigns default values when keys are missing', () {
      final json = {
        'author': 'Jane Smith',
        // 'name' on puuttuu
        'thumb': 'https://example.com/thumb/missing.png',
        // 'url' on puuttuu
        // 'uid' on puuttuu
      };

      final kuva = KuhaImage.fromJson(json);

      expect(kuva.author, 'Jane Smith');
      expect(kuva.name, ''); // Oletusarvo
      expect(kuva.thumb, 'https://example.com/thumb/missing.png');
      expect(kuva.url, ''); // Oletusarvo
      expect(kuva.uid, 0); // Oletusarvo
    });
  });
}
