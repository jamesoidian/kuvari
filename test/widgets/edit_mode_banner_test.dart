// test/widgets/edit_mode_banner_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kuvari_app/l10n/app_localizations.dart';
import 'package:kuvari_app/widgets/edit_mode_banner.dart';

void main() {
  group('EditModeBanner Widget Tests', () {
    Widget createBanner({
      required String storyName,
      required VoidCallback onSave,
      required VoidCallback onStop,
      Locale locale = const Locale('fi'),
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
        home: Scaffold(
          body: EditModeBanner(
            storyName: storyName,
            onSave: onSave,
            onStop: onStop,
          ),
        ),
      );
    }

    testWidgets('Renders story name, edit icon, save button, and stop button in Finnish', (tester) async {
      await tester.pumpWidget(createBanner(
        storyName: 'Aamutoimet',
        onSave: () {},
        onStop: () {},
      ));
      await tester.pumpAndSettle();

      expect(find.text('Muokataan: Aamutoimet'), findsOneWidget);
      expect(find.byIcon(Icons.edit), findsOneWidget);
      expect(find.byIcon(Icons.save), findsOneWidget);
      expect(find.text('Tallenna'), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('Renders in Swedish', (tester) async {
      await tester.pumpWidget(createBanner(
        storyName: 'Morgonrutin',
        onSave: () {},
        onStop: () {},
        locale: const Locale('sv'),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Redigerar: Morgonrutin'), findsOneWidget);
      expect(find.text('Spara'), findsOneWidget);
    });

    testWidgets('Tapping save triggers onSave callback', (tester) async {
      bool saveCalled = false;
      await tester.pumpWidget(createBanner(
        storyName: 'Story',
        onSave: () => saveCalled = true,
        onStop: () {},
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Tallenna'));
      expect(saveCalled, isTrue);
    });

    testWidgets('Tapping stop triggers onStop callback', (tester) async {
      bool stopCalled = false;
      await tester.pumpWidget(createBanner(
        storyName: 'Story',
        onSave: () {},
        onStop: () => stopCalled = true,
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.close));
      expect(stopCalled, isTrue);
    });
  });
}
