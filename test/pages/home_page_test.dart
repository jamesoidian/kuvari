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
import 'package:kuvari_app/widgets/home_app_bar.dart';
import 'package:kuvari_app/widgets/home_search_section.dart';
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

    Widget createHomePage({Locale locale = const Locale('fi')}) {
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
  });
}
