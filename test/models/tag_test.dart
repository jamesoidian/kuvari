// test/models/tag_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:kuvari_app/models/tag.dart';

void main() {
  group('Tag Model Test', () {
    test('Tag initialization sets name and auto-generates id', () {
      final tag = Tag(name: 'Category 1');
      expect(tag.name, 'Category 1');
      expect(tag.id, isNotEmpty);
    });

    test('Tag initialization works with explicit id', () {
      final tag = Tag(name: 'Subcategory', id: 'my-id');
      expect(tag.name, 'Subcategory');
      expect(tag.id, 'my-id');
    });

    test('Equality operator works based on id', () {
      final tag1 = Tag(name: 'Tag 1', id: 'id1');
      final tag2 = Tag(name: 'Tag 2', id: 'id1');
      final tag3 = Tag(name: 'Tag 1', id: 'id2');

      expect(tag1 == tag2, isTrue);
      expect(tag1 == tag3, isFalse);
    });
  });
}
