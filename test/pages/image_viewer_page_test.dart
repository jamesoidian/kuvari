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
        home: ImageViewerPage(images: images),
      ),
    );

    // Varmista, että ensimmäinen kuva näkyy
    expect(find.byType(Image), findsNWidgets(2));
    expect(find.text('Kuvakatselu 1/2'), findsOneWidget);

    // Pyyhkäise seuraavaan kuvaan
    await tester.fling(find.byType(PageView), const Offset(-400, 0), 1000);
    await tester.pumpAndSettle();

    // Varmista, että toinen kuva näkyy
    expect(find.text('Kuvakatselu 2/2'), findsOneWidget);
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

    // Varmista, että virheilmoitus näkyy
    expect(find.text('Ei kuvia näytettäväksi'), findsOneWidget);
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
        home: ImageViewerPage(images: images),
      ),
    );

    // Paina koti-painiketta
    await tester.tap(find.byIcon(Icons.home));
    await tester.pumpAndSettle();

    // Koska sovelluksella ei ole määriteltyä aloitussivua tässä testissä, varmistetaan, että
    // navigointi tapahtui (historia on tyhjä)
    expect(find.byType(ImageViewerPage), findsNothing);
    });
  });
}
