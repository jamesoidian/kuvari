// lib/models/image_story.dart

import 'package:hive/hive.dart';
import 'kuvari_image.dart';

part 'image_story.g.dart';

@HiveType(typeId: 0)
class ImageStory extends HiveObject {
  @HiveField(0)
  final String id; // Lisää id-kenttä

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<KuvariImage> images;

  @HiveField(3)
  final List<String> tagIds;

  ImageStory({
    required this.id,
    required this.name,
    required this.images,
    List<String>? tagIds,
  }) : tagIds = tagIds ?? [];
}
