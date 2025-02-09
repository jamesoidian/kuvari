// lib/pages/saved_image_stories_page.dart

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kuvari_app/models/image_story.dart';
import 'package:kuvari_app/pages/image_viewer_page.dart';
import 'package:kuvari_app/widgets/selected_images_carousel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SavedImageStoriesPage extends StatefulWidget {
  const SavedImageStoriesPage({Key? key}) : super(key: key);

  @override
  State<SavedImageStoriesPage> createState() => _SavedImageStoriesPageState();
}

class _SavedImageStoriesPageState extends State<SavedImageStoriesPage> {
  final Box<ImageStory> imageStoriesBox = Hive.box<ImageStory>('imageStories');
  final Map<String, int> _currentStartIndices = {};
  int _maxVisibleImages = 1;

  void _updateMaxVisibleImages() {
    final double screenWidth = MediaQuery.of(context).size.width;
    const double imageWidth = 60.0;
    const double imageSpacing = 8.0;
    const double sidePadding = 16.0;
    const double buttonWidth = 48.0;

    final double availableWidth = screenWidth - sidePadding - (buttonWidth * 3);
    int maxImages = ((availableWidth + imageSpacing) / (imageWidth + imageSpacing)).floor();
    _maxVisibleImages = max(1, maxImages);
  }

  @override
  Widget build(BuildContext context) {
    _updateMaxVisibleImages();
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.savedImageStories)),
      body: ValueListenableBuilder(
        valueListenable: imageStoriesBox.listenable(),
        builder: (context, Box<ImageStory> box, _) {
          final stories = box.values.toList();

          if (stories.isEmpty) {
            return Center(
              child: Text(AppLocalizations.of(context)!.noSavedImageStories),
            );
          }

          return ListView.builder(
            itemCount: stories.length,
            itemBuilder: (context, index) {
              final ImageStory story = stories[index];

              return Dismissible(
                key: Key(story.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                onDismissed: (direction) {
                  story.delete();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context)!.imageStoryDeleted(story.name))),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(story.name),
                    subtitle: SelectedImagesCarousel(
                      selectedImages: story.images,
                      currentStartIndex: _currentStartIndices[story.id] ?? 0,
                      maxVisibleImages: _maxVisibleImages,
                      onScrollLeft: () {
                        setState(() {
                          _currentStartIndices[story.id] = ((_currentStartIndices[story.id] ?? 0) - _maxVisibleImages)
                              .clamp(0, max(0, story.images.length - _maxVisibleImages));
                        });
                      },
                      onScrollRight: () {
                        setState(() {
                          _currentStartIndices[story.id] = ((_currentStartIndices[story.id] ?? 0) + _maxVisibleImages)
                              .clamp(0, max(0, story.images.length - _maxVisibleImages));
                        });
                      },
                      onClear: () {},
                      onRemove: (i) {},
                      showClearButton: false,
                      onReorder: (int oldIndex, int newIndex) {},
                    ),
                    trailing: IconButton(
                      icon: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 30,
                          ),
                          Icon(
                            Icons.play_arrow,
                            color: Colors.teal,
                            size: 24,
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ImageViewerPage(images: story.images),
                          ),
                        );
                      },
                      tooltip: AppLocalizations.of(context)!.viewImageStory,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
