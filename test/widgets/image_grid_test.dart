// test/widgets/image_grid_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kuvari_app/models/kuvari_image.dart';
import 'package:kuvari_app/widgets/image_grid.dart';

void main() {
  group('ImageGrid Widget Tests', () {
    late List<KuvariImage> images;
    late List<KuvariImage> selectedImages;
    late bool onSelectCalled;
    late KuvariImage selectedImage;

    setUp(() {
      images = [
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
      selectedImages = [];
      onSelectCalled = false;
      selectedImage = images[0];
    });

    testWidgets('Displays message when images list is empty', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ImageGrid(
            images: [],
            selectedImages: selectedImages,
            onSelect: (image) { onSelectCalled = true; },
          ),
        ),
      );

      expect(find.text('Ei hakutuloksia'), findsOneWidget);
      expect(find.byType(GridView), findsNothing);
    });

    testWidgets('Displays GridView with images when images list is not empty', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ImageGrid(
            images: images,
            selectedImages: selectedImages,
            onSelect: (image) { onSelectCalled = true; },
          ),
        ),
      );

      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(Card), findsNWidgets(2));
      expect(find.text('Sunset'), findsOneWidget);
      expect(find.text('Mountain'), findsOneWidget);
    });

    testWidgets('Calls onSelect when an image is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ImageGrid(
            images: images,
            selectedImages: selectedImages,
            onSelect: (image) {
              onSelectCalled = true;
              selectedImage = image;
            },
          ),
        ),
      );

      // Tapataan ensimmäinen kuva
      await tester.tap(find.byType(Image).first, warnIfMissed: false);
      await tester.pump();

      expect(onSelectCalled, isTrue);
      expect(selectedImage.name, 'Sunset');
    });

    testWidgets('Displays selected icon on selected images', (WidgetTester tester) async {
      selectedImages.add(images[0]);

      await tester.pumpWidget(
        MaterialApp(
          home: ImageGrid(
            images: images,
            selectedImages: selectedImages,
            onSelect: (image) { onSelectCalled = true; },
          ),
        ),
      );

      expect(find.widgetWithIcon(Stack, Icons.check_circle), findsOneWidget);
    });
  });
}
