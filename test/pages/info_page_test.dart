// test/pages/info_page_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kuvari_app/l10n/app_localizations.dart';
import 'package:kuvari_app/pages/info_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget createInfoPage({
    Locale locale = const Locale('fi'),
    Future<bool> Function(Uri url)? urlLauncher,
  }) {
    return MaterialApp(
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fi'),
        Locale('sv'),
        Locale('en'),
      ],
      home: InfoPage(urlLauncher: urlLauncher),
    );
  }

  void configureViewport(WidgetTester tester) {
    tester.view.physicalSize = const Size(800, 1800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  }

  group('InfoPage Widget Tests', () {
    testWidgets('Renders scrollable ListView with exactly three Material 3 Cards (D-01, D-03)', (WidgetTester tester) async {
      configureViewport(tester);
      await tester.pumpWidget(createInfoPage());
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(Card), findsNWidgets(3));

      // Verify section header icons
      expect(find.byIcon(Icons.bolt_outlined), findsOneWidget);
      expect(find.byIcon(Icons.forum_outlined), findsOneWidget);
      expect(find.byIcon(Icons.info_outline), findsOneWidget);
    });

    testWidgets('Displays Quick Start 5-step guidance (GUIDE-02)', (WidgetTester tester) async {
      configureViewport(tester);
      await tester.pumpWidget(createInfoPage());
      await tester.pumpAndSettle();

      expect(find.text('Pikaopas'), findsOneWidget);
      expect(find.text('Näin aloitat Kuvarin käytön arjen kommunikoinnissa:'), findsOneWidget);
      expect(find.text('1. Etsi kuvia'), findsOneWidget);
      expect(find.text('2. Kokoa ja muokkaa jonoa'), findsOneWidget);
      expect(find.text('3. Näytä ja kuuntele'), findsOneWidget);
      expect(find.text('4. Tallenna toistuvaa käyttöä varten'), findsOneWidget);
      expect(find.text('5. Järjestele ja hae tägeillä'), findsOneWidget);
    });

    testWidgets('Displays all 3 core practical AAC use cases (GUIDE-01)', (WidgetTester tester) async {
      configureViewport(tester);
      await tester.pumpWidget(createInfoPage());
      await tester.pumpAndSettle();

      expect(find.text('Käytännön tilanteet'), findsOneWidget);
      expect(find.text('Valinnan tekeminen'), findsOneWidget);
      expect(find.text('Päiväjärjestys ja toimintaketjut'), findsOneWidget);
      expect(find.text('Osoittaminen ja puhesynteesi'), findsOneWidget);

      // Verify AAC use case icons
      expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
      expect(find.byIcon(Icons.schedule_outlined), findsOneWidget);
      expect(find.byIcon(Icons.record_voice_over_outlined), findsOneWidget);
    });

    testWidgets('Displays Attributions and launches external URLs correctly on tap (D-05)', (WidgetTester tester) async {
      configureViewport(tester);
      final launchedUris = <String>[];

      await tester.pumpWidget(createInfoPage(
        urlLauncher: (uri) async {
          launchedUris.add(uri.toString());
          return true;
        },
      ));
      await tester.pumpAndSettle();

      expect(find.text('Tietoa ja lähteet'), findsOneWidget);

      await tester.tap(find.text('Papunetin kuvapankki'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('OpenSymbols'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Rinnekodit'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('NIMEÄ-EIKAUPALLINEN-JAASAMOIN 4.0'));
      await tester.pumpAndSettle();

      expect(launchedUris, contains('https://papunet.net/kuvatyokalut/kuvapankki/'));
      expect(launchedUris, contains('https://www.opensymbols.org/'));
      expect(launchedUris, contains('https://www.rinnekodit.fi/'));
      expect(launchedUris.any((uri) => uri.contains('creativecommons.org')), isTrue);
    });

    testWidgets('Renders all sections in Swedish and English without missing keys (D-04)', (WidgetTester tester) async {
      configureViewport(tester);

      // Test Swedish
      await tester.pumpWidget(createInfoPage(locale: const Locale('sv')));
      await tester.pumpAndSettle();

      expect(find.text('Snabbguide'), findsOneWidget);
      expect(find.text('Praktiska situationer'), findsOneWidget);
      expect(find.text('Information och källor'), findsOneWidget);
      expect(find.text('2. Bygg och ändra i kön'), findsOneWidget);
      expect(find.text('3. Visa och lyssna'), findsOneWidget);
      expect(find.text('4. Spara för återkommande användning'), findsOneWidget);
      expect(find.text('5. Organisera och sök med taggar'), findsOneWidget);
      expect(find.text('Att göra val'), findsOneWidget);
      expect(find.text('Dagsordning och rutiner'), findsOneWidget);
      expect(find.text('Pekning och talsyntes'), findsOneWidget);

      // Test English
      await tester.pumpWidget(createInfoPage(locale: const Locale('en')));
      await tester.pumpAndSettle();

      expect(find.text('Quick Start'), findsOneWidget);
      expect(find.text('Practical Situations'), findsOneWidget);
      expect(find.text('About & Attributions'), findsOneWidget);
      expect(find.text('2. Assemble and edit the queue'), findsOneWidget);
      expect(find.text('3. View and listen'), findsOneWidget);
      expect(find.text('4. Save for repeated use'), findsOneWidget);
      expect(find.text('5. Organize and search with tags'), findsOneWidget);
      expect(find.text('Making Choices'), findsOneWidget);
      expect(find.text('Daily Routines & Sequences'), findsOneWidget);
      expect(find.text('Pointing & Speech Modeling'), findsOneWidget);
    });
  });
}
