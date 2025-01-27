// test/widgets/image_grid_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kuha_app/models/kuha_image.dart';
import 'package:kuha_app/widgets/kuha_search_bar.dart'; // Oletetaan, että tämä on oikea polku

void main() {
  group('KuhaSearchBar Widget Tests', () {
    testWidgets('Displays clear button when text is entered and calls onClear when pressed', (WidgetTester tester) async {
      final controller = TextEditingController();
      bool onSearchCalled = false;
      bool onClearCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: KuhaSearchBar(
              controller: controller,
              onSearch: () { onSearchCalled = true; },
              onClear: () { 
                onClearCalled = true; 
                controller.clear(); // Tyhjennä tekstikenttä
              },
            ),
          ),
        ),
      );

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
  });
}
