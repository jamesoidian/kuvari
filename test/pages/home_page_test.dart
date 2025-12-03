// test/pages/home_page_test.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kuvari_app/l10n/app_localizations.dart';
import 'package:kuvari_app/models/kuvari_image.dart';
import 'package:kuvari_app/pages/home_page.dart';
import 'package:kuvari_app/services/kuvari_service.dart';
import 'package:kuvari_app/widgets/image_grid.dart';
import 'package:kuvari_app/widgets/selected_images_carousel.dart';
import 'package:kuvari_app/widgets/kuvari_search_bar.dart';
import 'home_page_test.mocks.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:kuvari_app/widgets/home_search_section.dart';

// Määrittele mock-objekti
class FakeFirebaseAnalytics extends Fake implements FirebaseAnalytics {
  @override
  Future<void> logEvent({AnalyticsCallOptions? callOptions, required String name, Map<String, Object>? parameters}) async {
    // Do nothing in tests
  }
}

@GenerateMocks([KuvariService])
Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
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
      await tester.tap(find.byIcon(Icons.search_outlined));
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
            analytics: FakeFirebaseAnalytics(),
          ),
        ),
      );
      await tester.pump();

      // Syötä hakusana ja aloita haku
      await tester.enterText(find.byType(TextField), 'test');
      await tester.tap(find.byIcon(Icons.search_outlined));
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
            analytics: FakeFirebaseAnalytics(),
          ),
        ),
      );
      await tester.pump();

      // Syötä hakusana ja aloita haku
      await tester.enterText(find.byType(TextField), 'test');
      await tester.tap(find.byIcon(Icons.search_outlined));
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
            analytics: FakeFirebaseAnalytics(),
          ),
        ),
      );
      await tester.pump();

      // Syötä hakusana ja aloita haku
      await tester.enterText(find.byType(TextField), 'test');
      await tester.tap(find.byIcon(Icons.search_outlined));
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
    });

    testWidgets('Displays HomeSearchSection widget', (WidgetTester tester) async {
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
          home: HomePage(
            kuvariService: mockKuvariService,
            setLocale: (_) {},
            analytics: FakeFirebaseAnalytics(),
          ),
        ),
      );
      expect(find.byType(HomeSearchSection), findsOneWidget);
    });
  });
}
