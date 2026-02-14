// lib/services/storage_service.dart

import 'package:hive_flutter/hive_flutter.dart';
import 'package:kuvari_app/models/image_story.dart';
import 'package:kuvari_app/models/kuvari_image.dart';
import 'package:kuvari_app/models/tag.dart';
import 'package:kuvari_app/services/storage_constants.dart';

class StorageService {
  static Future<void> init({String? path}) async {
    if (path != null) {
      Hive.init(path);
    } else {
      await Hive.initFlutter();
    }

    // Register Adapters
    Hive.registerAdapter(ImageStoryAdapter());
    Hive.registerAdapter(KuvariImageAdapter());
    Hive.registerAdapter(TagAdapter());

    // Open Boxes
    await Hive.openBox<ImageStory>(StorageConstants.imageStoriesBox);
    await Hive.openBox<Tag>(StorageConstants.tagsBox);
  }
}
