// test/image_story_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:kuvari_app/models/image_story.dart';
import 'package:kuvari_app/models/kuvari_image.dart';

void main() {
  group('ImageStory Model Test', () {
    test('ImageStory initializes with empty tagIds by default', () {
      final story = ImageStory(
        id: 'story-1',
        name: 'My Story',
        images: [
          KuvariImage(
            author: 'author',
            name: 'image',
            thumb: 'thumb',
            url: 'url',
            uid: 1,
          ),
        ],
      );

      expect(story.id, 'story-1');
      expect(story.name, 'My Story');
      expect(story.images.length, 1);
      expect(story.tagIds, isEmpty);
    });

    test('ImageStory initializes with provided tagIds', () {
      final story = ImageStory(
        id: 'story-2',
        name: 'Tagged Story',
        images: [],
        tagIds: ['tag-1', 'tag-2'],
      );

      expect(story.tagIds, ['tag-1', 'tag-2']);
    });
  });
}
