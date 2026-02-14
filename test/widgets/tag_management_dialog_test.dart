import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kuvari_app/models/tag.dart';
import 'package:kuvari_app/models/image_story.dart';
import 'package:kuvari_app/widgets/tag_management_dialog.dart';
import 'package:kuvari_app/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class FakeTagBox extends Fake implements Box<Tag> {
  final List<Tag> _values = [];
  final List<VoidCallback> _listeners = [];

  @override
  Iterable<Tag> get values => _values;

  @override
  Future<int> add(Tag value) {
    _values.add(value);
    for (var listener in _listeners) {
      listener();
    }
    return Future.value(_values.length - 1);
  }

  ValueListenable<Box<Tag>> listenable({List<dynamic>? keys}) {
    return _FakeBoxListenable(this);
  }

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  @override
  Stream<BoxEvent> watch({dynamic key}) {
    return const Stream.empty();
  }
}

class _FakeBoxListenable extends ValueListenable<Box<Tag>> {
  final FakeTagBox box;
  _FakeBoxListenable(this.box);

  @override
  void addListener(VoidCallback listener) {
    box.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {}

  @override
  Box<Tag> get value => box;
}

class FakeStoryBox extends Fake implements Box<ImageStory> {
  @override
  Iterable<ImageStory> get values => [];

  @override
  Stream<BoxEvent> watch({dynamic key}) {
    return const Stream.empty();
  }
}

void main() {
  late FakeTagBox box;
  late FakeStoryBox storyBox;

  setUp(() {
    box = FakeTagBox();
    storyBox = FakeStoryBox();
  });

  Widget createWidgetUnderTest(List<String> initialTagIds) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('fi', ''),
        Locale('sv', ''),
      ],
      home: Scaffold(
        body: TagManagementDialog(
          initialTagIds: initialTagIds,
          tagsBox: box,
          imageStoriesBox: storyBox,
        ),
      ),
    );
  }

  testWidgets('TagManagementDialog displays tags and allows toggling', (WidgetTester tester) async {
    await box.add(Tag(name: 'Tag 1', id: 't1'));
    await box.add(Tag(name: 'Tag 2', id: 't2'));

    await tester.pumpWidget(createWidgetUnderTest(['t1']));
    await tester.pump();

    expect(find.text('Tag 1'), findsOneWidget);
    expect(find.text('Tag 2'), findsOneWidget);

    // Verify initial selection
    // Note:at(0) might be the search field if it was a text field, but we are looking for Checkbox
    expect(tester.widget<Checkbox>(find.byType(Checkbox).at(0)).value, isTrue);
    expect(tester.widget<Checkbox>(find.byType(Checkbox).at(1)).value, isFalse);

    // Toggle Tag 2
    await tester.tap(find.text('Tag 2'));
    await tester.pump();

    expect(tester.widget<Checkbox>(find.byType(Checkbox).at(1)).value, isTrue);
  });

  testWidgets('TagManagementDialog can create new tags', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest([]));
    await tester.pump();

    await tester.tap(find.text('Add Tag'));
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Create Tag'), findsOneWidget);
    
    final createTagDialog = find.byType(AlertDialog).last;
    await tester.enterText(find.descendant(of: createTagDialog, matching: find.byType(TextField)), 'New Custom Tag');
    await tester.pump(); // Ensure state updates after text entry
    await tester.tap(find.descendant(of: createTagDialog, matching: find.byType(ElevatedButton)));
    await tester.pumpAndSettle();

    expect(find.text('New Custom Tag'), findsOneWidget);
    expect(box.values.any((t) => t.name == 'New Custom Tag'), isTrue);
  });
}
