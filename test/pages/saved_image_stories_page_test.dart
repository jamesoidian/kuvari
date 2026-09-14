import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:kuvari_app/models/image_story.dart';
import 'package:kuvari_app/models/kuvari_image.dart';
import 'package:kuvari_app/pages/saved_image_stories_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kuvari_app/l10n/app_localizations.dart';

import 'package:kuvari_app/models/tag.dart';
import 'package:flutter/foundation.dart';
import 'package:kuvari_app/widgets/selected_images_carousel.dart';

class FakeHiveBox<T> extends Fake implements Box<T> {
  final Map<dynamic, T> _items = {};
  late final _FakeBoxListenable<T> _listenable;

  FakeHiveBox() {
    _listenable = _FakeBoxListenable<T>(this);
  }

  @override
  Iterable<T> get values => _items.values;

  @override
  dynamic keyAt(int index) => _items.keys.elementAt(index);

  @override
  Iterable<dynamic> get keys => _items.keys;

  @override
  T? get(dynamic key, {T? defaultValue}) => _items[key] ?? defaultValue;

  @override
  Future<void> put(dynamic key, T value) async {
    _items[key] = value;
    _listenable.notify();
  }

  @override
  Future<int> add(T value) async {
    final key = _items.length;
    _items[key] = value;
    _listenable.notify();
    return key;
  }

  @override
  Future<void> delete(dynamic key) async {
    _items.remove(key);
    _listenable.notify();
  }

  @override
  Future<int> clear() async {
    _items.clear();
    _listenable.notify();
    return 0;
  }

  @override
  Stream<BoxEvent> watch({dynamic key}) {
    return const Stream.empty();
  }

  ValueListenable<Box<T>> listenable({List<dynamic>? keys}) => _listenable;
}

class _FakeBoxListenable<T> extends ChangeNotifier
    implements ValueListenable<Box<T>> {
  final Box<T> box;
  _FakeBoxListenable(this.box);

  @override
  Box<T> get value => box;

  void notify() => notifyListeners();
}

void main() {
  group("SavedImageStoriesPage Tests", () {
    late FakeHiveBox<ImageStory> storiesBox;
    late FakeHiveBox<Tag> tagsBox;

    setUp(() {
      storiesBox = FakeHiveBox<ImageStory>();
      tagsBox = FakeHiveBox<Tag>();
    });

    Widget createWidget({bool hasActiveQueue = false, int activeQueueCount = 0}) {
      return MaterialApp(
        locale: const Locale('fi'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('fi'), Locale('sv')],
        home: SavedImageStoriesPage(
          imageStoriesBox: storiesBox,
          tagsBox: tagsBox,
          hasActiveQueue: hasActiveQueue,
          activeQueueCount: activeQueueCount,
        ),
      );
    }

    testWidgets("Displays saved image stories when available", (tester) async {
      await storiesBox.put(
        0,
        ImageStory(
          id: '1',
          name: 'Story 1',
          images: [
            KuvariImage(uid: 1, name: 'Img 1', author: 'A', thumb: '', url: ''),
          ],
        ),
      );

      await tester.pumpWidget(createWidget());
      await tester.pumpAndSettle();

      expect(find.text('Story 1'), findsOneWidget);
    });

    testWidgets("Displays updated guidance and search texts", (tester) async {
      await storiesBox.put(
        0,
        ImageStory(
          id: '1',
          name: 'Story 1',
          images: [
            KuvariImage(uid: 1, name: 'Img 1', author: 'A', thumb: '', url: ''),
          ],
        ),
      );

      await tester.pumpWidget(createWidget());
      await tester.pumpAndSettle();

      expect(find.text('Hae kuvajonoja tägin nimellä...'), findsOneWidget);
      expect(find.text('Lisää tägejä painamalla kuvajonoa pitkään'), findsOneWidget);
      expect(find.text('Kuvajonolla voi olla monta tägiä'), findsOneWidget);
      expect(find.text('Poista jono pyyhkäisemällä vasemmalle'), findsOneWidget);
    });

    testWidgets("Renders read-only carousel without ReorderableListView or delete buttons", (tester) async {
      await storiesBox.put(
        0,
        ImageStory(
          id: '1',
          name: 'Story 1',
          images: [
            KuvariImage(uid: 1, name: 'Img 1', author: 'A', thumb: '', url: ''),
            KuvariImage(uid: 2, name: 'Img 2', author: 'B', thumb: '', url: ''),
          ],
        ),
      );

      await tester.pumpWidget(createWidget());
      await tester.pumpAndSettle();

      expect(find.byType(SelectedImagesCarousel), findsOneWidget);
      final carouselWidget = tester.widget<SelectedImagesCarousel>(find.byType(SelectedImagesCarousel));
      expect(carouselWidget.isReorderable, isFalse);
      expect(carouselWidget.showClearButton, isFalse);
      expect(find.byType(ReorderableListView), findsNothing);
      expect(find.byType(ListView), findsWidgets);
      expect(find.byIcon(Icons.close), findsNothing);
      expect(find.byIcon(Icons.delete_sweep), findsNothing);
    });

    testWidgets("Displays edit and play buttons stacked vertically on right edge", (tester) async {
      await storiesBox.put(
        0,
        ImageStory(
          id: '1',
          name: 'Story 1',
          images: [
            KuvariImage(uid: 1, name: 'Img 1', author: 'A', thumb: '', url: ''),
          ],
        ),
      );

      await tester.pumpWidget(createWidget());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.edit_outlined), findsOneWidget);
      expect(find.byIcon(Icons.play_arrow), findsWidgets);

      final editCenter = tester.getCenter(find.byIcon(Icons.edit_outlined));
      final playCenter = tester.getCenter(find.byIcon(Icons.play_arrow).first);
      final carouselRect = tester.getRect(find.byType(SelectedImagesCarousel));

      // Vertically stacked: edit above play
      expect(editCenter.dy, lessThan(playCenter.dy));
      // Horizontally aligned in the same right column
      expect((editCenter.dx - playCenter.dx).abs(), lessThan(5.0));
      // To the right of the carousel
      expect(editCenter.dx, greaterThan(carouselRect.right));
    });


    testWidgets("Tapping edit when hasActiveQueue is false pops with story", (tester) async {
      await storiesBox.put(
        0,
        ImageStory(
          id: '1',
          name: 'Story 1',
          images: [
            KuvariImage(uid: 1, name: 'Img 1', author: 'A', thumb: '', url: ''),
          ],
        ),
      );

      ImageStory? returnedStory;
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
              onPressed: () async {
                returnedStory = await Navigator.push<ImageStory>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SavedImageStoriesPage(
                      imageStoriesBox: storiesBox,
                      tagsBox: tagsBox,
                      hasActiveQueue: false,
                    ),
                  ),
                );
              },
              child: const Text('Open'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.edit_outlined), findsOneWidget);
      await tester.tap(find.byIcon(Icons.edit_outlined));
      await tester.pumpAndSettle();

      expect(returnedStory, isNotNull);
      expect(returnedStory!.name, 'Story 1');
    });

    testWidgets("Tapping edit when hasActiveQueue is true shows warning dialog", (tester) async {
      await storiesBox.put(
        0,
        ImageStory(
          id: '1',
          name: 'Story 1',
          images: [
            KuvariImage(uid: 1, name: 'Img 1', author: 'A', thumb: '', url: ''),
          ],
        ),
      );

      ImageStory? returnedStory;
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
              onPressed: () async {
                returnedStory = await Navigator.push<ImageStory>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SavedImageStoriesPage(
                      imageStoriesBox: storiesBox,
                      tagsBox: tagsBox,
                      hasActiveQueue: true,
                      activeQueueCount: 3,
                    ),
                  ),
                );
              },
              child: const Text('Open'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      // Tap edit button
      await tester.tap(find.byIcon(Icons.edit_outlined));
      await tester.pumpAndSettle();

      // Warning dialog should appear
      expect(find.text('Korvataanko nykyinen kuvajono?'), findsOneWidget);
      expect(find.textContaining('3 kuvaa'), findsOneWidget);

      // Tap cancel
      await tester.tap(find.text('Peruuta'));
      await tester.pumpAndSettle();

      expect(returnedStory, isNull);
      expect(find.text('Story 1'), findsOneWidget);

      // Tap edit again and confirm
      await tester.tap(find.byIcon(Icons.edit_outlined));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Korvaa ja muokkaa'));
      await tester.pumpAndSettle();

      expect(returnedStory, isNotNull);
      expect(returnedStory!.name, 'Story 1');
    });
  });
}
