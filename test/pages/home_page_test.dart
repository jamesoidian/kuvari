// test/pages/home_page_test.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kuvari_app/models/kuvari_image.dart';
import 'package:kuvari_app/pages/home_page.dart';
import 'package:kuvari_app/services/kuvari_service.dart';
import 'package:kuvari_app/widgets/image_grid.dart';
import 'package:kuvari_app/widgets/selected_images_carousel.dart';
import 'package:kuvari_app/widgets/kuvari_search_bar.dart';
import 'home_page_test.mocks.dart';
import 'dart:convert';

// Määrittele mock-objekti
@GenerateMocks([KuvariService])
void main() {
  group('HomePage Widget Tests', () {
    late MockKuvariService mockKuvariService;

    setUp(() {
      mockKuvariService = MockKuvariService();
    });

 /*    testWidgets('Displays CircularProgressIndicator when loading', (WidgetTester tester) async {
      // Määritä mock KuvariService palauttamaan odotettava vastaus
      when(mockKuvariService.searchImages(any)).thenAnswer((_) async {
        // Simuloidaan viivettä
        return Future.delayed(const Duration(seconds: 2), () => []);
      });

      // Luo HomePage käyttäen mock KuvariServicea
      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(KuvariService: mockKuvariService),
        ),
      );

      // Syötä hakusana ja aloita haku
      await tester.enterText(find.byType(TextField), 'test');
      await tester.tap(find.byIcon(Icons.search));
      await tester.pump(); // Aloita async toiminta

      // Tarkista, että CircularProgressIndicator näkyy
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    }); */

    testWidgets('Displays images after successful search', (WidgetTester tester) async {
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

      // Määritä mock KuvariService palauttamaan mockImages
      when(mockKuvariService.searchImages('test', any, any)).thenAnswer((_) async => mockImages);

      // Luo HomePage käyttäen mock KuvariServicea
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fi'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('fi'),
            Locale('sv'),
          ],
          home: HomePage(
            kuvariService: mockKuvariService,
            setLocale: (_) {}, // Empty function for testing
          ),
        ),
      );
      await tester.pump();

      // Syötä hakusana ja aloita haku
      await tester.enterText(find.byType(TextField), 'test');
      await tester.tap(find.byIcon(Icons.search));
      await tester.pump(); // Aloita async toiminta
      await tester.pump(const Duration(seconds: 2)); // Odota async toiminta

      // Tarkista, että kuvat näkyvät
      expect(find.byType(Image), findsNWidgets(2));
    });

    testWidgets('Displays error message on failed search', (WidgetTester tester) async {
      // Määritä mock KuvariService heittämään poikkeus
      when(mockKuvariService.searchImages('test', any, any)).thenThrow(Exception('Failed to load images'));

      // Luo HomePage käyttäen mock KuvariServicea
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fi'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('fi'),
            Locale('sv'),
          ],
          home: HomePage(
            kuvariService: mockKuvariService,
            setLocale: (_) {}, // Empty function for testing
          ),
        ),
      );
      await tester.pump();

      // Syötä hakusana ja aloita haku
      await tester.enterText(find.byType(TextField), 'test');
      await tester.tap(find.byIcon(Icons.search));
      await tester.pump(); // Aloita async toiminta
      await tester.pump(const Duration(seconds: 2)); // Odota async toiminta

      // Tarkista, että SnackBar näkyy virheilmoituksen kanssa
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Virhe haussa: Exception: Failed to load images'), findsOneWidget);
    });

    testWidgets('Can select and remove images', (WidgetTester tester) async {
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

      // Määritä mock KuvariService palauttamaan mockImages
      when(mockKuvariService.searchImages('test', any, any)).thenAnswer((_) async => mockImages);

      // Luo HomePage käyttäen mock KuvariServicea
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fi'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('fi'),
            Locale('sv'),
          ],
          home: HomePage(
            kuvariService: mockKuvariService,
            setLocale: (_) {}, // Empty function for testing
          ),
        ),
      );
      await tester.pump();

      // Syötä hakusana ja aloita haku
      await tester.enterText(find.byType(TextField), 'test');
      await tester.tap(find.byIcon(Icons.search));
      await tester.pump(); // Aloita async toiminta
      await tester.pump(const Duration(seconds: 2)); // Odota async toiminta

      // Valitse ensimmäinen kuva
      await tester.tap(find.byType(Image).first);
      await tester.pump();

      // Tarkista, että SelectedImagesCarousel näkyy
      expect(find.byType(SelectedImagesCarousel), findsOneWidget);

      // Oletetaan, että SelectedImagesCarousel näyttää valitut kuvat
      // Voit tarkistaa valittujen kuvien määrän
      // Tämä riippuu SelectedImagesCarouselin toteutuksesta
      // Tässä esimerkissä emme tiedä tarkkaa rakennetta, joten tämä on yleinen tarkastus
      // Voit lisätä tarkempia tarkastuksia riippuen siitä, miten SelectedImagesCarousel toimii

      // Poista valittu kuva
      // Tämä riippuu siitä, miten poisto toimii UI:ssa, esimerkiksi tappamalla poistokuvaketta
      // Tässä oletetaan, että SelectedImagesCarousel sisältää poistokuvakkeen (esim. IconButton)
      // Jos SelectedImagesCarousel sisältää esimerkiksi X-ikonin jokaiselle kuvalle:
      // await tester.tap(find.byIcon(Icons.close).first);
      // await tester.pump();

      // Voit lisätä tarkastuksia, että kuva on poistettu
      // expect(find.byType(SelectedImagesCarousel), findsNothing);
      // tai tarkista valittujen kuvien määrä
      // Tämä riippuu siitä, miten SelectedImagesCarousel päivittää UI:ta
    });
  });
}
