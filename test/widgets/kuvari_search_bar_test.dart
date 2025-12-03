import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kuvari_app/l10n/app_localizations.dart';
import 'package:kuvari_app/widgets/kuvari_search_bar.dart';

void main() {
  group('KuvariSearchBar Widget Tests', () {
    testWidgets('Displays clear button when text is entered and calls onClear when pressed', (WidgetTester tester) async {
      final controller = TextEditingController();

      bool onClearCalled = false;

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
          home: Scaffold(
            body: KuvariSearchBar(
              controller: controller,
              onSearch: () {},
              onClear: () { 
                onClearCalled = true; 
                controller.clear(); // Tyhjennä tekstikenttä
              },
              onTap: () {}, // Add required onTap callback
            ),
          ),
        ),
      );
      await tester.pump();

      // Aluksi ei ole tekstiä, joten clear-painiketta ei pitäisi löytyä
      expect(find.byIcon(Icons.clear), findsNothing);

      // Syötä tekstiä
      await tester.enterText(find.byType(TextField), 'test');
      await tester.pump();

      // Nyt clear-painike pitäisi näkyä
      expect(find.byIcon(Icons.clear), findsOneWidget);

      // Paina clear-painiketta
      await tester.tap(find.byIcon(Icons.clear));
      await tester.pump();

      // Varmista, että onClear callback on kutsuttu
      expect(onClearCalled, isTrue);

      // Varmista, että tekstikenttä on tyhjä
      expect(controller.text, '');
    });

    testWidgets('Calls onTap when the search field is tapped', (WidgetTester tester) async {
      final controller = TextEditingController();
      bool onTapCalled = false;

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
          home: Scaffold(
            body: KuvariSearchBar(
              controller: controller,
              onSearch: () {},
              onClear: () {},
              onTap: () { onTapCalled = true; },
            ),
          ),
        ),
      );
      await tester.pump();
      
      expect(find.byType(TextField), findsOneWidget);

      // Tapaa tekstikenttää
      await tester.tap(find.byType(TextField));
      await tester.pump();

      // Varmista, että onTap-callback kutsutaan
      expect(onTapCalled, isTrue);
    });
  });
}
