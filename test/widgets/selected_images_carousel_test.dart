// test/widgets/selected_images_carousel_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kuvari_app/models/kuvari_image.dart';
import 'package:kuvari_app/widgets/selected_images_carousel.dart';

void main() {
  group('SelectedImagesCarousel Widget Tests', () {
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
      KuvariImage(
        author: 'Alice Johnson',
        name: 'Forest',
        thumb: 'https://example.com/thumb/forest.png',
        url: 'https://example.com/images/forest.png',
        uid: 103,
      ),
    ];

    testWidgets('Displays arrow buttons and delete icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SelectedImagesCarousel(
            selectedImages: mockImages,
            currentStartIndex: 0,
            maxVisibleImages: 4,
            onScrollLeft: () {},
            onScrollRight: () {},
            onClear: () {},
            onRemove: (index) {},
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
      expect(find.byIcon(Icons.delete_sweep), findsOneWidget);
    });

    testWidgets('Displays selected images within currentStartIndex and maxVisibleImages', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SelectedImagesCarousel(
            selectedImages: mockImages,
            currentStartIndex: 1,
            maxVisibleImages: 2,
            onScrollLeft: () {},
            onScrollRight: () {},
            onClear: () {},
            onRemove: (index) {},
          ),
        ),
      );

      // Tämän tulisi näyttää vain kaksi kuvaa
      expect(find.byType(Image), findsNWidgets(2));
    });

    testWidgets('Arrow buttons are disabled appropriately', (WidgetTester tester) async {
      // Testaa vasemman nuolen tilaa, kun currentStartIndex on 0
      await tester.pumpWidget(
        MaterialApp(
          home: SelectedImagesCarousel(
            selectedImages: mockImages,
            currentStartIndex: 0,
            maxVisibleImages: 2,
            onScrollLeft: () {},
            onScrollRight: () {},
            onClear: () {},
            onRemove: (index) {},
          ),
        ),
      );

      final backButton = tester.widget<IconButton>(find.widgetWithIcon(IconButton, Icons.arrow_back));
      final forwardButton = tester.widget<IconButton>(find.widgetWithIcon(IconButton, Icons.arrow_forward));
      
      expect(backButton.onPressed, isNull); // Ei voi selata vasemmalle
      expect(forwardButton.onPressed, isNotNull); // Voidaan selata oikealle
    });
  });
}
