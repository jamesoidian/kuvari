import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kuvari_app/widgets/category_selection_dialog.dart';

void main() {
  group('CategorySelectionDialog Tests', () {
    testWidgets('displays all categories with correct initial selections', (WidgetTester tester) async {
      final selectedCategories = ['arasaac', 'kuvako'];

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
          home: CategorySelectionDialog(selectedCategories: selectedCategories),
        ),
      );

      // Verify all categories are displayed
      expect(find.byType(CheckboxListTile), findsNWidgets(8));

      // Verify initial selections
      expect(tester.widget<CheckboxListTile>(find.byType(CheckboxListTile).at(0)).value, isTrue);
      expect(tester.widget<CheckboxListTile>(find.byType(CheckboxListTile).at(1)).value, isTrue);
    });

    testWidgets('prevents deselecting last category', (WidgetTester tester) async {
      final selectedCategories = ['arasaac'];

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
          home: CategorySelectionDialog(selectedCategories: selectedCategories),
        ),
      );

      // Try to deselect the only selected category
      await tester.tap(find.byType(CheckboxListTile).first);
      await tester.pump();

      // Verify it's still selected
      expect(tester.widget<CheckboxListTile>(find.byType(CheckboxListTile).first).value, isTrue);
    });

    testWidgets('returns selected categories when OK is pressed', (WidgetTester tester) async {
      final selectedCategories = ['arasaac', 'kuvako'];
      List<String>? result;

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
          home: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () async {
                result = await showDialog<List<String>>(
                  context: context,
                  builder: (context) => CategorySelectionDialog(
                    selectedCategories: selectedCategories,
                  ),
                );
              },
              child: const Text('Open Dialog'),
            ),
          ),
        ),
      );

      // Open dialog
      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      // Tap OK button
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      // Verify returned categories match initial selection
      expect(result, equals(selectedCategories));
    });
  });
}
