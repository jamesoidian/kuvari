// test/widgets/edit_mode_save_dialog_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kuvari_app/l10n/app_localizations.dart';
import 'package:kuvari_app/widgets/edit_mode_save_dialog.dart';

void main() {
  group('EditModeSaveDialog Widget Tests', () {
    Widget createDialogHost({
      required String storyName,
      required void Function(EditModeSaveResult? result) onResult,
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
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final res = await showDialog<EditModeSaveResult>(
                      context: context,
                      builder: (_) => EditModeSaveDialog(storyName: storyName),
                    );
                    onResult(res);
                  },
                  child: const Text('Open Dialog'),
                ),
              ),
            );
          },
        ),
      );
    }

    testWidgets('Renders both selection cards in Finnish', (tester) async {
      await tester.pumpWidget(createDialogHost(
        storyName: 'Aamutoimet',
        onResult: (_) {},
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Tallenna kuvajono'), findsOneWidget);
      expect(find.text('Päivitä: Aamutoimet'), findsOneWidget);
      expect(find.text('Korvaa tallennettu versio säilyttäen tägit'), findsOneWidget);
      expect(find.text('Tallenna uutena kuvajonona...'), findsOneWidget);
      expect(find.text('Luo uusi kuvajono uudella nimellä'), findsOneWidget);
      expect(find.text('Peruuta'), findsOneWidget);
    });

    testWidgets('Tapping Päivitä pops with UpdateExistingStoryResult', (tester) async {
      EditModeSaveResult? returnedResult;
      await tester.pumpWidget(createDialogHost(
        storyName: 'Aamutoimet',
        onResult: (res) => returnedResult = res,
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Päivitä: Aamutoimet'));
      await tester.pumpAndSettle();

      expect(returnedResult, isA<UpdateExistingStoryResult>());
      expect(find.byType(EditModeSaveDialog), findsNothing);
    });

    testWidgets('Tapping Tallenna uutena transitions to name input with prefilled copy name', (tester) async {
      await tester.pumpWidget(createDialogHost(
        storyName: 'Aamutoimet',
        onResult: (_) {},
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Tallenna uutena kuvajonona...'));
      await tester.pumpAndSettle();

      expect(find.text('Tallenna uutena'), findsOneWidget);
      expect(find.text('Aamutoimet (kopio)'), findsOneWidget);
      expect(find.text('Takaisin'), findsOneWidget);
      expect(find.text('Tallenna'), findsOneWidget);
    });

    testWidgets('Tapping Takaisin in name input returns to selection cards', (tester) async {
      await tester.pumpWidget(createDialogHost(
        storyName: 'Aamutoimet',
        onResult: (_) {},
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Tallenna uutena kuvajonona...'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Takaisin'));
      await tester.pumpAndSettle();

      expect(find.text('Päivitä: Aamutoimet'), findsOneWidget);
      expect(find.text('Tallenna uutena kuvajonona...'), findsOneWidget);
    });

    testWidgets('Submitting new name pops with SaveAsNewStoryResult', (tester) async {
      EditModeSaveResult? returnedResult;
      await tester.pumpWidget(createDialogHost(
        storyName: 'Aamutoimet',
        onResult: (res) => returnedResult = res,
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Tallenna uutena kuvajonona...'));
      await tester.pumpAndSettle();

      // Submit prefilled name
      await tester.tap(find.text('Tallenna'));
      await tester.pumpAndSettle();

      expect(returnedResult, isA<SaveAsNewStoryResult>());
      expect((returnedResult as SaveAsNewStoryResult).name, 'Aamutoimet (kopio)');
      expect(find.byType(EditModeSaveDialog), findsNothing);
    });

    testWidgets('Entering custom name pops with custom name in SaveAsNewStoryResult', (tester) async {
      EditModeSaveResult? returnedResult;
      await tester.pumpWidget(createDialogHost(
        storyName: 'Aamutoimet',
        onResult: (res) => returnedResult = res,
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Tallenna uutena kuvajonona...'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Iltatoimet');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Tallenna'));
      await tester.pumpAndSettle();

      expect(returnedResult, isA<SaveAsNewStoryResult>());
      expect((returnedResult as SaveAsNewStoryResult).name, 'Iltatoimet');
    });

    testWidgets('Pressing Peruuta pops with null', (tester) async {
      EditModeSaveResult? returnedResult = const UpdateExistingStoryResult();
      await tester.pumpWidget(createDialogHost(
        storyName: 'Aamutoimet',
        onResult: (res) => returnedResult = res,
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Peruuta'));
      await tester.pumpAndSettle();

      expect(returnedResult, isNull);
      expect(find.byType(EditModeSaveDialog), findsNothing);
    });

    testWidgets('Renders Swedish translations correctly', (tester) async {
      await tester.pumpWidget(createDialogHost(
        storyName: 'Morgonrutin',
        locale: const Locale('sv'),
        onResult: (_) {},
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Uppdatera: Morgonrutin'), findsOneWidget);
      expect(find.text('Ersätter den sparade versionen och behåller taggar'), findsOneWidget);
      expect(find.text('Spara som ny bildsekvens...'), findsOneWidget);
      expect(find.text('Avbryt'), findsOneWidget);

      await tester.tap(find.text('Spara som ny bildsekvens...'));
      await tester.pumpAndSettle();

      expect(find.text('Spara som ny'), findsOneWidget);
      expect(find.text('Morgonrutin (kopia)'), findsOneWidget);
      expect(find.text('Tillbaka'), findsOneWidget);
      expect(find.text('Spara'), findsOneWidget);
    });
  });
}
