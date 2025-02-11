import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart'; // Lisää tämä import
import 'package:kuvari_app/models/image_story.dart';
import 'package:kuvari_app/models/kuvari_image.dart';
import 'package:kuvari_app/pages/saved_image_stories_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  setUp(() async {
    // Alusta Hive testejä varten
    await setUpTestHive();
    // Rekisteröi adapterit
    Hive.registerAdapter(ImageStoryAdapter());
    Hive.registerAdapter(KuvariImageAdapter());
    // Avaa testiä varten laatikko
    await Hive.openBox<ImageStory>('imageStories');
  });

  tearDown(() async {
    // Sulje Hive testin jälkeen
    await tearDownTestHive();
  });

  testWidgets('Displays saved image stories when available',
      (WidgetTester tester) async {
    final stories = [
      ImageStory(
        id: '1',
        name: 'Kuvatarina 1',
        images: [],
      ),
    ];

    // Tallenna tarina Hive-laatikkoon
    final box = Hive.box<ImageStory>('imageStories');
    await box.addAll(stories);

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
        home: const SavedImageStoriesPage(),
      ),
    );

    await tester.pumpAndSettle();

    // Varmista, että tarina näkyy
    expect(find.text('Kuvatarina 1'), findsOneWidget);
  });

  testWidgets('Shows message when no saved image stories are available',
      (WidgetTester tester) async {
    // Varmista, että laatikko on tyhjä
    final box = Hive.box<ImageStory>('imageStories');
    await box.clear();

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
        home: const SavedImageStoriesPage(),
      ),
    );

    await tester.pumpAndSettle();

    // Hae lokalisoitu teksti
    final BuildContext context =
        tester.element(find.byType(SavedImageStoriesPage));
    final noStoriesText = AppLocalizations.of(context)!.noSavedStories;

    // Varmista, että oikea viesti näkyy
    expect(find.text(noStoriesText), findsOneWidget);
  });
}
