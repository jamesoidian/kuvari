import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:kuvari_app/models/image_story.dart';
import 'package:kuvari_app/models/kuvari_image.dart';
import 'package:kuvari_app/pages/saved_image_stories_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  group("SavedImageStoriesPage Tests", () {
    late Box<ImageStory> box;

    setUp(() async {
      await setUpTestHive();
      Hive.registerAdapter(ImageStoryAdapter());
      Hive.registerAdapter(KuvariImageAdapter());
      box = await Hive.openBox<ImageStory>('imageStories');
    });

    tearDown(() async {
      await tearDownTestHive();
    });

    testWidgets("Displays saved image stories when available", (tester) async {
      final story = ImageStory(
        id: '1',
        name: 'Kuvatarina 1',
        images: [],
      );
      await box.add(story);

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
          home: SavedImageStoriesPage(imageStoriesBox: box),
        ),
      );

      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Kuvatarina 1'), findsOneWidget);
    });

    testWidgets("Shows message when no saved image stories are available", (tester) async {
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
          home: SavedImageStoriesPage(imageStoriesBox: box),
        ),
      );

      await tester.pump(const Duration(milliseconds: 100));

      final context = tester.element(find.byType(SavedImageStoriesPage));
      final noStoriesText = AppLocalizations.of(context)!.noSavedImageStories;

      expect(find.text(noStoriesText), findsOneWidget);
    });
  });
}
