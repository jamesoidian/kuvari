import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kuvari_app/widgets/home_search_section.dart';
import 'package:kuvari_app/widgets/kuvari_search_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  testWidgets('HomeSearchSection displays KuvariSearchBar and filter button', (WidgetTester tester) async {
    bool filterCallbackCalled = false;
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
        home: Scaffold(
          body: HomeSearchSection(
            controller: TextEditingController(),
            onSearch: () {},
            onClear: () {},
            onTap: () {},
            onSelectCategories: () {
              filterCallbackCalled = true;
            },
            showFilterBadge: true,
          ),
        ),
      ),
    );
    expect(find.byType(KuvariSearchBar), findsOneWidget);
    expect(find.byIcon(Icons.filter_list), findsOneWidget);
    await tester.tap(find.byIcon(Icons.filter_list));
    expect(filterCallbackCalled, isTrue);
  });
}
