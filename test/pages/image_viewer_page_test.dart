import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kuvari_app/models/kuvari_image.dart';
import 'package:kuvari_app/pages/image_viewer_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('Displays images in portrait mode', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      final images = [
        KuvariImage(
          author: 'Author',
          name: 'Image1',
          thumb: 'https://example.com/thumb1.png',
          url: 'https://example.com/image1.png',
          uid: 1,
        ),
        KuvariImage(
          author: 'Author',
          name: 'Image2',
          thumb: 'https://example.com/thumb2.png',
          url: 'https://example.com/image2.png',
          uid: 2,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fi'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('fi'), Locale('sv')],
          home: MediaQuery(
            data: const MediaQueryData(
              size: Size(1080, 1920),
            ),
            child: ImageViewerPage(images: images),
          ),
        ),
      );

      // Get localized strings
      final BuildContext context = tester.element(find.byType(ImageViewerPage));
      final imageViewerText = AppLocalizations.of(context)!.imageViewer;

      // Varmista, että ensimmäinen kuva näkyy
      expect(find.byType(Image), findsNWidgets(1));
      final expectedTitle = '$imageViewerText 1/2';
      expect(find.text(expectedTitle), findsOneWidget);

      // Pyyhkäise seuraavaan kuvaan
      await tester.fling(find.byType(PageView), const Offset(-400, 0), 1000);
      await tester.pumpAndSettle();

      // Varmista, että toinen kuva näkyy
      final expectedTitlePage2 = '$imageViewerText 2/2';
      expect(find.text(expectedTitlePage2), findsOneWidget);
    });
  });

  testWidgets('Shows no images message when image list is empty', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fi'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('fi'), Locale('sv')],
        home: ImageViewerPage(images: []),
      ),
    );

    // Get localized strings
    final BuildContext context = tester.element(find.byType(ImageViewerPage));
    final noImagesText = AppLocalizations.of(context)!.noImagesToView;

    // Varmista, että virheilmoitus näkyy
    expect(find.text(noImagesText), findsOneWidget);
    });
  });

  testWidgets('Navigates to home when home button is pressed', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      final images = [
        KuvariImage(
          author: 'Author',
          name: 'Image1',
          thumb: 'https://example.com/thumb1.png',
          url: 'https://example.com/image1.png',
          uid: 1,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fi'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('fi'), Locale('sv')],
          home: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ImageViewerPage(images: images)),
                );
              },
              child: const Text('Open ImageViewerPage'),
            ),
          ),
        ),
      );

      // Avaa ImageViewerPage painamalla nappia
      await tester.tap(find.text('Open ImageViewerPage'));
      await tester.pumpAndSettle();

      // Varmista, että ImageViewerPage avautui
      expect(find.byType(ImageViewerPage), findsOneWidget);

      // Paina koti-painiketta ImageViewerPage-sivulla
      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle();

      // Varmista, että navigointi aloitussivulle on tapahtunut
      expect(find.byType(ImageViewerPage), findsNothing);
    });
  });
}
