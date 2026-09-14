// test/pages/home_page_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kuvari_app/l10n/app_localizations.dart';
import 'package:kuvari_app/models/kuvari_image.dart';
import 'package:kuvari_app/models/image_story.dart';
import 'package:kuvari_app/pages/home_page.dart';
import 'package:kuvari_app/pages/image_viewer_page.dart';
import 'package:kuvari_app/services/kuvari_service.dart';
import 'package:kuvari_app/widgets/empty_queue_placeholder.dart';
import 'package:kuvari_app/widgets/edit_mode_banner.dart';
import 'package:kuvari_app/widgets/selected_images_carousel.dart';
import 'package:kuvari_app/widgets/home_app_bar.dart';
import 'package:kuvari_app/widgets/home_search_section.dart';
import 'package:hive/hive.dart';
import 'package:kuvari_app/widgets/edit_mode_save_dialog.dart';
import 'home_page_test.mocks.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

// Määrittele mock-objekti
class FakeFirebaseAnalytics extends Fake implements FirebaseAnalytics {
  @override
  Future<void> logEvent({
    AnalyticsCallOptions? callOptions,
    required String name,
    Map<String, Object>? parameters,
    List<AnalyticsEventItem>? items,
  }) async {
    // Do nothing in tests
  }
}

class FakeHiveBox<T> extends Fake implements Box<T> {
  final Map<dynamic, T> items = {};

  @override
  Iterable<T> get values => items.values;

  @override
  Iterable<dynamic> get keys => items.keys;

  @override
  T? get(dynamic key, {T? defaultValue}) => items[key] ?? defaultValue;

  @override
  Future<void> put(dynamic key, T value) async {
    items[key] = value;
  }

  @override
  Future<int> add(T value) async {
    final key = items.length;
    items[key] = value;
    return key;
  }
}

@GenerateMocks([KuvariService])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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

  group('HomePage Widget Tests', () {
    late MockKuvariService mockKuvariService;

    setUp(() {
      mockKuvariService = MockKuvariService();
    });

    Widget createHomePage({
      Locale locale = const Locale('fi'),
      Box<ImageStory>? imageStoriesBox,
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
        home: HomePage(
          kuvariService: mockKuvariService,
          setLocale: (_) {},
          analytics: FakeFirebaseAnalytics(),
          imageStoriesBox: imageStoriesBox,
        ),
      );
    }

    testWidgets('Displays images after successful search', (WidgetTester tester) async {
      when(mockKuvariService.searchImages('test', any, any))
          .thenAnswer((_) async => mockImages);

      await tester.pumpWidget(createHomePage());
      await tester.pump();

      await tester.enterText(find.byType(TextField), 'test');
      await tester.tap(find.byIcon(Icons.search_outlined));
      await tester.pump();
      await tester.pump(const Duration(seconds: 2));

      expect(find.byType(Image), findsNWidgets(2));
    });

    testWidgets('Displays error message on failed search', (WidgetTester tester) async {
      when(mockKuvariService.searchImages('test', any, any))
          .thenThrow(Exception('Failed to load images'));

      await tester.pumpWidget(createHomePage());
      await tester.pump();

      await tester.enterText(find.byType(TextField), 'test');
      await tester.tap(find.byIcon(Icons.search_outlined));
      await tester.pump();
      await tester.pump(const Duration(seconds: 2));

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Virhe haussa: Exception: Failed to load images'), findsOneWidget);
    });

    testWidgets('Displays HomeSearchSection widget', (WidgetTester tester) async {
      await tester.pumpWidget(createHomePage());
      expect(find.byType(HomeSearchSection), findsOneWidget);
    });

    testWidgets('Empty queue displays placeholder and hides FAB', (WidgetTester tester) async {
      await tester.pumpWidget(createHomePage());
      await tester.pump();

      expect(find.byType(EmptyQueuePlaceholder), findsOneWidget);
      final crossFade = tester.widget<AnimatedCrossFade>(find.byType(AnimatedCrossFade));
      expect(crossFade.crossFadeState, CrossFadeState.showFirst);
      expect(find.byType(FloatingActionButton), findsNothing);
    });

    testWidgets('Tapping EmptyQueuePlaceholder focuses search TextField (D-03)', (WidgetTester tester) async {
      await tester.pumpWidget(createHomePage());
      await tester.pump();

      final searchTextField = tester.widget<TextField>(find.byType(TextField));
      expect(searchTextField.focusNode!.hasFocus, isFalse);

      await tester.tap(find.byType(EmptyQueuePlaceholder));
      await tester.pump();

      expect(searchTextField.focusNode!.hasFocus, isTrue);
    });

    testWidgets('Selecting image shows carousel, extended FAB with count, and allows navigation', (WidgetTester tester) async {
      when(mockKuvariService.searchImages('test', any, any))
          .thenAnswer((_) async => mockImages);

      await tester.pumpWidget(createHomePage());
      await tester.pump();

      // Search for images
      await tester.enterText(find.byType(TextField), 'test');
      await tester.tap(find.byIcon(Icons.search_outlined));
      await tester.pump();
      await tester.pump(const Duration(seconds: 2));

      // Select first image
      await tester.tap(find.byType(Image).first);
      await tester.pumpAndSettle();

      // Carousel is shown in crossfade
      final crossFade = tester.widget<AnimatedCrossFade>(find.byType(AnimatedCrossFade));
      expect(crossFade.crossFadeState, CrossFadeState.showSecond);

      // Extended FAB appears with dynamic count (D-05, D-07)
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.text('Näytä kuvajono (1)'), findsOneWidget);
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);

      // Select second image -> count updates to 2
      await tester.tap(find.byType(Image).last);
      await tester.pumpAndSettle();
      expect(find.text('Näytä kuvajono (2)'), findsOneWidget);

      // Tap FAB -> navigates to ImageViewerPage
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.byType(ImageViewerPage), findsOneWidget);

      // Return back to HomePage
      Navigator.of(tester.element(find.byType(ImageViewerPage))).pop();
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);

      // Clear the queue via delete_sweep icon
      await tester.tap(find.byIcon(Icons.delete_sweep));
      await tester.pumpAndSettle();

      // Confirm dialog opens -> tap "Tyhjennä"
      expect(find.text('Tyhjennä kuvajono'), findsOneWidget);
      await tester.tap(find.text('Tyhjennä'));
      await tester.pumpAndSettle();

      // FAB is hidden and crossfade returns to placeholder (D-08, D-09)
      expect(find.byType(FloatingActionButton), findsNothing);
      final crossFadeAfterClear = tester.widget<AnimatedCrossFade>(find.byType(AnimatedCrossFade));
      expect(crossFadeAfterClear.crossFadeState, CrossFadeState.showFirst);
    });

    testWidgets('Opening saved story for editing populates queue and shows SnackBar', (tester) async {
      await tester.pumpWidget(createHomePage());
      await tester.pumpAndSettle();

      final homeAppBar = tester.widget<HomeAppBar>(find.byType(HomeAppBar));
      expect(homeAppBar.onEditStory, isNotNull);

      final story = ImageStory(
        id: 'test-story-1',
        name: 'Aamutoimet',
        images: mockImages,
      );

      homeAppBar.onEditStory!(story);
      await tester.pumpAndSettle();

      final crossFade = tester.widget<AnimatedCrossFade>(find.byType(AnimatedCrossFade));
      expect(crossFade.crossFadeState, CrossFadeState.showSecond);
      expect(find.text('Näytä kuvajono (2)'), findsOneWidget);
      expect(find.text('Muokataan kuvajonoa: Aamutoimet'), findsOneWidget);
    });

    testWidgets('EditModeBanner is displayed when in edit mode', (tester) async {
      await tester.pumpWidget(createHomePage());
      await tester.pumpAndSettle();

      final homeAppBar = tester.widget<HomeAppBar>(find.byType(HomeAppBar));
      final story = ImageStory(
        id: 'test-story-1',
        name: 'Aamutoimet',
        images: mockImages,
      );

      homeAppBar.onEditStory!(story);
      await tester.pumpAndSettle();

      expect(find.byType(EditModeBanner), findsOneWidget);
      expect(find.text('Muokataan: Aamutoimet'), findsOneWidget);
      expect(find.text('Tallenna'), findsOneWidget);
      expect(find.byTooltip('Lopeta muokkaus'), findsOneWidget);
    });

    testWidgets('Tapping clear in edit mode prompts confirmation dialog', (tester) async {
      await tester.pumpWidget(createHomePage());
      await tester.pumpAndSettle();

      final homeAppBar = tester.widget<HomeAppBar>(find.byType(HomeAppBar));
      final story = ImageStory(
        id: 'test-story-1',
        name: 'Aamutoimet',
        images: mockImages,
      );

      homeAppBar.onEditStory!(story);
      await tester.pumpAndSettle();

      // Tap clear queue button (delete_sweep icon)
      await tester.tap(find.byIcon(Icons.delete_sweep));
      await tester.pumpAndSettle();

      // Verify edit mode clear dialog is shown
      expect(find.text('Tyhjennetäänkö kuvajono?'), findsOneWidget);
      expect(find.text('Haluatko varmasti tyhjentää muokattavan kuvajonon kaikki kuvat?'), findsOneWidget);

      // Cancel clearing
      await tester.tap(find.text('Peruuta'));
      await tester.pumpAndSettle();

      // Images remain
      expect(find.text('Näytä kuvajono (2)'), findsOneWidget);
      expect(find.byType(EditModeBanner), findsOneWidget);

      // Tap clear again and confirm
      await tester.tap(find.byIcon(Icons.delete_sweep));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Tyhjennä'));
      await tester.pumpAndSettle();

      // Queue is cleared
      expect(find.byType(FloatingActionButton), findsNothing);
    });

    testWidgets('Exiting edit mode without changes exits immediately', (tester) async {
      await tester.pumpWidget(createHomePage());
      await tester.pumpAndSettle();

      final homeAppBar = tester.widget<HomeAppBar>(find.byType(HomeAppBar));
      final story = ImageStory(
        id: 'test-story-1',
        name: 'Aamutoimet',
        images: mockImages,
      );

      homeAppBar.onEditStory!(story);
      await tester.pumpAndSettle();

      // Stop editing
      await tester.tap(find.byTooltip('Lopeta muokkaus'));
      await tester.pumpAndSettle();

      // No confirmation dialog was shown
      expect(find.byType(AlertDialog), findsNothing);
      // Banner and queue are cleared
      expect(find.byType(EditModeBanner), findsNothing);
      expect(find.byType(FloatingActionButton), findsNothing);
    });

    testWidgets('Exiting edit mode with changes prompts discard dialog', (tester) async {
      await tester.pumpWidget(createHomePage());
      await tester.pumpAndSettle();

      final homeAppBar = tester.widget<HomeAppBar>(find.byType(HomeAppBar));
      final story = ImageStory(
        id: 'test-story-1',
        name: 'Aamutoimet',
        images: mockImages,
      );

      homeAppBar.onEditStory!(story);
      await tester.pumpAndSettle();

      // Modify queue: remove first image via carousel remove button
      final removeButtons = find.descendant(
        of: find.byType(SelectedImagesCarousel),
        matching: find.byIcon(Icons.close),
      );
      await tester.tap(removeButtons.first);
      await tester.pumpAndSettle();

      expect(find.text('Näytä kuvajono (1)'), findsOneWidget);

      // Try to stop editing
      await tester.tap(find.byTooltip('Lopeta muokkaus'));
      await tester.pumpAndSettle();

      // Discard confirmation dialog is shown
      expect(find.text('Lopetetaanko muokkaus?'), findsOneWidget);
      expect(
        find.text('Kuvajonoon on tehty muutoksia, joita ei ole tallennettu. Haluatko varmasti hylätä muutokset?'),
        findsOneWidget,
      );

      // Cancel discard
      await tester.tap(find.text('Peruuta'));
      await tester.pumpAndSettle();
      expect(find.byType(EditModeBanner), findsOneWidget);

      // Tap stop again and confirm discard
      await tester.tap(find.byTooltip('Lopeta muokkaus'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Hylkää muutokset'));
      await tester.pumpAndSettle();

      // Edit mode exited
      expect(find.byType(EditModeBanner), findsNothing);
      expect(find.byType(FloatingActionButton), findsNothing);
    });

    testWidgets('PopScope prompts discard dialog when back navigation invoked with changes', (tester) async {
      await tester.pumpWidget(createHomePage());
      await tester.pumpAndSettle();

      final homeAppBar = tester.widget<HomeAppBar>(find.byType(HomeAppBar));
      final story = ImageStory(
        id: 'test-story-1',
        name: 'Aamutoimet',
        images: mockImages,
      );

      homeAppBar.onEditStory!(story);
      await tester.pumpAndSettle();

      // Modify queue: remove first image
      final removeButtons = find.descendant(
        of: find.byType(SelectedImagesCarousel),
        matching: find.byIcon(Icons.close),
      );
      await tester.tap(removeButtons.first);
      await tester.pumpAndSettle();

      // Trigger pop
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();

      // Discard confirmation dialog should appear
      expect(find.text('Lopetetaanko muokkaus?'), findsOneWidget);
    });

    testWidgets('Saving in edit mode with Päivitä updates story in Hive and resets queue', (tester) async {
      final fakeBox = FakeHiveBox<ImageStory>();
      final originalStory = ImageStory(
        id: 'story-1',
        name: 'Aamutoimet',
        images: [mockImages.first],
        tagIds: ['tag-1'],
      );
      await fakeBox.put(0, originalStory);

      await tester.pumpWidget(createHomePage(imageStoriesBox: fakeBox));
      await tester.pumpAndSettle();

      final homeAppBar = tester.widget<HomeAppBar>(find.byType(HomeAppBar));
      homeAppBar.onEditStory!(originalStory);
      await tester.pumpAndSettle();

      // Tap Tallenna in EditModeBanner
      final saveButton = find.descendant(
        of: find.byType(EditModeBanner),
        matching: find.text('Tallenna'),
      );
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      // EditModeSaveDialog appears
      expect(find.byType(EditModeSaveDialog), findsOneWidget);
      expect(find.text('Päivitä: Aamutoimet'), findsOneWidget);

      // Tap Päivitä
      await tester.tap(find.text('Päivitä: Aamutoimet'));
      await tester.pumpAndSettle();

      // Verify Hive updated
      expect(fakeBox.values.length, 1);
      final updated = fakeBox.values.first;
      expect(updated.id, 'story-1');
      expect(updated.name, 'Aamutoimet');
      expect(updated.tagIds, ['tag-1']);

      // Verify feedback and state reset
      expect(find.text('Kuvajono "Aamutoimet" päivitetty.'), findsOneWidget);
      expect(find.byType(EditModeBanner), findsNothing);
      expect(find.byType(FloatingActionButton), findsNothing);
    });

    testWidgets('Saving in edit mode with Tallenna uutena creates new story in Hive and resets queue', (tester) async {
      final fakeBox = FakeHiveBox<ImageStory>();
      final originalStory = ImageStory(
        id: 'story-1',
        name: 'Aamutoimet',
        images: mockImages,
        tagIds: ['tag-1'],
      );
      await fakeBox.put(0, originalStory);

      await tester.pumpWidget(createHomePage(imageStoriesBox: fakeBox));
      await tester.pumpAndSettle();

      final homeAppBar = tester.widget<HomeAppBar>(find.byType(HomeAppBar));
      homeAppBar.onEditStory!(originalStory);
      await tester.pumpAndSettle();

      // Tap Tallenna in EditModeBanner
      final saveButton = find.descendant(
        of: find.byType(EditModeBanner),
        matching: find.text('Tallenna'),
      );
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      // Tap Tallenna uutena kuvajonona...
      await tester.tap(find.text('Tallenna uutena kuvajonona...'));
      await tester.pumpAndSettle();

      // Name field prefilled with 'Aamutoimet (kopio)'
      expect(find.text('Aamutoimet (kopio)'), findsOneWidget);

      // Tap Tallenna in dialog
      final dialogSaveButton = find.descendant(
        of: find.byType(EditModeSaveDialog),
        matching: find.text('Tallenna'),
      );
      await tester.tap(dialogSaveButton);
      await tester.pumpAndSettle();

      // Verify 2 stories in Hive
      expect(fakeBox.values.length, 2);
      final original = fakeBox.values.first;
      final copy = fakeBox.values.last;
      expect(original.name, 'Aamutoimet');
      expect(copy.name, 'Aamutoimet (kopio)');
      expect(copy.id, isNot('story-1'));

      // Verify feedback and state reset
      expect(find.text('Kuvajono "Aamutoimet (kopio)" tallennettu.'), findsOneWidget);
      expect(find.byType(EditModeBanner), findsNothing);
      expect(find.byType(FloatingActionButton), findsNothing);
    });

    testWidgets('Cancelling save dialog in edit mode preserves edit mode and queue', (tester) async {
      final fakeBox = FakeHiveBox<ImageStory>();
      final originalStory = ImageStory(
        id: 'story-1',
        name: 'Aamutoimet',
        images: mockImages,
      );
      await fakeBox.put(0, originalStory);

      await tester.pumpWidget(createHomePage(imageStoriesBox: fakeBox));
      await tester.pumpAndSettle();

      final homeAppBar = tester.widget<HomeAppBar>(find.byType(HomeAppBar));
      homeAppBar.onEditStory!(originalStory);
      await tester.pumpAndSettle();

      // Tap Tallenna in EditModeBanner
      final saveButton = find.descendant(
        of: find.byType(EditModeBanner),
        matching: find.text('Tallenna'),
      );
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      // Tap Peruuta
      await tester.tap(find.text('Peruuta'));
      await tester.pumpAndSettle();

      // EditModeBanner and queue remain active
      expect(find.byType(EditModeBanner), findsOneWidget);
      expect(find.text('Näytä kuvajono (2)'), findsOneWidget);
      expect(fakeBox.values.length, 1);
    });

    testWidgets('Standard save outside edit mode saves new story and clears queue', (tester) async {
      final fakeBox = FakeHiveBox<ImageStory>();
      when(mockKuvariService.searchImages('test', any, any))
          .thenAnswer((_) async => mockImages);

      await tester.pumpWidget(createHomePage(imageStoriesBox: fakeBox));
      await tester.pump();

      // Search and select image
      await tester.enterText(find.byType(TextField), 'test');
      await tester.tap(find.byIcon(Icons.search_outlined));
      await tester.pump();
      await tester.pump(const Duration(seconds: 2));

      await tester.tap(find.byType(Image).first);
      await tester.pumpAndSettle();

      // Trigger save via HomeAppBar
      final homeAppBar = tester.widget<HomeAppBar>(find.byType(HomeAppBar));
      homeAppBar.onSave();
      await tester.pumpAndSettle();

      // Standard save dialog appears
      expect(find.text('Tallenna kuvajono'), findsOneWidget);
      expect(find.byType(TextField), findsWidgets);

      // Enter name and save
      await tester.enterText(find.byType(TextField).last, 'Uusi kuvajono');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Tallenna'));
      await tester.pumpAndSettle();

      expect(fakeBox.values.length, 1);
      expect(fakeBox.values.first.name, 'Uusi kuvajono');
      expect(find.text('Kuvajono "Uusi kuvajono" tallennettu.'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsNothing);
    });
  });
}
