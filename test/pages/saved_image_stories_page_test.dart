import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:kuvari_app/models/image_story.dart';
import 'package:kuvari_app/models/kuvari_image.dart';
import 'package:kuvari_app/pages/saved_image_stories_page.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'saved_image_stories_page_test.mocks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@GenerateMocks([ImageStory], customMocks: [
  MockSpec<Box<ImageStory>>(as: 'MockImageStoryBox')
])
void main() {
  late MockImageStoryBox mockBox;

  setUp(() {
    mockBox = MockImageStoryBox();
  });

  testWidgets('Displays saved image stories when available', (WidgetTester tester) async {
    final stories = [
      ImageStory(
        id: '1',
        name: 'Kuvatarina 1',
        images: [],
      ),
    ];

    // Määritä mockBox palauttamaan tarinat
    when(mockBox.values).thenReturn(stories);
    when(mockBox.listenable()).thenReturn(ValueNotifier(mockBox));

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

    // Aseta Hive.box<ImageStory> palauttamaan mockBox
    Hive.registerAdapter(ImageStoryAdapter());
    Hive.registerAdapter(KuvariImageAdapter());
    Hive.init('');
    when(Hive.box<ImageStory>('imageStories')).thenReturn(mockBox);

    await tester.pump();

    // Varmista, että tarina näkyy
    expect(find.text('Kuvatarina 1'), findsOneWidget);
  });

  testWidgets('Shows message when no saved image stories are available', (WidgetTester tester) async {
    // Määritä mockBox palauttamaan tyhjä lista
    when(mockBox.values).thenReturn([]);
    when(mockBox.listenable()).thenReturn(ValueNotifier(mockBox));

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

    // Aseta Hive.box<ImageStory> palauttamaan mockBox
    Hive.registerAdapter(ImageStoryAdapter());
    Hive.registerAdapter(KuvariImageAdapter());
    Hive.init('');
    when(Hive.box<ImageStory>('imageStories')).thenReturn(mockBox);

    await tester.pump();

    // Varmista, että oikea viesti näkyy
    expect(find.text('Ei tallennettuja kuvatarinoita'), findsOneWidget);
  });
}
