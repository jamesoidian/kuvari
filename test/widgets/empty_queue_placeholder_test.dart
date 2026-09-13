import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kuvari_app/l10n/app_localizations.dart';
import 'package:kuvari_app/widgets/empty_queue_placeholder.dart';

void main() {
  Widget createWidget({Locale locale = const Locale('fi'), VoidCallback? onTap}) {
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
        body: EmptyQueuePlaceholder(onTap: onTap),
      ),
    );
  }

  group('EmptyQueuePlaceholder Widget Tests', () {
    testWidgets('renders collection icon and localized Finnish text for fi locale', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget(locale: const Locale('fi')));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.collections_bookmark_outlined), findsOneWidget);
      expect(
        find.text('Valitsemasi kuvat tulevat tähän jonoon. Voit koota viestin, päiväjärjestyksen tai valintataulun.'),
        findsOneWidget,
      );
    });

    testWidgets('renders localized Swedish text for sv locale', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget(locale: const Locale('sv')));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.collections_bookmark_outlined), findsOneWidget);
      expect(
        find.text('Dina valda bilder hamnar i denna sekvens. Du kan skapa ett meddelande, en dagsordning eller en valbricka.'),
        findsOneWidget,
      );
    });

    testWidgets('renders localized English text for en locale', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget(locale: const Locale('en')));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.collections_bookmark_outlined), findsOneWidget);
      expect(
        find.text('Your selected images appear in this queue. You can compose a message, daily schedule, or choice board.'),
        findsOneWidget,
      );
    });

    testWidgets('invokes onTap callback when tapped', (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(createWidget(onTap: () => tapped = true));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(EmptyQueuePlaceholder));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('provides accessibility semantics with button and guidance label', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget(locale: const Locale('fi')));
      await tester.pumpAndSettle();

      final semanticsFinder = find.descendant(
        of: find.byType(EmptyQueuePlaceholder),
        matching: find.byWidgetPredicate(
          (widget) => widget is Semantics && widget.properties.button == true,
        ),
      );
      expect(semanticsFinder, findsOneWidget);

      final semanticsWidget = tester.widget<Semantics>(semanticsFinder);
      expect(
        semanticsWidget.properties.label,
        'Valitsemasi kuvat tulevat tähän jonoon. Voit koota viestin, päiväjärjestyksen tai valintataulun.',
      );
      expect(semanticsWidget.properties.hint, 'Hae kuvia hakusanalla esim. hymy');
    });
  });
}
