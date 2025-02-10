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

    testWidgets('Displays ReorderableListView and delete icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SelectedImagesCarousel(
            selectedImages: mockImages,
            currentStartIndex: 0,
            maxVisibleImages: 4,
            onClear: () {},
            onRemove: (index) {},
            onReorder: (oldIndex, newIndex) {},
          ),
        ),
      );

      expect(find.byType(ReorderableListView), findsOneWidget);
      expect(find.byIcon(Icons.delete_sweep), findsOneWidget);
    });

    testWidgets('Displays selected images within currentStartIndex and maxVisibleImages', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SelectedImagesCarousel(
            selectedImages: mockImages,
            currentStartIndex: 1,
            maxVisibleImages: 2,
            onClear: () {},
            onRemove: (index) {},
            onReorder: (oldIndex, newIndex) {},
          ),
        ),
      );

      // Tämän tulisi näyttää vain kaksi kuvaa
      expect(find.byType(Image), findsNWidgets(2));
    });

    testWidgets('Supports reordering of images', (WidgetTester tester) async {
      bool reorderCalled = false;
      await tester.pumpWidget(
        MaterialApp(
          home: SelectedImagesCarousel(
            selectedImages: mockImages,
            currentStartIndex: 0,
            maxVisibleImages: 2,
            onClear: () {},
            onRemove: (index) {},
            onReorder: (oldIndex, newIndex) {
              reorderCalled = true;
            },
          ),
        ),
      );

      expect(find.byType(ReorderableListView), findsOneWidget);
    });
  });
}
