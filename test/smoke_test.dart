// test/smoke_test.dart

import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:kuvari_app/models/image_story.dart';
import 'package:kuvari_app/models/tag.dart';
import 'package:kuvari_app/services/storage_service.dart';

void main() {
  test('StorageService initializes and opens all boxes', () async {
    // Setup temporary directory for Hive
    final tempDir = await Directory.systemTemp.createTemp('hive_test');
    
    try {
      // Initialize with path
      await StorageService.init(path: tempDir.path);

      // Verify boxes are open
      expect(Hive.isBoxOpen('imageStories'), isTrue);
      expect(Hive.isBoxOpen('tags'), isTrue);

      // Verify we can put data in them
      await Hive.box<Tag>('tags').add(Tag(name: 'Test Tag'));
      expect(Hive.box<Tag>('tags').length, 1);
    } finally {
      // Clean up
      await Hive.close();
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    }
  });
}
