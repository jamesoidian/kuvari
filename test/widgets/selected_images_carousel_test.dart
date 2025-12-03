// test/widgets/selected_images_carousel_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kuvari_app/models/kuvari_image.dart';
import 'package:kuvari_app/widgets/selected_images_carousel.dart';
import 'package:kuvari_app/l10n/app_localizations.dart';

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
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('fi')],
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

    testWidgets('Displays all selected images', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('fi')],
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

      expect(find.byType(Image), findsNWidgets(mockImages.length));
    });

    testWidgets('Calls onRemove when an image is tapped', (WidgetTester tester) async {
      int removedIndex = -1;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('fi')],
          home: SelectedImagesCarousel(
            selectedImages: mockImages,
            currentStartIndex: 0,
            maxVisibleImages: 4,
            onClear: () {},
            onRemove: (index) {
              removedIndex = index;
            },
            onReorder: (oldIndex, newIndex) {},
          ),
        ),
      );

      // Tap on the close icon of the first image
      await tester.tap(find.byIcon(Icons.close).first);
      expect(removedIndex, 0);
    });

    testWidgets('Calls onClear when clear button is tapped', (WidgetTester tester) async {
      bool clearCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('fi')],
          home: SelectedImagesCarousel(
            selectedImages: mockImages,
            currentStartIndex: 0,
            maxVisibleImages: 4,
            onClear: () {
              clearCalled = true;
            },
            onRemove: (index) {},
            onReorder: (oldIndex, newIndex) {},
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.delete_sweep));
      expect(clearCalled, isTrue);
    });
  });
}
