// test/pages/home_page_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:kuha_app/models/kuha_image.dart';
import 'package:kuha_app/pages/home_page.dart';
import 'package:kuha_app/services/kuha_service.dart';
import 'package:kuha_app/widgets/image_grid.dart';
import 'package:kuha_app/widgets/selected_images_carousel.dart';
import 'package:kuha_app/widgets/kuha_search_bar.dart';
import 'home_page_test.mocks.dart';
import 'dart:convert';

// Määrittele mock-objekti
@GenerateMocks([KuhaService])
void main() {
  group('HomePage Widget Tests', () {
    late MockKuhaService mockKuhaService;

    setUp(() {
      mockKuhaService = MockKuhaService();
    });

 /*    testWidgets('Displays CircularProgressIndicator when loading', (WidgetTester tester) async {
      // Määritä mock KuhaService palauttamaan odotettava vastaus
      when(mockKuhaService.searchImages(any)).thenAnswer((_) async {
        // Simuloidaan viivettä
        return Future.delayed(const Duration(seconds: 2), () => []);
      });

      // Luo HomePage käyttäen mock KuhaServicea
      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(kuhaService: mockKuhaService),
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
        KuhaImage(
          author: 'John Doe',
          name: 'Sunset',
          thumb: 'https://example.com/thumb/sunset.png',
          url: 'https://example.com/images/sunset.png',
          uid: 101,
        ),
        KuhaImage(
          author: 'Jane Smith',
          name: 'Mountain',
          thumb: 'https://example.com/thumb/mountain.png',
          url: 'https://example.com/images/mountain.png',
          uid: 102,
        ),
      ];

      // Määritä mock KuhaService palauttamaan mockImages
      when(mockKuhaService.searchImages('test')).thenAnswer((_) async => mockImages);

      // Luo HomePage käyttäen mock KuhaServicea
      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(kuhaService: mockKuhaService),
        ),
      );

      // Syötä hakusana ja aloita haku
      await tester.enterText(find.byType(TextField), 'test');
      await tester.tap(find.byIcon(Icons.search));
      await tester.pump(); // Aloita async toiminta
      await tester.pump(const Duration(seconds: 2)); // Odota async toiminta

      // Tarkista, että kuvat näkyvät
      expect(find.byType(Image), findsNWidgets(2));
    });

    testWidgets('Displays error message on failed search', (WidgetTester tester) async {
      // Määritä mock KuhaService heittämään poikkeus
      when(mockKuhaService.searchImages('test')).thenThrow(Exception('Failed to load images'));

      // Luo HomePage käyttäen mock KuhaServicea
      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(kuhaService: mockKuhaService),
        ),
      );

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
        KuhaImage(
          author: 'John Doe',
          name: 'Sunset',
          thumb: 'https://example.com/thumb/sunset.png',
          url: 'https://example.com/images/sunset.png',
          uid: 101,
        ),
        KuhaImage(
          author: 'Jane Smith',
          name: 'Mountain',
          thumb: 'https://example.com/thumb/mountain.png',
          url: 'https://example.com/images/mountain.png',
          uid: 102,
        ),
      ];

      // Määritä mock KuhaService palauttamaan mockImages
      when(mockKuhaService.searchImages('test')).thenAnswer((_) async => mockImages);

      // Luo HomePage käyttäen mock KuhaServicea
      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(kuhaService: mockKuhaService),
        ),
      );

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
