// test/pages/selected_images_page_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kuvari_app/models/kuvari_image.dart';
import 'package:kuvari_app/pages/selected_images_page.dart';

void main() {
  group('SelectedImagesPage Widget Tests', () {
    testWidgets('Displays message when images list is empty', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SelectedImagesPage(images: []),
        ),
      );

      expect(find.text('Ei valittuja kuvia.'), findsOneWidget);
      expect(find.byType(GridView), findsNothing);
    });

    testWidgets('Displays GridView with images when images list is not empty', (WidgetTester tester) async {
      final mockImages = [
        KuvariImage(
          author: 'John Doe',
          name: 'Sunset',
          thumb: 'https://example.com/thumb/sunset.png',
          url: 'https://example.com/images/sunset.png',
          uid: 101,
        ),
        KuvariImage(
          author: 'Jane Smith',
          name: 'Mountain',
          thumb: 'https://example.com/thumb/mountain.png',
          url: 'https://example.com/images/mountain.png',
          uid: 102,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: SelectedImagesPage(images: mockImages),
        ),
      );

      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(Card), findsNWidgets(2));
      expect(find.text('Sunset'), findsOneWidget);
      expect(find.text('Mountain'), findsOneWidget);
    });
  });
}
